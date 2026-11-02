# 対象ラベル: calc_of_TxT_check_Z_Y
# 証明の第 2 行 → 第 3 行が使う def_pair_of_matrices_times_two_by_two_matrix を、成分が独立な不定元の A, B と
# 不定元の p, q, r, s で確かめる（QQ 上の多項式環。厳密）。鎖の検算と同じ _prelude.sage の関数を使い、
# 二つの定義を続けて展開した値が (pA + rB, qA + sB)（下流の T_V_plus_check_Z_Y_via_B1_B2_B1・対角化の章が引く形）を
# Sage のスカラー倍と和で作ったものに等しいことと、行で読んだ組とは異なることを見る。
load("_prelude.sage")


for d in [1, 2, 4]:
    names = [f"a{r}{c}" for r in range(d) for c in range(d)] + [f"b{r}{c}" for r in range(d) for c in range(d)] + ["p", "q", "r", "s"]
    Rg = PolynomialRing(QQ, names)
    g = Rg.gens()
    A = matrix(Rg, d, d, g[:d * d])
    B = matrix(Rg, d, d, g[d * d:2 * d * d])
    p, q, r, s = g[2 * d * d:]
    P = matrix(Rg, 2, 2, [p, q, r, s])
    lhs = pair_times_two_by_two(A, B, P)
    report(lhs == (p * A + r * B, q * A + s * B), f"d={d}: (A, B)P = (pA + rB, qA + sB)")
    report(lhs != (p * A + q * B, r * A + s * B), f"d={d}: 対照 行で読んだ組 (pA + qB, rA + sB) とは異なる")
print("RESULT: PASS")
