# 対象ラベル: gamma1_lower_bound_all_theta
# 具体の結合定数と角度で、準備と主鎖の全行（等号・不等号）を実代数的数（AA）の中で厳密に確かめる。
#
# ℝ への脱出: K_1 = (1/2) log Y、K_2^* = (1/2) log X（X, Y ∈ QQ_{>1}、すなわち K_1, K_2^* > 0）と選ぶ。
# θ = 2πk/n とし、cos θ は Sage の記号式 cos(2πk/n) を AA へ変換する。比較はすべて AA の厳密な順序で行う。
load("_prelude.sage")

rep = Report("gamma1_lower_bound_all_theta: 具体値での厳密検算")

PARAMS = [(QQ(4), QQ(3)), (QQ(9), QQ(7)/3), (QQ(25)/4, QQ(2)), (QQ(2), QQ(5)), (QQ(3), QQ(3))]   # (Y, X)。最後は 2K_1 = 2K_2^*
ANGLES = [(0, 1), (1, 3), (1, 4), (1, 5), (2, 5), (1, 2), (3, 7), (5, 8), (7, 12), (-1, 3)]

for (Y0, X0) in PARAMS:
    c1v, s1v = cosh_from_exp(Y0), sinh_from_exp(Y0)
    c2sv, s2sv = cosh_from_exp(X0), sinh_from_exp(X0)
    tagp = f"(Y,X)=({Y0},{X0})"
    # 準備: s_1 > 0, s_2^* > 0, s_1 s_2^* > 0·s_2^* = 0
    rep.check(s1v > 0 and s2sv > 0, f"{tagp} 準備: s_1 > 0、s_2^* > 0")
    rep.check(s1v*s2sv > 0*s2sv and 0*s2sv == 0, f"{tagp} 準備: s_1 s_2^* > 0·s_2^* = 0")
    for (k, n) in ANGLES:
        th = 2 * pi * k / n
        cov = AA(cos(th))
        vals = {c1: AA(c1v), s1: AA(s1v), c2s: AA(c2sv), s2s: AA(s2sv), co: cov}
        tag = f"{tagp}, θ=2π·{k}/{n}"
        l1 = AA(LINE1.subs(vals)); l2 = AA(LINE2.subs(vals)); l3 = AA(LINE3.subs(vals))
        l4 = AA(line4(Y0, X0)); l5 = AA(line5(Y0, X0))
        rep.check(cov <= 1, f"{tag} 主張の前提 cos θ ≤ 1")
        rep.check(all(AA(l.subs(vals)) <= AA(r.subs(vals)) for (l, r) in PREP_IMPL), f"{tag} 準備の含意の全 3 段の不等号")
        rep.check(l1 >= l2, f"{tag} 第 1 行 ≥ 第 2 行")
        rep.check(l2 == l3 and l3 == l4 and l4 == l5, f"{tag} 第 2 行 = 第 3 行 = 第 4 行 = 第 5 行")
        rep.check(l5 >= LINE6, f"{tag} 第 5 行 ≥ 第 6 行 = 1")
        rep.check((l1 == l2) == (cov == 1), f"{tag} 第 1 行の評価が等号になるのは cos θ = 1 のときだけ")
    rep.check((AA(line5(Y0, X0)) == 1) == (Y0 == X0), f"{tagp} 第 5 行 = 1 となるのは 2K_1 = 2K_2^* のときだけ")

rep.finish()
