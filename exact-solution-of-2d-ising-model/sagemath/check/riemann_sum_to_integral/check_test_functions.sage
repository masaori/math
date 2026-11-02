# 対象ラベル: riemann_sum_to_integral
# 検算に使う三つの試験関数（t^2・cos t・|t - π|）の準備そのものを確かめる。ほかの検算はこれを前提にする。
#  (a) 原始関数: 記号微分で G' = g（|t - π| は π の左右それぞれで）。G は π で連続。
#  (b) 値: AA で作った cos(qπ)・sin(qπ) が、Sage の記号の cos・sin を AA へ送った値と一致する。
#  (c) 連続度 ω(h): 標本の点の組 (s, t)（s, t ∈ [0,2π]、|s - t| ≤ h、すべて π の有理数倍）で |g(s) - g(t)| ≤ ω(h)、
#      かつ達成点の組で等号。
#  (d) 区間上の上限 sup_{[a,b]} |g - g(c)|: 区間の標本の点の値はすべて上限以下で、上限はある点で取られる。
load("riemann_sum_by_definition.sage")

# (a)
assert bool(diff(Square().sym_prim, x_sym) == Square().sym)
assert bool(diff(Cosine().sym_prim, x_sym) == Cosine().sym)
assert bool(diff(-(pi - x_sym) ** 2 / 2, x_sym) == pi - x_sym)      # t ≤ π で g = π - t
assert bool(diff((x_sym - pi) ** 2 / 2, x_sym) == x_sym - pi)       # t ≥ π で g = t - π
A = AbsAroundPi()
assert A.prim(1) == 0 and (-(pt(1) - p) ** 2 / 2) == ((pt(1) - p) ** 2 / 2)   # π で左右の式が一致
for q in [QQ(k) / 7 for k in range(15)]:
    assert Square().prim(q) == pt(q) ** 3 / 3
print("(a) 原始関数の微分を記号計算で確かめた")

# (b)
for q in [QQ(a) / b for b in range(1, 13) for a in range(0, 2 * b + 1)]:
    assert cos_qpi(q) == AA(cos(pi * q)), q
    assert sin_qpi(q) == AA(sin(pi * q)), q
print("(b) cos(qπ)・sin(qπ) を記号の値と比べた")

# (c) ω の式の導出（riemann_sum_by_definition.sage の注記）に使う恒等式
sv, tv = var("sv tv")
assert bool((sv ** 2 - tv ** 2) == (sv - tv) * (sv + tv))
av, bv = var("av bv")      # s = a + b, t = a - b、すなわち a = (s+t)/2, b = (s-t)/2
assert (cos(av + bv) - cos(av - bv) + 2 * sin(av) * sin(bv)).expand_trig().simplify_full() == 0
print("(c) ω の導出に使う恒等式（平方の差・和積公式）を記号計算で確かめた")
grid = [QQ(k) / 24 for k in range(0, 49)]           # [0,2π] の点 kπ/24
for g in TEST_FUNCTIONS:
    for qh in [QQ(1) / 12, QQ(1) / 6, QQ(1) / 3, QQ(1) / 2, QQ(1), QQ(3) / 2, QQ(2), QQ(5) / 2]:
        w = g.omega(qh)
        for qs in grid:
            for qt in grid:
                if abs(qs - qt) <= qh:
                    assert leq(rabs(g.value(qs) - g.value(qt)), w), (g.name, qh, qs, qt)
        qs, qt = g.witness(qh)
        assert 0 <= qs <= 2 and 0 <= qt <= 2 and abs(qs - qt) <= qh
        assert rabs(g.value(qs) - g.value(qt)) == w
    print(f"(c) {g.name}: ω(h) は標本の組の上界で、達成点で等しい")

# (d)
for g in TEST_FUNCTIONS:
    for (qa, qb) in [(0, QQ(1) / 3), (QQ(1) / 3, QQ(4) / 3), (QQ(5) / 6, QQ(7) / 6), (QQ(3) / 2, 2), (0, 2)]:
        for qc in [qa, (qa + qb) / 2, qb]:
            s = sup_dev_on(g, qa, qb, qc)
            pts = [qa + (qb - qa) * QQ(k) / 30 for k in range(31)]
            vals = [rabs(g.value(t) - g.value(qc)) for t in pts]
            assert all(leq(v, s) for v in vals)
            cands = [qa, qb] + [k for k in g.kinks if qa <= k <= qb]
            assert any(rabs(g.value(t) - g.value(qc)) == s for t in cands)
    print(f"(d) {g.name}: 区間上の上限を標本の点と比べた")
print("RESULT: PASS")
