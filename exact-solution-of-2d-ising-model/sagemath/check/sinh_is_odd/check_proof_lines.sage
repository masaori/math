# 対象ラベル: sinh_is_odd
# 証明の鎖 sinh(-x) = (exp(-x)-exp(-(-x)))/2 = (exp(-x)-exp(x))/2 = (exp(-x)+(-exp(x)))/2 = ((-exp(x))+exp(-x))/2 = ((-exp(x))+(-(-exp(-x))))/2 = (-(exp(x)+(-exp(-x))))/2 = (-(exp(x)-exp(-x)))/2 = (-(exp(x)-exp(-x)))·2^{-1} = -((exp(x)-exp(-x))·2^{-1}) = -(exp(x)-exp(-x))/2 = -sinh x の十一行を確かめる。
# 帰属: exp の値 exp(x), exp(-x) を QQ 上の独立な不定元 Ep, Em に置く。引数の等号 -(-x) = x は QQ[x] で。
load("../../_shared/hyperbolic_by_definition.sage")

P = PolynomialRing(QQ, 'x'); x = P.gen()
assert -(-x) == x
R = PolynomialRing(QQ, 'Ep,Em,Emm'); Ep, Em, Emm = R.gens(); F = R.fraction_field()
lhs = sinh_by_definition(F(Em), F(Emm))   # 1 行目: sinh(-x)、exp(-(-x)) は独立な不定元 Emm のまま
line1 = (F(Em) - F(Emm)) / 2
assert lhs == line1
assert exp_series(P, -(-x)) == exp_series(P, x)
line2 = (F(Em) - F(Ep)) / 2               # 2 行目: real_double_negation (a → x) の -(-x) = x
assert line1 != line2 and line1.subs(Emm=Ep) == line2
line3 = (F(Em) + (-F(Ep))) / 2            # 3 行目: def_real_difference (y → exp(-x), z → exp(x))
assert line2 == line3
line4 = ((-F(Ep)) + F(Em)) / 2            # 4 行目: 加法の交換律 (p → exp(-x), q → -exp(x))
assert line3 == line4
line5 = ((-F(Ep)) + (-(-F(Em)))) / 2      # 5 行目: real_double_negation (a → exp(-x)) を右辺から左辺へ
assert line4 == line5
line6 = (-(F(Ep) + (-F(Em)))) / 2         # 6 行目: real_negation_of_sum_is_sum_of_negations を右辺から左辺へ
assert line5 == line6
line7 = (-(F(Ep) - F(Em))) / 2            # 7 行目: def_real_difference (y → exp(x), z → exp(-x)) を右辺から左辺へ
assert line6 == line7
assert QQ(2) != 0                         # real_two_is_nonzero
line8 = (-(F(Ep) - F(Em))) * F(2)**(-1)   # 8 行目: def_real_quotient (y → -(exp(x)-exp(-x)), z → 2)
assert line7 == line8
line9 = -((F(Ep) - F(Em)) * F(2)**(-1))   # 9 行目: real_negation_times_is_negation_of_product (t → 2^{-1})
assert line8 == line9
line10 = -((F(Ep) - F(Em)) / 2)           # 10 行目: def_real_quotient (y → exp(x)-exp(-x), z → 2) を右辺から左辺へ（2 ≠ 0）
assert line9 == line10
line11 = -sinh_by_definition(F(Ep), F(Em))  # 11 行目: sinh の定義を右辺から左辺へ
assert line10 == line11
assert line2 != (F(Ep) - F(Em)) / 2       # 対照: 符号を外さずに sinh x と書くのは誤り
print("十一行が QQ 上の不定元 Ep = exp(x), Em = exp(-x) で厳密に一致し、符号を落とした式は一致しない（対照）")
print("RESULT: PASS")
