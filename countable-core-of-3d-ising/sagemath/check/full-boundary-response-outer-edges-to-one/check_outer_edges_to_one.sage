# 対象ラベル: claim_full_boundary_response_outer_edges_to_one
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3、広い外箱 V_{L''}={0,1,2}x{0,1}x{0,1} について、
# 辺変数を 1 に置かない境界応答多項式 R~_{L'',L'} = Z_{L''} に、E_{L''}\E_L の変数だけを 1 に置く代入 pi を施すと
# 2^{#V_{L''}-#V_L} R~_{L,L'} = 2^{#V_{L''}-#V_L} Z_L になることを ZZ 上の有限和の直接計算で確認する。
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


inner_sites = box_sites((1, 1, 1))
mid_sites, mid_edges = box_sites((2, 2, 2)), box_edges((2, 2, 2))
big_sites, big_edges = box_sites((3, 2, 2)), box_edges((3, 2, 2))

# 箱の包含 V_{L'} ⊂ V_L ⊂ V_{L''} と辺の包含 E_L ⊂ E_{L''}
assert set(inner_sites) <= set(mid_sites) <= set(big_sites)
assert set(mid_edges) <= set(big_edges)

# 多変数分配多項式 Z_{L''} の環（E_{L''} の全辺の不定元）と Z_L の環（E_L の全辺の不定元）
big_ring = PolynomialRing(ZZ, ["x%s" % i for i in range(len(big_edges))])
mid_ring = PolynomialRing(ZZ, ["x%s" % i for i in range(len(mid_edges))])
big_index = {edge: i for i, edge in enumerate(big_edges)}
mid_index = {edge: i for i, edge in enumerate(mid_edges)}


def partition_polynomial(ring, index, site_list, edge_list):
    """多変数分配多項式: 配位についての有限和、破れ辺の不定元の有限積。"""
    result = ring.zero()
    for values in product([ZZ(-1), ZZ(1)], repeat=len(site_list)):
        configuration = dict(zip(site_list, values))
        monomial = ring.one()
        for edge in edge_list:
            if configuration[edge[0]] != configuration[edge[1]]:
                monomial *= ring.gen(index[edge])
        result += monomial
    return result


# 定義: 辺変数を 1 に置かない境界応答多項式は多変数分配多項式そのもの
R_full_big = partition_polynomial(big_ring, big_index, big_sites, big_edges)
R_full_mid = partition_polynomial(mid_ring, mid_index, mid_sites, mid_edges)

# 代入 pi_{L'',L}: E_{L''}\E_L の不定元を 1 に、E_L の不定元を同名の不定元に送る環準同型
images = []
for edge in big_edges:
    if edge in mid_index:
        images.append(mid_ring.gen(mid_index[edge]))
    else:
        images.append(mid_ring.one())
pi = big_ring.hom(images, mid_ring)
# 環準同型であること（加法・乗法・単位元の保存）を代表元で確認
a, b = big_ring.gen(0) + big_ring.gen(5), big_ring.gen(3) * big_ring.gen(11) + 2
assert pi(a + b) == pi(a) + pi(b)
assert pi(a * b) == pi(a) * pi(b)
assert pi(big_ring.one()) == mid_ring.one()

# 結論: pi(R~_{L'',L'}) = 2^{#V_{L''}-#V_L} R~_{L,L'}
exponent = len(big_sites) - len(mid_sites)
assert exponent == 4
assert pi(R_full_big) == ZZ(2) ** exponent * R_full_mid
assert pi(R_full_big).parent() is mid_ring
print("RESULT: PASS  #E_L''=%d, #E_L=%d, pi(R~_L'',L') = 2^%d * R~_L,L'" % (len(big_edges), len(mid_edges), exponent))
