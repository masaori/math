# 対象ラベル: claim_full_boundary_response_outer_edges_to_one_is_sum_of_inner_monomials
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3、広い外箱 V_{L''}={0,1,2}x{0,1}x{0,1} について、
# π_{L'',L}(R~_{L'',L'}) = Σ_σ ∏_{e∈B(σ)∩E_L} X_e を、証明と同順で ZZ 上の厳密計算により確認する。
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

# 第一段: R~_{L'',L'} は配位についての有限和 Σ_σ ∏_{e∈B(σ)} X_e（定義そのもの）
terms = []
inner_images = []
for values in product([ZZ(-1), ZZ(1)], repeat=len(big_sites)):
    configuration = dict(zip(big_sites, values))
    broken = [edge for edge in big_edges if configuration[edge[0]] != configuration[edge[1]]]
    terms.append(prod([big_ring.gen(big_index[edge]) for edge in broken], big_ring.one()))
    # 前主張（各配位の単項式は単項式に写る）の右辺 ∏_{e∈B(σ)∩E_L} X_e
    inner_images.append(prod([mid_ring.gen(mid_index[edge]) for edge in broken if edge in mid_index], mid_ring.one()))
assert len(terms) == ZZ(2) ** len(big_sites) == 4096
assert R_full_big == sum(terms, big_ring.zero())

# 第二段: 環準同型は有限和を保つ
lhs = pi(R_full_big)
assert lhs == sum([pi(term) for term in terms], mid_ring.zero())

# 第三段: 各項に前主張を適用（各項の像は ∏_{e∈B(σ)∩E_L} X_e）
for term, inner in zip(terms, inner_images):
    assert pi(term) == inner
rhs = sum(inner_images, mid_ring.zero())
assert lhs == rhs

# 結論の形: 右辺は E_L 上の単項式（各不定元の指数が高々 1）の 4096 項の有限和
assert all(all(exponent <= 1 for exponent in inner.exponents()[0]) for inner in inner_images)
assert lhs.parent() is mid_ring
print("RESULT: PASS  pi(R~_{L'',L'}) equals the sum over %d configurations of the monomials over B(sigma) ∩ E_L" % len(terms))
