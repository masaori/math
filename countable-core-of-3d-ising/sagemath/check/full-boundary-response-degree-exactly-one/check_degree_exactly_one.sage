# 対象ラベル: claim_full_boundary_response_degree_exactly_one
# 内箱 V_{L'}={(0,0,0)}、外箱 V_L={0,1}^3（8 点・12 辺）の自由境界の箱で、
# 辺変数を 1 に置かない境界応答多項式 R~_{L,L'} の各辺変数 X_{e0} についての次数が
# ちょうど 1 であることを、証明と同順（e0 の一端だけを -1 にした配位 τ が e0 を破る →
# 破れ辺集合ごとの係数が配位の個数（自然数）で τ の単項式の係数は 1 以上 → 次数 1 以上 →
# 高々 1 と合わせてちょうど 1）で ZZ 上の厳密計算により確認する。
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

for e0 in edges:
    # 辺 e0 の両端は相異なる
    assert e0[0] != e0[1]
    # 配位 τ: ∂_1 e0 だけ -1、他は 1
    tau = {v: (ZZ(-1) if v == e0[1] else ZZ(1)) for v in sites}
    # τ(∂_0 e0)=1≠-1=τ(∂_1 e0) なので e0∈B(τ)
    assert tau[e0[0]] == 1 and tau[e0[1]] == -1
    broken_tau = broken_set(tau)
    assert e0 in broken_tau
    # τ の単項式の R~ における係数は B(σ)=B(τ) となる配位の個数（自然数）で、τ 自身が数えられるので 1 以上
    coefficient = R_full.monomial_coefficient(monomial_of(broken_tau))
    assert coefficient == count_by_broken[broken_tau]
    assert coefficient in ZZ and coefficient >= 1
    # この単項式の X_{e0} の指数は 1 なので次数は 1 以上
    assert monomial_of(broken_tau).degree(ring.gen(index[e0])) == 1
    degree = R_full.degree(ring.gen(index[e0]))
    assert degree >= 1
    # 高々 1（前の主張）と合わせてちょうど 1
    assert degree <= 1
    assert degree == 1

print("RESULT: PASS  #V_L=%d, #E_L=%d, every edge variable has degree exactly 1 in R~_{L,L'}" % (len(sites), len(edges)))
