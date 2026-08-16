# 対象ラベル: claim_full_boundary_response_outer_edges_to_one_then_value_at_one
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3、広い外箱 V_{L''}={0,1,2}x{0,1}x{0,1} について、
# 環準同型として ε_L∘π_{L'',L} = ε_{L''}（全不定元での値の一致 → 普遍性）であり、
# したがって ε_L(π_{L'',L}(R~_{L'',L'})) = 2^{#V_{L''}} であることを、証明と同順で ZZ 上の厳密計算により確認する。
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

# 代入 pi_{L'',L}: E_{L''}\E_L の不定元を 1 に、E_L の不定元を同名の不定元に送る環準同型
images = []
for edge in big_edges:
    if edge in mid_index:
        images.append(mid_ring.gen(mid_index[edge]))
    else:
        images.append(mid_ring.one())
pi = big_ring.hom(images, mid_ring)

# 全不定元を 1 に置く環準同型 ε_L, ε_{L''}
epsilon_mid = mid_ring.hom([ZZ(1)] * len(mid_edges), ZZ)
epsilon_big = big_ring.hom([ZZ(1)] * len(big_edges), ZZ)

# 合成 ε_L∘π_{L'',L} は環準同型（加法・乗法・単位元の保存を代表元で確認）
composite = lambda f: epsilon_mid(pi(f))
a, b = big_ring.gen(0) + big_ring.gen(5), big_ring.gen(3) * big_ring.gen(11) + 2
assert composite(a + b) == composite(a) + composite(b)
assert composite(a * b) == composite(a) * composite(b)
assert composite(big_ring.one()) == 1

# 全ての不定元での値の一致: e∈E_L なら π(X_e)=X_e で ε_L(X_e)=1、e∈E_{L''}\E_L なら π(X_e)=1 で ε_L(1)=1、
# いずれも ε_{L''}(X_e)=1 に等しい
for edge in big_edges:
    X = big_ring.gen(big_index[edge])
    if edge in mid_index:
        assert pi(X) == mid_ring.gen(mid_index[edge])
        assert epsilon_mid(pi(X)) == epsilon_mid(mid_ring.gen(mid_index[edge])) == 1
    else:
        assert pi(X) == mid_ring.one()
        assert epsilon_mid(pi(X)) == epsilon_mid(mid_ring.one()) == 1
    assert epsilon_big(X) == 1
    assert composite(X) == epsilon_big(X)

# 普遍性: 不定元で一致する二つの環準同型は等しい。SageMath では合成準同型を作って準同型として比較する
composite_hom = big_ring.hom([epsilon_mid(image) for image in images], ZZ)
assert composite_hom == epsilon_big
assert composite_hom(R_full_big) == epsilon_mid(pi(R_full_big))

# 後半: ε_L(π(R~_{L'',L'})) = ε_{L''}(R~_{L'',L'}) = 2^{#V_{L''}}（全変数を 1 に置いた値の主張を V_{L'}⊂V_{L''} に適用）
assert epsilon_mid(pi(R_full_big)) == epsilon_big(R_full_big)
assert epsilon_big(R_full_big) == ZZ(2) ** len(big_sites)
assert len(big_sites) == 12
print("RESULT: PASS  #V_L''=%d, epsilon_L(pi(R~_L'',L')) = %d = 2^%d" % (len(big_sites), epsilon_mid(pi(R_full_big)), len(big_sites)))
