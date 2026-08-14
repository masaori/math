# 多重度の回文性（帰無モデル）の検証。
# 本文の証明の各段を、小さい箱の全数列挙で一段ずつ確かめる。
# 厳密計算（ZZ と有限集合の列挙）だけを使い、浮動小数点を使わない。

from itertools import product


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


def coordinate_sum(site):
    return site[0] + site[1] + site[2]


def all_configurations(box_side):
    # def_configuration 前段: 写像 V_L -> {+1,-1} を辞書で表す
    sites = box_sites(box_side)
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        yield dict(zip(sites, values))


def odd_flip(configuration):
    # def_odd_flip: 座標和が奇数の点だけ符号を反転する
    return {
        site: (-value if coordinate_sum(site) % 2 == 1 else value)
        for site, value in configuration.items()
    }


def free_broken_count(configuration, edges):
    # def_broken_count: 両端の値が異なる辺の本数
    return ZZ(
        sum(
            1
            for (u, v) in edges
            if configuration[u] != configuration[v]
        )
    )


def check_adjacent_parity(max_side):
    # claim_edge_endpoints_parity: 辺の両端の座標和の偶奇は異なる
    for box_side in range(1, max_side + 1):
        for (u, v) in inner_edges(box_side):
            assert coordinate_sum(u) % 2 != coordinate_sum(v) % 2
    print("claim_edge_endpoints_parity: L=1..%d の全辺で偶奇が異なることを確認" % max_side)


def check_involution(box_side):
    # claim_odd_flip_involution: T(Tσ)=σ（全数列挙）
    for configuration in all_configurations(box_side):
        assert odd_flip(odd_flip(configuration)) == configuration
    print("claim_odd_flip_involution: L=%d の全 %d 配位で T(Tσ)=σ を確認"
          % (box_side, 2 ** (box_side ** 3)))


def check_edge_reversal(box_side):
    # claim_odd_flip_reverses_edges: (Tσ)(u)≠(Tσ)(v) ⟺ σ(u)=σ(v)（全数列挙 × 全辺）
    edges = inner_edges(box_side)
    for configuration in all_configurations(box_side):
        flipped = odd_flip(configuration)
        for (u, v) in edges:
            assert (flipped[u] != flipped[v]) == (configuration[u] == configuration[v])
    print("claim_odd_flip_reverses_edges: L=%d の全配位 × 全 %d 辺で同値を確認"
          % (box_side, len(edges)))


def check_broken_complement(box_side):
    # claim_broken_complement: m(Tσ) = #E_L − m(σ)（全数列挙）
    edges = inner_edges(box_side)
    edge_count = ZZ(len(edges))
    for configuration in all_configurations(box_side):
        assert (
            free_broken_count(odd_flip(configuration), edges)
            == edge_count - free_broken_count(configuration, edges)
        )
    print("claim_broken_complement: L=%d で m(Tσ)=#E−m(σ) を全配位で確認" % box_side)


def multiplicities_by_enumeration(box_side):
    # def_multiplicity: 自由境界の Ω_L(m) を全数列挙で数える
    edges = inner_edges(box_side)
    multiplicity = {}
    for configuration in all_configurations(box_side):
        m = free_broken_count(configuration, edges)
        multiplicity[m] = multiplicity.get(m, ZZ(0)) + 1
    return multiplicity, ZZ(len(edges))


def check_palindrome(multiplicity, edge_count, label):
    # claim_palindrome: Ω(m)=Ω(#E−m)
    for m in range(edge_count + 1):
        left = multiplicity.get(ZZ(m), ZZ(0))
        right = multiplicity.get(edge_count - ZZ(m), ZZ(0))
        assert left == right, (label, m, left, right)
    total = sum(multiplicity.values())
    print("claim_palindrome: %s（#E=%d、配位総数 %d）で回文性を確認"
          % (label, edge_count, total))
    return total


def multiplicities_by_layer_transfer(box_side):
    # 独立な第二の方法（層ごとの転送）。全数列挙と一致すれば数え上げの裏取りになる。
    # 層 = 固定した第 3 座標での {0..L-1}^2 -> {+1,-1}。層内の破れと層間の破れを分けて足す。
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
    # state[i] = { m: 個数 }（最上層の配位が layer_configs[i] で破れ数 m の部分配位の個数）
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


check_adjacent_parity(4)
check_involution(1)
check_involution(2)
check_edge_reversal(2)
check_broken_complement(2)

multiplicity_1, edge_count_1 = multiplicities_by_enumeration(1)
assert edge_count_1 == 0 and multiplicity_1 == {ZZ(0): ZZ(2)}
check_palindrome(multiplicity_1, edge_count_1, "L=1 全数列挙")

multiplicity_2, edge_count_2 = multiplicities_by_enumeration(2)
assert edge_count_2 == 12
total_2 = check_palindrome(multiplicity_2, edge_count_2, "L=2 全数列挙")
assert total_2 == 2 ** 8

# 第二の方法（層転送）が全数列挙と一致すること（L=2）と、
# 全数列挙の届かない L=3（配位数 2^27）でも回文であること
transfer_2 = multiplicities_by_layer_transfer(2)
assert transfer_2 == multiplicity_2
print("層転送の多重度が L=2 の全数列挙と一致することを確認")

transfer_3 = multiplicities_by_layer_transfer(3)
edge_count_3 = ZZ(3 * 3 * 3 * 2)  # 3 方向 × L^2 (L−1) = 3·9·2 = 54
assert sum(transfer_3.values()) == 2 ** 27
total_3 = check_palindrome(transfer_3, edge_count_3, "L=3 層転送")
assert total_3 == 2 ** 27

print("all checks passed")
