# 対象ラベル: claim_boundary_response_outer_box_independence
from itertools import product


def box_sites(sides):
    return list(product(*[range(side) for side in sides]))


def box_edges(sides):
    vertex_set = set(box_sites(sides))
    result = []
    for start in box_sites(sides):
        for direction in range(3):
            end = list(start)
            end[direction] += 1
            end = tuple(end)
            if end in vertex_set:
                result.append((start, end))
    return result


inner_site_set = set(box_sites((1, 1, 1)))


def active(edge_list):
    return [e for e in edge_list if e[0] in inner_site_set or e[1] in inner_site_set]


# 内箱 V_{L'}={(0,0,0)}、共通の外箱 V_{L0}={0,1}^3、二つの外箱 V_{L1}={0,1,2}x{0,1}^2、
# V_{L2}={0,1}^2x{0,1,2,3} について、変数集合の一致 A_{L1,L'}=A_{L0,L'}=A_{L2,L'} と
# 2^{#V_{L2}} R_{L1,L'} = 2^{#V_{L1}} R_{L2,L'} を有限和の直接計算で確認する。
zero_sites, zero_edges = box_sites((2, 2, 2)), box_edges((2, 2, 2))
one_sites, one_edges = box_sites((3, 2, 2)), box_edges((3, 2, 2))
two_sites, two_edges = box_sites((2, 2, 4)), box_edges((2, 2, 4))
assert inner_site_set <= set(zero_sites) <= set(one_sites)
assert inner_site_set <= set(zero_sites) <= set(two_sites)
assert set(zero_edges) <= set(one_edges) and set(zero_edges) <= set(two_edges)
active_zero, active_one, active_two = active(zero_edges), active(one_edges), active(two_edges)
# 仮定: E_{L1}, E_{L2} の辺で V_{L'} に触れるものは全て E_{L0} に含まれる。結論: 変数集合の一致
assert set(active_one) <= set(zero_edges) and set(active_two) <= set(zero_edges)
assert set(active_one) == set(active_zero) == set(active_two)
active_edges = active_zero
target_ring = PolynomialRing(ZZ, ["y%s" % i for i in range(len(active_edges))])
active_index = {edge: i for i, edge in enumerate(active_edges)}


def response(site_list, edge_list):
    """多変数分配多項式に代入 rho を施した像を、代入後の直接の有限和として計算する。"""
    result = target_ring.zero()
    for values in product([ZZ(-1), ZZ(1)], repeat=len(site_list)):
        configuration = dict(zip(site_list, values))
        monomial = target_ring.one()
        for edge in edge_list:
            if configuration[edge[0]] != configuration[edge[1]] and edge in active_index:
                monomial *= target_ring.gen(active_index[edge])
        result += monomial
    return result


R_zero, R_one, R_two = response(zero_sites, zero_edges), response(one_sites, one_edges), response(two_sites, two_edges)
# 安定性の二度適用（本文の証明の各段）
assert R_one == ZZ(2) ** (len(one_sites) - len(zero_sites)) * R_zero
assert R_two == ZZ(2) ** (len(two_sites) - len(zero_sites)) * R_zero
# 主張の等式
assert ZZ(2) ** len(two_sites) * R_one == ZZ(2) ** len(one_sites) * R_two
assert (ZZ(2) ** len(two_sites) * R_one).parent() is target_ring
print("RESULT: PASS  #V_L1=%d, #V_L2=%d, 2^#V_L2 R_L1 = 2^#V_L1 R_L2" % (len(one_sites), len(two_sites)))
