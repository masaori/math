# 対象ラベル: claim_coarse_graining_values_agree_implies_partition_values_agree
# 全辺変数を正の有理数 q に置く代入 ε_{L,q} が ev_q∘κ_L に一致し、ε_{L,q}(𝒵_L)=Z_L(q) となることを
# L=1,2、有理点 q の数点で ℤ[X_e]・ℤ[X]・ℚ の厳密計算で確認する。実数・浮動小数点・極限は使わない。
from itertools import product


def box_sites(box_side):
    return list(product(range(box_side), repeat=3))


def inner_edges(box_side):
    sites = set(box_sites(box_side))
    edges = []
    for start in sites:
        for direction in range(3):
            end = list(start)
            end[direction] += 1
            end = tuple(end)
            if end in sites:
                edges.append((start, end))
    return edges


def build(box_side):
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    names = ["X_%d" % i for i in range(len(edges))] or ["X_dummy"]
    multi_ring = PolynomialRing(ZZ, names)
    gens = multi_ring.gens()
    single_ring = PolynomialRing(ZZ, "X")
    X = single_ring.gen()
    multi_partition = multi_ring(0)
    multiplicity = {}
    for spins in product([-1, 1], repeat=len(sites)):
        sigma = dict(zip(sites, spins))
        broken = [i for i, (u, v) in enumerate(edges) if sigma[u] != sigma[v]]
        monomial = multi_ring(1)
        for i in broken:
            monomial *= gens[i]
        multi_partition += monomial
        multiplicity[len(broken)] = multiplicity.get(len(broken), 0) + 1
    partition_polynomial = sum(c * X**m for m, c in multiplicity.items())
    kappa = multi_ring.hom([X] * len(gens), single_ring)
    return multi_ring, gens, single_ring, multi_partition, partition_polynomial, kappa


rational_points = [QQ(1), QQ(1)/2, QQ(2), QQ(3)/5, QQ(7)/3]
for L in [1, 2]:
    multi_ring, gens, single_ring, ZL_multi, ZL, kappa = build(L)
    for q in rational_points:
        # 段: ε_{L,q}（全辺変数を q に置く環準同型、ℤ[X_e]→ℚ）
        eps = multi_ring.hom([q] * len(gens), QQ)
        # 段: ev_q（X を q に置く環準同型、ℤ[X]→ℚ）
        ev = single_ring.hom([q], QQ)
        # 段: ε_{L,q} = ev_q ∘ κ_L（生成元での一致 → 普遍性で全体一致。生成元と 𝒵_L で確認）
        for g in gens:
            assert eps(g) == ev(kappa(g)) == q
        assert eps(ZL_multi) == ev(kappa(ZL_multi))
        # 段: κ_L(𝒵_L) = Z_L(X)（前の主張）を経て ε_{L,q}(𝒵_L) = Z_L(q)
        assert kappa(ZL_multi) == ZL
        assert eps(ZL_multi) == ZL(q), (L, q, eps(ZL_multi), ZL(q))
        print("L=%d q=%s: eps(Z_multi)=%s = Z_L(q)  PASS" % (L, q, eps(ZL_multi)))
    # 段: 粗視化の値の一致 ⇒ Z_L(q)=Z_L(q')（同じ有理数の等式の言い換え）
    for q in rational_points:
        for qp in rational_points:
            eps_q = multi_ring.hom([q] * len(gens), QQ)
            eps_qp = multi_ring.hom([qp] * len(gens), QQ)
            if eps_q(ZL_multi) == eps_qp(ZL_multi):
                assert ZL(q) == ZL(qp)
print("ALL PASS")
