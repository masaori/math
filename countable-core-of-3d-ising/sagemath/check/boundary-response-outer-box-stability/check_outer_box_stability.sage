# 対象ラベル: claim_boundary_response_outer_box_stability
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3、さらに広い外箱 V_{L''}={0,1,2}x{0,1}x{0,1} について、
# 変数集合の一致 A_{L'',L'}=A_{L,L'} と R_{L'',L'} = 2^{#V_{L''}-#V_L} R_{L,L'} を有限和の直接計算で確認する。
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
mid_sites, mid_edges = box_sites((2, 2, 2)), box_edges((2, 2, 2))
big_sites, big_edges = box_sites((3, 2, 2)), box_edges((3, 2, 2))

# 箱の包含 V_{L'} ⊂ V_L ⊂ V_{L''} と辺の包含 E_L ⊂ E_{L''}
assert inner_site_set <= set(mid_sites) <= set(big_sites)
assert set(mid_edges) <= set(big_edges)


def active(edge_list):
    return [e for e in edge_list if e[0] in inner_site_set or e[1] in inner_site_set]


active_mid, active_big = active(mid_edges), active(big_edges)
# 仮定: E_{L''} の辺で V_{L'} に触れるものは全て E_L に含まれる。結論: 変数集合の一致
assert set(active_big) <= set(mid_edges)
assert set(active_big) == set(active_mid)
active_edges = active_mid
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


R_mid = response(mid_sites, mid_edges)
R_big = response(big_sites, big_edges)
factor = ZZ(2) ** (len(big_sites) - len(mid_sites))
assert len(big_sites) - len(mid_sites) == 4
assert R_big == factor * R_mid
assert R_big.parent() is target_ring
print("RESULT: PASS  #V_L''-#V_L=%d, R_L'',L' = %d * R_L,L'" % (len(big_sites) - len(mid_sites), factor))
