# 対象ラベル: claim_full_boundary_response_total_degree_is_edge_count
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3（8 点・12 辺）の自由境界の箱で、
# 辺変数を 1 に置かない境界応答多項式 R~_{L,L'} の全次数が #E_L に等しいことを、証明と同順
# （各配位の単項式は相異なる不定元の積で全次数 #B(σ)≤#E_L → 有限和の各単項式の全次数は高々 #E_L →
# 単項式 ∏X_e の係数は B(σ)=E_L の配位の個数 Ω_L(#E_L) で 2 以上 → 全次数はちょうど #E_L）
# で ZZ 上の厳密計算により確認する。
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
sites, edges = box_sites((2, 2, 2)), box_edges((2, 2, 2))
assert set(inner_sites) <= set(sites)
assert len(sites) == 8 and len(edges) == 12

ring = PolynomialRing(ZZ, ["x%s" % i for i in range(len(edges))])
index = {edge: i for i, edge in enumerate(edges)}


def broken_set(configuration):
    return frozenset(edge for edge in edges if configuration[edge[0]] != configuration[edge[1]])


def monomial_of(broken):
    monomial = ring.one()
    for edge in broken:
        monomial *= ring.gen(index[edge])
    return monomial


# R~_{L,L'} を配位の有限和として作り、同時に破れ辺集合ごとの配位の個数（自然数の係数）を数える
R_full = ring.zero()
count_by_broken = {}
for values in product([ZZ(-1), ZZ(1)], repeat=len(sites)):
    configuration = dict(zip(sites, values))
    broken = broken_set(configuration)
    R_full += monomial_of(broken)
    count_by_broken[broken] = count_by_broken.get(broken, 0) + 1

# 相異なる部分集合に対する単項式は相異なる（単項式 → 破れ辺集合が単射）
monomials = [monomial_of(broken) for broken in count_by_broken]
assert len(monomials) == len(set(monomials))

# 各配位の単項式は相異なる不定元の積なので全次数は #B(σ) ≤ #E_L
for broken in count_by_broken:
    assert monomial_of(broken).total_degree() == len(broken)
    assert len(broken) <= len(edges)
# 有限和に現れる単項式はいずれかの配位の単項式なので、全次数は高々 #E_L
for monomial in R_full.monomials():
    assert monomial.total_degree() <= len(edges)
assert R_full.total_degree() <= len(edges)

# 単項式 ∏_{e∈E_L} X_e の係数は B(σ)=E_L となる配位の個数 Ω_L(#E_L)
all_edges = frozenset(edges)
top_monomial = monomial_of(all_edges)
assert top_monomial.total_degree() == len(edges)
coefficient = R_full.monomial_coefficient(top_monomial)
omega_top = count_by_broken.get(all_edges, 0)
assert coefficient == omega_top
# 台の両端の主張: Ω_L(#E_L) ≥ 2（配位 σ とその全反転 -σ は破れ辺集合が同じ）
assert omega_top >= 2
# よって全次数はちょうど #E_L
assert R_full.total_degree() >= len(edges)
assert R_full.total_degree() == len(edges)

print("RESULT: PASS  #V_L=%d, #E_L=%d, total degree of R~_{L,L'} = %d, coefficient of prod X_e = %d" % (len(sites), len(edges), R_full.total_degree(), coefficient))
