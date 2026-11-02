# 対象ラベル: cosh_is_even
# 証明の鎖 cosh(-x) = (exp(-x)+exp(-(-x)))/2 = (exp(-x)+exp(x))/2 = (exp(x)+exp(-x))/2 = cosh x の四行を確かめる。
# 帰属: exp の値 exp(x), exp(-x), exp(-(-x)) を QQ 上の独立な不定元 Ep, Em, Emm に置く（どの行も exp の性質を使わないことまで確かめる）。
# 2 行目は Emm を Ep に置き換える行で、-(-x) = x（QQ[x]）と exp(-(-x)) = exp(x)（形式冪級数）を確かめる。
# 引数の等号 -(-x) = x は QQ[x] の等号として確かめる。
load("../../_shared/hyperbolic_by_definition.sage")

P = PolynomialRing(QQ, 'x'); x = P.gen()
assert -(-x) == x and -(-x) != -x
print("-(-x) = x が QQ[x] で成り立つ（-(-x) ≠ -x）")

R = PolynomialRing(QQ, 'Ep,Em,Emm'); Ep, Em, Emm = R.gens(); F = R.fraction_field()
# 1 行目: cosh の定義を引数 -x に当てはめる。exp(-(-x)) はまず独立な不定元 Emm のまま置く
lhs = cosh_by_definition(F(Em), F(Emm))
line1 = (F(Em) + F(Emm)) / 2
assert lhs == line1
# 2 行目: -(-x) = x により exp(-(-x)) と exp(x) は同じ値。形式冪級数でも exp(-(-x)) = exp(x) を確かめる
assert exp_series(P, -(-x)) == exp_series(P, x)
line2 = (F(Em) + F(Ep)) / 2
assert line1 != line2 and line1.subs(Emm=Ep) == line2
line3 = (F(Ep) + F(Em)) / 2          # 加法の交換律
assert line2 == line3
line4 = cosh_by_definition(F(Ep), F(Em))   # cosh x
assert line3 == line4
# 対照: sinh では同じ置き換えで符号が変わる
assert sinh_by_definition(F(Em), F(Ep)) != sinh_by_definition(F(Ep), F(Em))
print("四行が QQ 上の不定元 Ep = exp(x), Em = exp(-x) で厳密に一致し、sinh では一致しない（対照）")
print("RESULT: PASS")
