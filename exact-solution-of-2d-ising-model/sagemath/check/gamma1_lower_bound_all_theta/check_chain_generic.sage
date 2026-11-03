# 対象ラベル: gamma1_lower_bound_all_theta
# 主鎖の等号の行を多項式・有理関数として厳密に確かめ、不等号の行は差を符号の分かる積の形に分解して確かめる。
load("_prelude.sage")

rep = Report("gamma1_lower_bound_all_theta: 鎖の各行（一般の不定元）")

# 準備: s_1 s_2^* > 0·s_2^* = 0 の等号の行
rep.check(0*s2s == 0, "準備 第 2 行: 0·s_2^* = 0（多項式として）")

# 準備の含意の各段: 右辺 − 左辺が、前の段の右辺 − 左辺に、その段で掛ける数を掛けたもの
d = [r - l for (l, r) in PREP_IMPL]
rep.check(d[1] == s1*s2s*d[0], "準備の含意 1 段目: 両辺に s_1s_2^* を掛けた（差が s_1s_2^* 倍）")
rep.check(d[2] == d[1], "準備の含意 2 段目: 両辺に −1 を掛けて左右を入れ替えた（差が等しい）")
rep.check(PREP_IMPL[2][0] == -PREP_IMPL[1][1] and PREP_IMPL[2][1] == -PREP_IMPL[1][0], "準備の含意 2 段目の両辺は 1 段目の両辺の −1 倍")
# 主鎖の第 1 行 ≥ 第 2 行は、準備の終点の両辺に c_1c_2^* を加えたもの
rep.check(LINE2 == c1*c2s + PREP_IMPL[2][0] and LINE1 == c1*c2s + PREP_IMPL[2][1], "第 1 行 ≥ 第 2 行 = 準備の終点の両辺に c_1c_2^* を加えたもの")
# 第 1 行 ≥ 第 2 行: 差がちょうど s_1 s_2^* (1 - cos θ) であり、評価は cos θ ≤ 1 と s_1 s_2^* > 0 だけで決まる
rep.check(LINE1 - LINE2 == s1*s2s*(1 - co), "第 1 行 − 第 2 行 = s_1 s_2^* (1 − cos θ)（多項式として）")
rep.check(LINE1 - LINE2 != 0, "第 1 行と第 2 行は多項式として異なる（評価の行である）")
# 第 2 行 → 第 3 行: 環の演算だけ
rep.check(LINE2 == LINE3, "第 2 行 → 第 3 行（1 は積の単位元。多項式として等しい）")
# 第 3 行 → 第 4 行: 略記を def_cosh_sinh の値に戻す（代入の像が一致）
L3F = LINE3(cosh_from_exp(Y), sinh_from_exp(Y), cosh_from_exp(X), sinh_from_exp(X), 0)   # 第 3 行は co を含まない
rep.check(LINE3.degree(co) == 0, "第 3 行は cos θ を含まない")
rep.check(L3F == line4(Y, X), "第 3 行 → 第 4 行（略記を cosh 2K・sinh 2K に戻す。QQ(Y,X) で等しい）")
# 第 4 行 → 第 5 行: cosh_addition_formula の複号 − の当てはめ（cosh(2K_1−2K_2^*) を exp(2K_1−2K_2^*) = Y/X から独立に作る）
rep.check(line4(Y, X) == line5(Y, X), "第 4 行 → 第 5 行（cosh(x−y) = cosh x cosh y − sinh x sinh y。QQ(Y,X) で等しい）")
rep.check(line4(Y, X) != cosh_from_exp(Y*X), "対照: 第 4 行は cosh(2K_1 + 2K_2^*) とは異なる（複号を取り違えていない）")
# 第 5 行 ≥ 第 6 行: 差は (Y − X)^2 / (2XY) で、X, Y > 0 なら非負
rep.check(line5(Y, X) - LINE6 == (Y - X)**2 / (2*X*Y), "第 5 行 − 第 6 行 = (Y − X)^2/(2XY)（QQ(Y,X) で等しい）")

rep.finish()
