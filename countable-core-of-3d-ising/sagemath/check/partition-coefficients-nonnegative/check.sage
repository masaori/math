# 分配多項式の係数の非負性（帰無モデル）の検証。
# 本文の証明の各行を、小さい箱の全数列挙で一行ずつ確かめる。
# 厳密計算（ZZ、ZZ[X]、有限集合の列挙）だけを使い、浮動小数点を使わない。

from itertools import product

polynomial_ring = PolynomialRing(ZZ, "X")
X = polynomial_ring.gen()


def box_sites(box_side):
    # def_box: V_L = {0..L-1}^3
    return [
        (ZZ(a), ZZ(b), ZZ(c))
        for a in range(box_side)
        for b in range(box_side)
        for c in range(box_side)
    ]


def inner_edges(box_side):
    # def_edge_set と def_endpoint_maps: 始点・方向から得る二端点を順序なしの組で列挙
    sites = set(box_sites(box_side))
    edges = set()
    for u in sites:
        for axis in range(3):
            v = list(u)
            v[axis] = v[axis] + 1
            v = tuple(v)
            if v in sites:
                edges.add(frozenset([u, v]))
    return sorted(tuple(sorted(edge)) for edge in edges)


def all_configurations(box_side):
    # def_configuration: 写像 V_L -> {+1,-1} を辞書で表す
    sites = box_sites(box_side)
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        yield dict(zip(sites, values))


def free_broken_count(configuration, edges):
    # def_broken_count: 両端の値が異なる辺の本数
    return ZZ(
        sum(
            1
            for (u, v) in edges
            if configuration[u] != configuration[v]
        )
    )


def multiplicities_by_enumeration(box_side):
    # def_multiplicity: 破れ数の水準集合の元の個数を全数列挙で数える
    edges = inner_edges(box_side)
    edge_count = ZZ(len(edges))
    multiplicity = {ZZ(m): ZZ(0) for m in range(edge_count + 1)}
    for configuration in all_configurations(box_side):
        multiplicity[free_broken_count(configuration, edges)] += 1
    return multiplicity, edge_count


def kronecker_delta(r, m):
    # 本文の δ_{r,m}: r=m のとき 1、そうでないとき 0
    return ZZ(1) if r == m else ZZ(0)


def check_coefficients_nonnegative(box_side, multiplicity, edge_count, label):
    # def_partition_polynomial: Z_L(X) = Σ_r Ω_L(r) X^r ∈ ZZ[X]
    partition_polynomial = sum(
        multiplicity[m] * X ** m for m in range(edge_count + 1)
    )
    assert partition_polynomial in polynomial_ring

    for m in range(edge_count + 1):
        m = ZZ(m)
        # 証明 1 行目: [X^m] Z_L(X) = [X^m] Σ_r Ω_L(r) X^r（def_partition_polynomial）
        coefficient = partition_polynomial[m]

        # 証明 2 行目: [X^m] Σ_r Ω_L(r) X^r = Σ_r Ω_L(r) δ_{r,m}
        # （係数を取る写像の有限和に対する加法性。単項式 Ω_L(r) X^r の
        #  X^m の係数は Ω_L(r) δ_{r,m} であることを一項ずつ確かめてから足す）
        sum_with_delta = ZZ(0)
        for r in range(edge_count + 1):
            r = ZZ(r)
            monomial = multiplicity[r] * X ** r
            assert monomial[m] == multiplicity[r] * kronecker_delta(r, m)
            sum_with_delta += multiplicity[r] * kronecker_delta(r, m)
        assert coefficient == sum_with_delta

        # 証明 3 行目: Σ_r Ω_L(r) δ_{r,m} = Ω_L(m)（0 ≤ m ≤ #E_L）
        assert sum_with_delta == multiplicity[m]

        # 証明 4 行目（claim_partition_coefficients_nonnegative）:
        # Ω_L(m) ∈ ℕ（def_multiplicity: 有限集合の元の個数）
        assert multiplicity[m] in ZZ
        assert multiplicity[m] >= ZZ(0)

    print(
        "%s: L=%d で全 %d 個の係数について [X^m]Z_L(X)=Ω_L(m)∈ℕ を証明の 4 行の順で確認"
        % (label, box_side, edge_count + 1)
    )


def multiplicities_by_layer_transfer(box_side):
    # 独立な第二の方法（層ごとの転送）。free-boundary-palindrome の検証と同じ方法で、
    # L=2 での全数列挙との一致はあちらの検証で確認済み。
    layer_sites = [(a, b) for a in range(box_side) for b in range(box_side)]
    layer_configs = list(product([ZZ(1), ZZ(-1)], repeat=len(layer_sites)))
    site_index = {site: k for k, site in enumerate(layer_sites)}

    def intra_layer_broken(values):
        broken = 0
        for (a, b) in layer_sites:
            if a + 1 < box_side and values[site_index[(a, b)]] != values[site_index[(a + 1, b)]]:
                broken += 1
            if b + 1 < box_side and values[site_index[(a, b)]] != values[site_index[(a, b + 1)]]:
                broken += 1
        return ZZ(broken)

    def inter_layer_broken(values_low, values_high):
        return ZZ(sum(1 for k in range(len(layer_sites)) if values_low[k] != values_high[k]))

    intra = [intra_layer_broken(values) for values in layer_configs]
    state = [{intra[i]: ZZ(1)} for i in range(len(layer_configs))]
    for _ in range(box_side - 1):
        next_state = [dict() for _ in range(len(layer_configs))]
        for j, values_high in enumerate(layer_configs):
            for i, values_low in enumerate(layer_configs):
                shift = inter_layer_broken(values_low, values_high) + intra[j]
                for m, count in state[i].items():
                    key = m + shift
                    next_state[j][key] = next_state[j].get(key, ZZ(0)) + count
        state = next_state
    multiplicity = {}
    for partial in state:
        for m, count in partial.items():
            multiplicity[m] = multiplicity.get(m, ZZ(0)) + count
    return multiplicity


for L in [1, 2]:
    multiplicity, edge_count = multiplicities_by_enumeration(L)
    check_coefficients_nonnegative(
        L, multiplicity, edge_count, "claim_partition_coefficients_nonnegative"
    )

# 全数列挙の届かない L=3（配位数 2^27）: 層転送で多重度を厳密に数え、
# 全係数が Ω_3(m) ∈ ℕ であることを同じ 4 行の順で確認する
transfer_3 = multiplicities_by_layer_transfer(3)
edge_count_3 = ZZ(3 * 3 * 3 * 2)  # 3 方向 × L^2 (L−1) = 3·9·2 = 54
multiplicity_3 = {ZZ(m): transfer_3.get(ZZ(m), ZZ(0)) for m in range(edge_count_3 + 1)}
check_coefficients_nonnegative(
    3, multiplicity_3, edge_count_3,
    "claim_partition_coefficients_nonnegative（層転送）",
)

print("all checks passed")
