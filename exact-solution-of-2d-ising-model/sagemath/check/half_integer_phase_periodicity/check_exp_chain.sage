# 対象ラベル: half_integer_phase_periodicity
# 主張の左辺から右辺までの 4 等号の鎖を一行ずつ確かめる。M = 2..8、μ = -2M..2M、j = -2M..2M。
# 厳密: exp の行は E（1 の冪根）、cos・sin の行はその行に書かれた角度（2π × 有理数）の cos2pi・sin2pi（AA）で作り、
#   QQbar で隣の行と比べる。
# 独立の確かめ: 2π 周期性の行（第 3 等号）は Arb の cos・sin でも両辺のボールが重なることを見る。
#   exp と cos・sin を結ぶ第 1・第 4 等号（exp_of_negative_i_real_as_cos_minus_i_sin）は、本文の exp のボールで確かめる
#   （check_claim_ball.sage）。
# 対照: 周期性の行で、足す角度を 2πj_R から πj_R に替えると、j が奇数のとき崩れる。
load("../../_shared/half_integer_phase_exact.sage")


def CS(q):
    return to_C(cos2pi(q)) - I_QQBAR * to_C(sin2pi(q))


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
                ("cos(j θ̃_{μ+M}) - i sin(j θ̃_{μ+M})", CS(a)),
                ("cos(j θ̃_μ + 2πj) - i sin(j θ̃_μ + 2πj)", CS(b)),
                ("cos(j θ̃_μ) - i sin(j θ̃_μ)", CS(c)),
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
print(f"  {n} 組の (M, μ, j) で、鎖の 4 等号が QQbar で厳密に成り立ち、2π 周期性の行が Arb の cos・sin でも重なる")
print(f"  足す角度を πj_R に替えると、j が奇数の {broke} 組すべてで崩れる")
print("RESULT: PASS")
