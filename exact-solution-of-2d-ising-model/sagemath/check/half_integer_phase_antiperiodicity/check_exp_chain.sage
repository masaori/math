# 対象ラベル: half_integer_phase_antiperiodicity
# 主張の左辺から -1_C までの 15 等号の鎖を一行ずつ確かめる。M = 2..8、μ = -2M..2M。
# 厳密: 各行の cos・sin の値は、その行に書かれた角度（2π × 有理数）の cos2pi・sin2pi（AA）として作り、
#   ℂ の元は QQbar で持つ。第 0 行の exp は E（1 の冪根）で持つ。隣の行を QQbar で厳密に比べる。
# 独立の確かめ: 全実数上の cos・sin の性質を使う行（周期性・偶奇性・cos π・sin π）は、Arb の cos・sin
#   （1 の冪根を経ない）でも、その行の両辺のボールが重なることを見る。第 0 行と第 1 行を結ぶ
#   exp_of_negative_i_real_as_cos_minus_i_sin は、本文の exp のボールで確かめる（check_claim_ball.sage）。
# 対照: 周期性の行で μ を半整数にずらす（角度に π を足す）と崩れる。
load("../../_shared/half_integer_phase_exact.sage")


def CS(q):
    """(cos 2πq)_C - i (sin 2πq)_C。"""
    return to_C(cos2pi(q)) - I_QQBAR * to_C(sin2pi(q))


h = QQ(1) / 2
i_ = I_QQBAR
for M in range(2, 9):
    for mu in range(-2 * M, 2 * M + 1):
        q0 = QQ(M) * theta_over_2pi(M, mu)           # (M)_R θ̃_μ / 2π
        q2 = -h + mu                                 # (-π + 2πμ_R)/2π
        lines = [
            ("exp(-i((M)_R θ̃_μ)_C)", E(-q0)),
            ("cos((M)θ̃) - i sin((M)θ̃)", CS(q0)),
            ("cos(-π+2πμ) - i sin(-π+2πμ)", CS(q2)),
            ("cos(-π) - i sin(-π)", to_C(cos2pi(-h)) - i_ * to_C(sin2pi(-h))),
            ("cos π - i sin(-π)", to_C(cos2pi(h)) - i_ * to_C(sin2pi(-h))),
            ("cos π - i(-sin π)", to_C(cos2pi(h)) - i_ * to_C(-sin2pi(h))),
            ("(-1_R)_C - i(-sin π)_C", to_C(AA(-1)) - i_ * to_C(-sin2pi(h))),
            ("(-1_R)_C - i(-0_R)_C", to_C(AA(-1)) - i_ * to_C(-AA(0))),
            ("(-1_R)_C - i(0_R)_C", to_C(AA(-1)) - i_ * to_C(AA(0))),
            ("(-1_R)_C - i·0_C", to_C(AA(-1)) - i_ * QQbar(0)),
            ("(-1_R)_C - 0_C", to_C(AA(-1)) - QQbar(0)),
            ("(-1_R)_C + (-0_C)", to_C(AA(-1)) + (-QQbar(0))),
            ("(-1_R)_C + (-1_C)·0_C", to_C(AA(-1)) + QQbar(-1) * QQbar(0)),
            ("(-1_R)_C + 0_C", to_C(AA(-1)) + QQbar(0)),
            ("(-1_R)_C", to_C(AA(-1))),
            ("-1_C", -QQbar(1)),
        ]
        check_adjacent(lines, f"M={M}, μ={mu}")
        # 周期性・偶奇性・特殊値の行を Arb で独立に
        assert arb_cos2pi(q2).overlaps(arb_cos2pi(-h)) and arb_sin2pi(q2).overlaps(arb_sin2pi(-h))
        assert not arb_cos2pi(q2 + h).overlaps(arb_cos2pi(-h))
assert arb_cos2pi(-h).overlaps(arb_cos2pi(h))
assert arb_sin2pi(-h).overlaps(-arb_sin2pi(h))
assert arb_cos2pi(h).overlaps(RB(-1)) and arb_sin2pi(h).overlaps(RB(0))
print("  M = 2..8、μ = -2M..2M で、鎖の 15 等号が QQbar で厳密に成り立つ")
print("  Arb の cos・sin で、周期性（μ を半整数にずらすと崩れる）・cos の偶性・sin の奇性・cos π = -1・sin π = 0 の行が重なる")
print("RESULT: PASS")
