# 対象ラベル: half_integer_phase_periodicity
# 主張の左辺から右辺までの 6 等号の鎖を一行ずつ確かめる。M = 2..8、μ = -2M..2M、j = -2M..2M。
# 厳密: exp の行は E（1 の冪根）、cos・sin の行はその行に書かれた角度（2π × 有理数）の cos2pi・sin2pi（AA）で作り、
#   QQbar で隣の行と比べる。
# 独立の確かめ: 2π 周期性の行（第 3 等号）は Arb の cos・sin でも両辺のボールが重なることを見る。
#   exp と cos・sin を結ぶ第 2・第 5 等号（exp_of_negative_i_real_as_cos_minus_i_sin）は、本文の exp のボールで確かめる
#   （check_claim_ball.sage）。
# 第 1・第 6 等号（negative_i_times_complex_is_negation_of_i_times を z = (j_R θ̃_{μ+M})_C、(j_R θ̃_μ)_C で）は、
#   両辺の exp の中の (-i)x_C と -(i x_C) を、π・μ・M・j を不定元にした有理関数体の上の実数の対として組み、一致を見る
#   （E の値の比較は同じ 1 の冪根なので自明）。対照: 符号を落とすと崩れる。
# 対照: 周期性の行で、足す角度を 2πj_R から πj_R に替えると、j が奇数のとき崩れる。
load("../../_shared/complex_as_real_pairs.sage")
load("../../_shared/half_integer_phase_exact.sage")
F = ANGLE_FIELD
pi_, mu_, M_, j_ = F.gens()
iF = (F(0), F(1))
minus_iF = cc_neg(iF, F)


def check_negative_i_rewrite(x, label):
    """negative_i_times_complex_is_negation_of_i_times を z = x_C で: (-i)x_C = -(i x_C) を実数の対で厳密に見る。
    対照: 符号を落とした i x_C は (-i)x_C と違う。"""
    z = iota(x, F)
    lhs = cc_mul(minus_iF, z)
    assert lhs == cc_neg(cc_mul(iF, z), F), label
    assert cc_mul(iF, z) != lhs, label


def CS(q):
    return to_C(cos2pi(q)) - I_QQBAR * to_C(sin2pi(q))


check_negative_i_rewrite(j_ * theta_tilde_formula(mu_ + M_, M_), "第 1 等号")
check_negative_i_rewrite(j_ * theta_tilde_formula(mu_, M_), "第 6 等号")
print("  第 1・第 6 等号の両辺の指数が、実数の対の有理関数体で厳密に一致する（対照: 符号を落とすと崩れる）")
n = 0
broke = 0
for M in range(2, 9):
    for mu in range(-2 * M, 2 * M + 1):
        for j in range(-2 * M, 2 * M + 1):
            a = QQ(j) * theta_over_2pi(M, mu + M)        # j_R θ̃_{μ+M} / 2π
            b = QQ(j) * theta_over_2pi(M, mu) + j         # (j_R θ̃_μ + 2πj_R)/2π
            c = QQ(j) * theta_over_2pi(M, mu)            # j_R θ̃_μ / 2π
            lines = [
                ("exp(-i(j θ̃_{μ+M})_C)", E(-a)),
                ("exp(-(i(j θ̃_{μ+M})_C))", E(-a)),
                ("cos(j θ̃_{μ+M}) - i sin(j θ̃_{μ+M})", CS(a)),
                ("cos(j θ̃_μ + 2πj) - i sin(j θ̃_μ + 2πj)", CS(b)),
                ("cos(j θ̃_μ) - i sin(j θ̃_μ)", CS(c)),
                ("exp(-(i(j θ̃_μ)_C))", E(-c)),
                ("exp(-i(j θ̃_μ)_C)", E(-c)),
            ]
            check_adjacent(lines, f"M={M}, μ={mu}, j={j}")
            assert arb_cos2pi(b).overlaps(arb_cos2pi(c)) and arb_sin2pi(b).overlaps(arb_sin2pi(c))
            if j % 2 != 0 and CS(c + QQ(j) / 2) == CS(c):
                raise AssertionError("対照が崩れない")
            if j % 2 != 0:
                broke += 1
            n += 1
assert broke > 0
print(f"  {n} 組の (M, μ, j) で、鎖の 6 等号が QQbar で厳密に成り立ち、2π 周期性の行が Arb の cos・sin でも重なる")
print(f"  足す角度を πj_R に替えると、j が奇数の {broke} 組すべてで崩れる")
print("RESULT: PASS")
