# 分配多項式の 1 での値（帰無モデル）の検証。
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


def check_level_sets_partition(box_side):
    # 証明の前段: 破れ数はちょうど一つの m ∈ {0..#E_L} に等しく（def_broken_count）、
    # 多重度が数える水準集合は互いに重ならず合わせると Σ_L になる（def_multiplicity）。
    edges = inner_edges(box_side)
    edge_count = ZZ(len(edges))
    level_sets = {ZZ(m): [] for m in range(edge_count + 1)}
    site_count = ZZ(len(box_sites(box_side)))
    total = ZZ(0)
    for index, configuration in enumerate(all_configurations(box_side)):
        m = free_broken_count(configuration, edges)
        # 各配位の破れ数が {0..#E_L} のちょうど一つの値であること
        assert ZZ(0) <= m <= edge_count
        level_sets[m].append(index)
        total += 1
    # 互いに重ならないこと: 各配位は破れ数の値でただ一つの水準集合に入れたので、
    # 水準集合の元の個数の総和が配位総数に一致すれば分割である
    assert sum(ZZ(len(members)) for members in level_sets.values()) == total
    assert total == ZZ(2) ** site_count
    multiplicity = {m: ZZ(len(members)) for m, members in level_sets.items()}
    print(
        "水準集合の分割: L=%d の全 %d 配位が #E=%d までの水準集合へ重複なく分かれることを確認"
        % (box_side, total, edge_count)
    )
    return multiplicity, edge_count, site_count


def check_value_at_one(box_side):
    multiplicity, edge_count, site_count = check_level_sets_partition(box_side)

    # def_partition_polynomial: Z_L(X) = Σ_m Ω_L(m) X^m ∈ ZZ[X]
    partition_polynomial = sum(
        multiplicity[m] * X ** m for m in range(edge_count + 1)
    )
    assert partition_polynomial in polynomial_ring
    assert partition_polynomial.degree() <= edge_count

    # 証明 1 行目: Z_L(1) = Σ_m Ω_L(m) 1^m（def_partition_polynomial による代入）
    value_at_one = partition_polynomial(ZZ(1))
    sum_with_powers = sum(
        multiplicity[m] * ZZ(1) ** m for m in range(edge_count + 1)
    )
    assert value_at_one == sum_with_powers

    # 証明 2 行目: Σ_m Ω_L(m) 1^m = Σ_m Ω_L(m)（1^m = 1）
    sum_of_multiplicities = sum(
        multiplicity[m] for m in range(edge_count + 1)
    )
    assert sum_with_powers == sum_of_multiplicities

    # 証明 3 行目: Σ_m Ω_L(m) = #Σ_L（水準集合の分割。check_level_sets_partition で確認済みの分割）
    configuration_count = ZZ(2) ** site_count
    assert sum_of_multiplicities == configuration_count

    # 証明 4 行目（claim_partition_value_at_one）: Z_L(1) = 2^{#V_L}（def_configuration）
    assert value_at_one == ZZ(2) ** site_count

    print(
        "claim_partition_value_at_one: L=%d で Z_L(1)=2^%d=%d を証明の 4 行の順で確認"
        % (box_side, site_count, value_at_one)
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


check_value_at_one(1)
check_value_at_one(2)

# 全数列挙の届かない L=3（配位数 2^27）: 層転送で多重度を厳密に数え、
# Z_3(1) = Σ_m Ω_3(m) = 2^{#V_3} = 2^27 を確認する
transfer_3 = multiplicities_by_layer_transfer(3)
partition_polynomial_3 = sum(count * X ** m for m, count in transfer_3.items())
edge_count_3 = ZZ(3 * 3 * 3 * 2)  # 3 方向 × L^2 (L−1) = 3·9·2 = 54
assert partition_polynomial_3.degree() <= edge_count_3
assert partition_polynomial_3(ZZ(1)) == ZZ(2) ** ZZ(27)
print("claim_partition_value_at_one: L=3（層転送）で Z_3(1)=2^27 を確認")

print("all checks passed")
