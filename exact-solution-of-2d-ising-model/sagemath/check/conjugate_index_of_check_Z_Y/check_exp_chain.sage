# 対象ラベル: conjugate_index_of_check_Z_Y
# (2) の主張の左辺から右辺までの 15 等号の鎖を一行ずつ確かめる。
# 厳密:
# - 第 1〜4 等号（exp の中の複素数の書き換え）は、各行の指数を ℂ の実数の対（complex_as_real_pairs.sage）として、
#   π・μ・M・j を不定元にした有理関数体の上で組み、隣と比べる。
# - 第 7〜15 等号（cos(2πj_R) = 1_R、sin(2πj_R) = 0_R の代入から後の ℂ の計算）は、X := exp(i(j_R θ̃_μ)_C) を
#   1 の冪根 E(j θ̃_μ/2π)（QQbar）の実部・虚部の対で持ち、各行を実数の対の和・積の定義どおりに組んで AA で隣と比べる。
#   cos(2πj_R)・sin(2πj_R) の値は E の実部・虚部（AA）から作るので、第 7・8 等号の値の比較は作り方で自明であり、
#   中身は下の Arb の cos・sin が担う。第 9 等号（(1_R)_C = 1_C）・第 11 等号（差の定義）・第 12 等号（-1 倍の定義）も、
#   両辺を同じ定義の式から作るので比較は自明であり、定義を当てはめた値が通ることを見るだけである。
# ℝ への脱出（π と本文の exp の値。512 bit のボール）:
# - 第 0 行と第 4 行の本文の exp のボールが重なる（指数の書き換え。π をボールにして組む）
# - 第 5 等号（scalar_exp_product）: exp の和のボールと、二つの exp のボールの積が重なる
# - 第 6 等号（exp_of_negative_i_real_as_cos_minus_i_sin を θ = 2πj_R で）: 本文の exp(-i(2πj_R)_C) のボールと
#   Arb の cos(2πj)・sin(2πj) で組んだ (cos)_C - i(sin)_C が重なる
# - 第 7・8 等号: Arb の cos(2πj) が 1 を、sin(2πj) が 0 を含む
# - 主張: 両辺の本文の exp のボールが重なり、両端の E（1 の冪根）の値を含む
# 範囲: M = 2..6、μ = -M..2M、j = -M..2M。対照: 左辺の添字を M-μ にすると、M ∤ j の組で右辺と交わらない。
load("../../_shared/complex_as_real_pairs.sage")
load("../../_shared/half_integer_phase_exact.sage")
h = QQ(1) / 2
F = ANGLE_FIELD
th = lambda m: theta_tilde_formula(m, M_)
iF = (F(0), F(1))
minus_iF = cc_neg(iF, F)
x = j_ * th(mu_)                                   # j_R θ̃_μ
expo = [
    ("-i(j_R θ̃_{M+1-μ})_C", cc_mul(minus_iF, iota(j_ * th(M_ + 1 - mu_), F))),
    ("-i(2πj_R + (-(j_R θ̃_μ)))_C", cc_mul(minus_iF, iota(2 * pi_ * j_ + (-x), F))),
    ("-i((2πj_R)_C + (-(j_R θ̃_μ))_C)", cc_mul(minus_iF, cc_add(iota(2 * pi_ * j_, F), iota(-x, F)))),
    ("(-i)(2πj_R)_C + (-i)(-(j_R θ̃_μ))_C", cc_add(cc_mul(minus_iF, iota(2 * pi_ * j_, F)), cc_mul(minus_iF, iota(-x, F)))),
    ("(-i)(2πj_R)_C + i(j_R θ̃_μ)_C", cc_add(cc_mul(minus_iF, iota(2 * pi_ * j_, F)), cc_mul(iF, iota(x, F)))),
]
check_adjacent(expo, "指数の書き換え")
print("  第 1〜4 等号の指数が、実数の対の有理関数体で厳密に一致する")


def th_b(M, mu):
    return 2 * PI * (RB(mu) - RB(1) / 2) / RB(M)


def pair_of(z):
    z = QQbar(z)
    return (AA(z.real()), AA(z.imag()))


iA = (AA(0), AA(1))
oneA, zeroA = iota(1, AA), iota(0, AA)
n = 0
broke = 0
for M in range(2, 7):
    for mu in range(-M, 2 * M + 1):
        for j in range(-M, 2 * M + 1):
            # 厳密: 第 7〜15 等号（第 6 行から第 15 行の値）
            Xp = pair_of(E(QQ(j) * theta_over_2pi(M, mu)))
            c, s = cos2pi(j), sin2pi(j)
            vals = [
                cc_mul(cc_sub(iota(c, AA), cc_mul(iA, iota(s, AA)), AA), Xp),
                cc_mul(cc_sub(iota(AA(1), AA), cc_mul(iA, iota(s, AA)), AA), Xp),
                cc_mul(cc_sub(iota(AA(1), AA), cc_mul(iA, iota(AA(0), AA)), AA), Xp),
                cc_mul(cc_sub(oneA, cc_mul(iA, zeroA), AA), Xp),
                cc_mul(cc_sub(oneA, zeroA, AA), Xp),
                cc_mul(cc_add(oneA, cc_neg(zeroA, AA)), Xp),
                cc_mul(cc_add(oneA, cc_mul(iota(-1, AA), zeroA)), Xp),
                cc_mul(cc_add(oneA, zeroA), Xp),
                cc_mul(oneA, Xp),
                Xp,
            ]
            assert all(v == vals[0] for v in vals), (M, mu, j)
            assert cc_mul(iA, zeroA) == zeroA          # complex_times_zero_is_zero
            # ℝ への脱出: 本文の exp のボール
            tj = RB(j) * th_b(M, mu)
            b0 = body_exp_i_ball(-(RB(j) * th_b(M, M + 1 - mu)))
            b4 = body_exp_i_ball(-(2 * PI * RB(j)) + tj)
            e2pij = body_exp_i_ball(-(2 * PI * RB(j)))
            X = body_exp_i_ball(tj)
            b5 = e2pij * X
            cosb, sinb = arb_cos2pi(j), arb_sin2pi(j)
            cs = CB(cosb) - CB(0, 1) * CB(sinb)
            assert b0.overlaps(b4)
            assert b4.overlaps(b5)
            assert e2pij.overlaps(cs)
            assert cosb.contains_exact(1) and sinb.contains_exact(0)
            assert b0.overlaps(X)
            assert qqbar_ball(E(-QQ(j) * theta_over_2pi(M, M + 1 - mu))).overlaps(b0)
            assert qqbar_ball(E(QQ(j) * theta_over_2pi(M, mu))).overlaps(X)
            if j % M != 0:
                assert not body_exp_i_ball(-(RB(j) * th_b(M, M - mu))).overlaps(X)
                broke += 1
            n += 1
print(f"  {n} 組の (M, μ, j) で、第 7〜15 等号が実数の対の AA で厳密に成り立つ")
print("  同じ組で、指数の書き換え・指数法則・exp と cos・sin の行・cos(2πj) = 1・sin(2πj) = 0・主張が本文の exp のボールで重なる")
print(f"  対照: 左辺の添字を M-μ にすると {broke} 組で右辺と交わらない")
print("RESULT: PASS")
