# 対象ラベル: sinh_is_odd
# 証明の鎖 sinh(-x) = (exp(-x)-exp(-(-x)))/2 = (exp(-x)-exp(x))/2 = (-(exp(x)-exp(-x)))/2 = -(exp(x)-exp(-x))/2 = -sinh x の五行を確かめる。
# 帰属: exp の値 exp(x), exp(-x) を QQ 上の独立な不定元 Ep, Em に置く。引数の等号 -(-x) = x は QQ[x] で。
load("../../_shared/hyperbolic_by_definition.sage")

P = PolynomialRing(QQ, 'x'); x = P.gen()
assert -(-x) == x
R = PolynomialRing(QQ, 'Ep,Em,Emm'); Ep, Em, Emm = R.gens(); F = R.fraction_field()
lhs = sinh_by_definition(F(Em), F(Emm))   # 1 行目: sinh(-x)、exp(-(-x)) は独立な不定元 Emm のまま
line1 = (F(Em) - F(Emm)) / 2
assert lhs == line1
assert exp_series(P, -(-x)) == exp_series(P, x)
line2 = (F(Em) - F(Ep)) / 2               # 2 行目: -(-x) = x
assert line1 != line2 and line1.subs(Emm=Ep) == line2
line3 = (-(F(Ep) - F(Em))) / 2            # 3 行目: a - b = -(b - a)
assert line2 == line3
line4 = -((F(Ep) - F(Em)) / 2)            # 4 行目: 分子の符号を外へ
assert line3 == line4
line5 = -sinh_by_definition(F(Ep), F(Em))
assert line4 == line5
assert line2 != (F(Ep) - F(Em)) / 2       # 対照: 符号を外さずに sinh x と書くのは誤り
print("五行が QQ 上の不定元 Ep = exp(x), Em = exp(-x) で厳密に一致し、符号を落とした式は一致しない（対照）")
print("RESULT: PASS")
