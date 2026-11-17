# <inverse_of_sqrt_cc>: 二つの場合の鎖（√(1/z) から ±1/√z まで）と、偏角の和の鎖を一行ずつ確かめる。
# 第 1 の場合（arg z = 0）の鎖 7 等号と、第 2 の場合（0 < arg z < 2π）の鎖 9 等号の各行の値を厳密に作り、隣どうしが等しいことを見る。
# 各行の根拠: 1_C·w = w（complex_numbers_form_a_field）、w^{-1}w = 1_C・ww^{-1} = 1_C（multiplicative_group_of_cc）、
#   積の結合律、condition_of_commutativity_of_sqrt_and_product の第 1・第 2 の場合（z_1 → z、z_2 → 1/z）、
#   double_negation_in_cc、complex_times_negation_is_negation_of_product_in_cc、準備の第四 √(1_C) = 1_C。
# 偏角の和: 第 1 の場合 0 + 0 = 0（x + 0 = x）、第 2 の場合 arg z + (2π − arg z) から def_real_difference・加法の交換律・
#   結合律・逆元・単位元の 5 行で 2π まで。
# 帰属: ℂ の元は AA × AA の対（definition_of_cc の形）、角度は π の有理数倍で Ang（QQ[π]）の元。浮動小数点は使わない。
load("../../_shared/operators.sage")
load("../../_shared/polar_trigonometry_exact.sage")
rep = CheckReport("inverse_of_sqrt_cc: 二つの場合の鎖と偏角の和の鎖")

ONE_C = (AA(1), AA(0))

def cc_inv(w):
    """multiplicative_group_of_cc の逆元: (x, y)^{-1} = (x/(x²+y²), -y/(x²+y²))。"""
    x, y = w
    d = x ^ 2 + y ^ 2
    assert d != 0
    return (x / d, -y / d)

def cc_neg(w):
    return (-w[0], -w[1])

def arg_section(t):
    """arg^{[0,2π)}: 代表元の角度 t の s_{[0,2π)}。"""
    return section_by_floor(t)

# z の極座標の代表元 (r, qπ)。q = 0 が第 1 の場合、0 < q < 2 が第 2 の場合。
samples = [(AA(4), QQ(0)), (AA(2), QQ(0)), (AA(1)/9, QQ(0)),
           (AA(1), QQ(1)/2), (AA(4), QQ(1)), (AA(9), QQ(3)/2), (AA(2), QQ(1)/3), (AA(1)/4, QQ(5)/3)]
n1 = n2 = 0
for r, q in samples:
    t = q * pi_
    z = phi_cartesian((r, t))
    zi = cc_inv(z)
    # 1/z の極座標の代表元: (1/r, -qπ)（polar の逆元）。φ_polar(1/z) = [(1/r, -qπ)] を確かめてから √ を作る
    p_zi = (1 / r, -t)
    sz = sqrt_cc_by_definition(z, (r, t))
    szi = sqrt_cc_by_definition(zi, p_zi)
    rep.truth(phi_polar_equals(zi, p_zi), "φ_polar(1/z) = [(1/r, -qπ)]")
    s1 = sqrt_cc_by_definition(cc_mul(z, zi), (AA(1), Ang(0)))   # √(z·(1/z))
    sone = sqrt_cc_by_definition(ONE_C, (AA(1), Ang(0)))          # √(1_C)
    rep.truth(cc_mul(z, zi) == ONE_C, f"z·(1/z) = 1_C（ww^{{-1}} = 1_C、z = {r}·e^{{i{q}π}}）")
    rep.truth(cc_mul(cc_inv(sz), sz) == ONE_C, f"(1/√z)·√z = 1_C（w^{{-1}}w = 1_C の w → √z）")
    rep.truth(sone == ONE_C, "√(1_C) = 1_C（準備の第四）")
    a = arg_section(t)
    ai = arg_section(-t)
    if q == 0:
        n1 += 1
        # 偏角の和の鎖
        rows = [a + ai, Ang(0) + ai, Ang(0) + Ang(0), Ang(0)]
        rep.truth(a == 0 and ai == 0, "第 1 の場合: arg z = 0、arg(1/z) = 0（range_of_args_of_reciprocal_of_complex_numbers の第 1 の場合）")
        for u, v in zip(rows, rows[1:]):
            rep.truth(u == v, f"偏角の和の行 {u} = {v}")
        # 本体の鎖 7 等号
        rows = [szi,
                cc_mul(ONE_C, szi),
                cc_mul(cc_mul(cc_inv(sz), sz), szi),
                cc_mul(cc_inv(sz), cc_mul(sz, szi)),
                cc_mul(cc_inv(sz), s1),
                cc_mul(cc_inv(sz), sone),
                cc_mul(cc_inv(sz), ONE_C),
                cc_inv(sz)]
        rep.truth(cc_mul(sz, szi) == s1, "√z·√(1/z) = √(z·(1/z))（可換条件の第 1 の場合を右辺から左辺へ）")
    else:
        n2 += 1
        rows = [a + ai,
                a + (2 * pi_ - a),
                a + (2 * pi_ + (-a)),
                a + ((-a) + 2 * pi_),
                (a + (-a)) + 2 * pi_,
                Ang(0) + 2 * pi_,
                2 * pi_]
        rep.truth(ai == 2 * pi_ - a, "第 2 の場合: arg(1/z) = 2π − arg z（range_of_args_of_reciprocal_of_complex_numbers の第 2 の場合）")
        for u, v in zip(rows, rows[1:]):
            rep.truth(u == v, f"偏角の和の行 {u} = {v}")
        rows = [szi,
                cc_mul(ONE_C, szi),
                cc_mul(cc_mul(cc_inv(sz), sz), szi),
                cc_mul(cc_inv(sz), cc_mul(sz, szi)),
                cc_mul(cc_inv(sz), cc_neg(cc_neg(cc_mul(sz, szi)))),
                cc_mul(cc_inv(sz), cc_neg(s1)),
                cc_mul(cc_inv(sz), cc_neg(sone)),
                cc_mul(cc_inv(sz), cc_neg(ONE_C)),
                cc_neg(cc_mul(cc_inv(sz), ONE_C)),
                cc_neg(cc_inv(sz))]
        rep.truth(cc_neg(cc_mul(sz, szi)) == s1, "−(√z·√(1/z)) = √(z·(1/z))（可換条件の第 2 の場合を右辺から左辺へ）")
    for u, v in zip(rows, rows[1:]):
        rep.truth(u == v, f"鎖の行 {u} = {v}")
rep.truth(n1 > 0 and n2 > 0, "両方の場合を踏んでいる")
# 否定の対照: 第 2 の場合に第 1 の場合の符号（+1/√z）を当てると成り立たない。第 1 の場合に −1/√z を当てても成り立たない
r, t = AA(4), pi_
z = phi_cartesian((r, t))
rep.truth(sqrt_cc_by_definition(cc_inv(z), (1 / r, -t)) != cc_inv(sqrt_cc_by_definition(z, (r, t))), "否定の対照: arg z = π で √(1/z) ≠ 1/√z")
z = phi_cartesian((AA(4), Ang(0)))
rep.truth(sqrt_cc_by_definition(cc_inv(z), (AA(1) / 4, Ang(0))) != cc_neg(cc_inv(sqrt_cc_by_definition(z, (AA(4), Ang(0))))), "否定の対照: arg z = 0 で √(1/z) ≠ −1/√z")
rep.finish()
