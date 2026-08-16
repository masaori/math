# 対象ラベル: claim_full_boundary_response_common_outer_box_comparison
# 内箱 V_{L'}={(0,0,0)}、共通の外箱 V_{L0}={0,1}^3、二つの外箱 V_{L1}={0,1,2}x{0,1}x{0,1}、
# V_{L2}={0,1}x{0,1,2}x{0,1}（V_{L1} と V_{L2} は互いに含まない）について、
# 2^{#V_{L2}} pi_{L1,L0}(R~_{L1,L'}) = 2^{#V_{L1}} pi_{L2,L0}(R~_{L2,L'}) を ZZ 上の有限和の直接計算で確認する。
# 証明の順のとおり、まず外箱依存性の主張を各三つ組に適用した二つの等式を確かめ、次に 2 冪の積で結ぶ。
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
l0_sites, l0_edges = box_sites((2, 2, 2)), box_edges((2, 2, 2))
l1_sites, l1_edges = box_sites((3, 2, 2)), box_edges((3, 2, 2))
l2_sites, l2_edges = box_sites((2, 3, 2)), box_edges((2, 3, 2))

# 箱の包含 V_{L'} ⊂ V_{L0} ⊂ V_{L1}, V_{L2}。V_{L1} と V_{L2} は互いに含まない
assert set(inner_sites) <= set(l0_sites) <= set(l1_sites)
assert set(l0_sites) <= set(l2_sites)
assert not (set(l1_sites) <= set(l2_sites)) and not (set(l2_sites) <= set(l1_sites))
assert set(l0_edges) <= set(l1_edges) and set(l0_edges) <= set(l2_edges)


def make_ring(edge_list):
    ring = PolynomialRing(ZZ, ["x%s" % i for i in range(len(edge_list))])
    return ring, {edge: i for i, edge in enumerate(edge_list)}


l0_ring, l0_index = make_ring(l0_edges)
l1_ring, l1_index = make_ring(l1_edges)
l2_ring, l2_index = make_ring(l2_edges)


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
R_full_l0 = partition_polynomial(l0_ring, l0_index, l0_sites, l0_edges)
R_full_l1 = partition_polynomial(l1_ring, l1_index, l1_sites, l1_edges)
R_full_l2 = partition_polynomial(l2_ring, l2_index, l2_sites, l2_edges)


def substitution(big_ring, big_edges):
    """代入 pi_{Li,L0}: E_{Li}\E_{L0} の不定元を 1 に、E_{L0} の不定元を同名の不定元に送る環準同型。"""
    images = []
    for edge in big_edges:
        if edge in l0_index:
            images.append(l0_ring.gen(l0_index[edge]))
        else:
            images.append(l0_ring.one())
    return big_ring.hom(images, l0_ring)


pi_1 = substitution(l1_ring, l1_edges)
pi_2 = substitution(l2_ring, l2_edges)

# 第一段: 外箱依存性の主張を (L', L0, L1) と (L', L0, L2) に適用した二つの等式
exponent_1 = len(l1_sites) - len(l0_sites)
exponent_2 = len(l2_sites) - len(l0_sites)
assert exponent_1 == 4 and exponent_2 == 4
assert pi_1(R_full_l1) == ZZ(2) ** exponent_1 * R_full_l0
assert pi_2(R_full_l2) == ZZ(2) ** exponent_2 * R_full_l0

# 第二段: 両辺に 2 冪を掛け、2 冪の積の法則 2^a 2^b = 2^{a+b} で結ぶ
n0, n1, n2 = len(l0_sites), len(l1_sites), len(l2_sites)
lhs = ZZ(2) ** n2 * pi_1(R_full_l1)
rhs = ZZ(2) ** n1 * pi_2(R_full_l2)
assert lhs == ZZ(2) ** (n2 + n1 - n0) * R_full_l0
assert rhs == ZZ(2) ** (n1 + n2 - n0) * R_full_l0
assert lhs == rhs
assert lhs.parent() is l0_ring
print("RESULT: PASS  #V_L0=%d, #V_L1=%d, #V_L2=%d, both sides = 2^%d * R~_L0,L'" % (n0, n1, n2, n1 + n2 - n0))
