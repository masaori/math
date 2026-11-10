# 対象ラベル: half_integer_phase_antiperiodicity
# 主張の左辺から -1_C までの 18 等号の鎖を一行ずつ確かめる。M = 2..8、μ = -2M..2M。
# 厳密: 各行の cos・sin の値は、その行に書かれた角度（2π × 有理数）の cos2pi・sin2pi（AA）として作り、
#   ℂ の元は QQbar で持つ。第 0 行の exp は E（1 の冪根）で持つ。隣の行を QQbar で厳密に比べる。
# 独立の確かめ: 全実数上の cos・sin の性質を使う行（周期性・cos_of_negated_real・sin_of_negated_real・cos π・sin π）は、Arb の cos・sin
#   （1 の冪根を経ない）でも、その行の両辺のボールが重なることを見る。第 0 行と第 1 行を結ぶ
#   exp_of_negative_i_real_as_cos_minus_i_sin は、本文の exp のボールで確かめる（check_claim_ball.sage）。
# 第 1 等号（negative_i_times_complex_is_negation_of_i_times を z = ((M)_R θ̃_μ)_C で）は、両辺の exp の中の
#   (-i)((M)_R θ̃_μ)_C と -(i((M)_R θ̃_μ)_C) を、π・μ・M を不定元にした有理関数体の上の実数の対として組み、一致を見る
#   （E の値の比較は同じ 1 の冪根なので自明）。
# 対照: cos の周期性の行で μ を半整数にずらす（角度に π を足す）と崩れる。sin の周期性の行で角度に π/2 を足すと崩れる
#   （sin は π ずらしでは sin(-π) = 0 のままで崩れない）。第 1 等号で符号を落とすと崩れる。
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
    """(cos 2πq)_C - i (sin 2πq)_C。"""
    return to_C(cos2pi(q)) - I_QQBAR * to_C(sin2pi(q))


h = QQ(1) / 2
i_ = I_QQBAR
check_negative_i_rewrite(M_ * theta_tilde_formula(mu_, M_), "第 1 等号")
print("  第 1 等号の両辺の指数が、実数の対の有理関数体で厳密に一致する（対照: 符号を落とすと崩れる）")
for M in range(2, 9):
    for mu in range(-2 * M, 2 * M + 1):
        q0 = QQ(M) * theta_over_2pi(M, mu)           # (M)_R θ̃_μ / 2π
        q2 = -h + mu                                 # (-π + 2πμ_R)/2π
        lines = [
            ("exp(-i((M)_R θ̃_μ)_C)", E(-q0)),
            ("exp(-(i((M)_R θ̃_μ)_C))", E(-q0)),
            ("cos((M)θ̃) - i sin((M)θ̃)", CS(q0)),
            ("cos(-π+2πμ) - i sin(-π+2πμ)", CS(q2)),
            ("cos(-π) - i sin(-π+2πμ)", to_C(cos2pi(-h)) - i_ * to_C(sin2pi(q2))),
            ("cos(-π) - i sin(-π)", to_C(cos2pi(-h)) - i_ * to_C(sin2pi(-h))),
            ("cos π - i sin(-π)", to_C(cos2pi(h)) - i_ * to_C(sin2pi(-h))),
            ("cos π - i(-(sin π)_C)", to_C(cos2pi(h)) - i_ * (-to_C(sin2pi(h)))),
            ("(-1_R)_C - i(-(sin π)_C)", to_C(AA(-1)) - i_ * (-to_C(sin2pi(h)))),
            ("(-1_R)_C - i(-(0_R)_C)", to_C(AA(-1)) - i_ * (-to_C(AA(0)))),
            ("(-1_R)_C - i(-0_C)", to_C(AA(-1)) - i_ * (-QQbar(0))),
            ("(-1_R)_C - i((-1_C)·0_C)", to_C(AA(-1)) - i_ * (QQbar(-1) * QQbar(0))),
            ("(-1_R)_C - i·0_C", to_C(AA(-1)) - i_ * QQbar(0)),
            ("(-1_R)_C - 0_C", to_C(AA(-1)) - QQbar(0)),
            ("(-1_R)_C + (-0_C)", to_C(AA(-1)) + (-QQbar(0))),
            ("(-1_R)_C + (-1_C)·0_C", to_C(AA(-1)) + QQbar(-1) * QQbar(0)),
            ("(-1_R)_C + 0_C", to_C(AA(-1)) + QQbar(0)),
            ("(-1_R)_C", to_C(AA(-1))),
            ("-1_C", -QQbar(1)),
        ]
        check_adjacent(lines, f"M={M}, μ={mu}")
        # 周期性・cos_of_negated_real・sin_of_negated_real・特殊値の行を Arb で独立に
        assert arb_cos2pi(q2).overlaps(arb_cos2pi(-h)) and arb_sin2pi(q2).overlaps(arb_sin2pi(-h))
        assert not arb_cos2pi(q2 + h).overlaps(arb_cos2pi(-h))
        assert not arb_sin2pi(q2 + QQ(1) / 4).overlaps(arb_sin2pi(-h))
assert arb_cos2pi(-h).overlaps(arb_cos2pi(h))
assert arb_sin2pi(-h).overlaps(-arb_sin2pi(h))
assert arb_cos2pi(h).overlaps(RB(-1)) and arb_sin2pi(h).overlaps(RB(0))
print("  M = 2..8、μ = -2M..2M で、鎖の 18 等号が QQbar で厳密に成り立つ")
print("  Arb の cos・sin で、周期性（cos は π、sin は π/2 ずらすと崩れる）・cos_of_negated_real・sin_of_negated_real・cos π = -1・sin π = 0 の行が重なる")
print("RESULT: PASS")
