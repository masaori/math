# 対象ラベル: first_dual_coupling_relation
# 証明の鎖（倍角の双曲線正弦）:
#   2 sinh K_1 cosh K_1 = 2 (exp(K_1)-exp(-K_1))/2 (exp(K_1)+exp(-K_1))/2   （def_cosh_sinh）
#                       = (1/2)(exp(K_1)-exp(-K_1))(exp(K_1)+exp(-K_1))     （2·(1/2)·(1/2) = 1/2）
#                       = (exp(K_1)^2 - exp(-K_1)^2)/2                      （(a-b)(a+b) = a²-b²）
#                       = (exp(2K_1) - exp(-2K_1))/2                        （scalar_exp_product）
#                       = sinh(2K_1)                                        （def_cosh_sinh）
# 帰属: 等号は SYM（Ep = exp(K_1)、Em = exp(-K_1)、F = exp(2K_1)、G = exp(-2K_1)）で厳密に、
#   exp(K_1)^2 = exp(2K_1)、exp(-K_1)^2 = exp(-2K_1) は QQ[k] の形式冪級数で厳密に。具体の点は RealBallField(512)。
load("_prelude.sage")

line1 = 2 * s1 * c1
line2 = 2 * ((Ep - Em) / 2) * ((Ep + Em) / 2)
line3 = QQ(1) / 2 * (Ep - Em) * (Ep + Em)
line4 = (Ep^2 - Em^2) / 2
line5 = (F - G) / 2
line6 = S2
line_step(line1, line2, None, "cosh・sinh の定義（s1・c1 は定義どおりの式）")
line_step(line2, line3, None, "2·(1/2)·(1/2) = 1/2")
line_step(line3, line4, None, "(a-b)(a+b) = a²-b²")
line_step(line4, line5, {F: Ep^2, G: Em^2}, "exp(x)exp(x) = exp(2x)")
line_step(line5, line6, {S2: sinh_by_definition(F, G)}, "sinh の定義")
assert SYM(line4) != SYM(line5)

# 代入した関係 exp(K)^2 = exp(2K)、exp(-K)^2 = exp(-2K)（本文 scalar_exp_product で x = y）を形式冪級数で。
assert series_equal(exp_series(SERIES_RING, k_var)^2, exp_series(SERIES_RING, 2 * k_var))
assert series_equal(exp_series(SERIES_RING, -k_var)^2, exp_series(SERIES_RING, -2 * k_var))

for q in Q_EXACT_POINTS:   # exp(K_1) = q、exp(2K_1) = exp(log q²) = q²
    s, c, t = exact_point_values(q)
    assert 2 * s * c == sinh_by_definition(q^2, 1 / q^2)
for K0 in K_RATIONAL_POINTS:
    s, c, t = ball_point_values(K0)
    assert (2 * s * c).overlaps(sinh_ball(2 * K0))
print("倍角の鎖の 5 つの等号を SYM と形式冪級数で厳密に、両端の一致を "
      f"{len(Q_EXACT_POINTS)} 点で QQ、{len(K_RATIONAL_POINTS)} 点でボールで確かめた")
print("RESULT: PASS")
