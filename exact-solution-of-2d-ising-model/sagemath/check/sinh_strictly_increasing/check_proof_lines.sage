# 対象ラベル: sinh_strictly_increasing
# 準備の鎖（x < y ⇒ exp(x) < exp(y)、x < y ⇒ -y < -x ⇒ exp(-y) < exp(-x)）と、差の鎖
# sinh y - sinh x = (exp(y)-exp(-y))/2 - (exp(x)-exp(-x))/2 = ((exp(y)-exp(x))+(exp(-x)-exp(-y)))/2 > 0 を確かめる。
# 帰属: 等号の行は exp の値を QQ 上の独立な不定元に置いて厳密に。不等号の行は x < y の 7 組の点 (x, y) ∈ QQ^2 で、
#   exp の値が QQ に収まらないので RealBallField(512) のボールで（下端と上端の比較で厳密に判定できる）。
load("../../_shared/hyperbolic_by_definition.sage")
R = PolynomialRing(QQ, 'Ex,Emx,Ey,Emy'); Ex, Emx, Ey, Emy = R.gens(); F = R.fraction_field()
line1 = sinh_by_definition(F(Ey), F(Emy)) - sinh_by_definition(F(Ex), F(Emx))
assert line1 == (F(Ey) - Emy) / 2 - (F(Ex) - Emx) / 2
line2 = ((F(Ey) - Emy) - (F(Ex) - Emx)) / 2      # 分母の等しい分数の差
assert line1 == line2
line3 = ((F(Ey) - Ex) + (F(Emx) - Emy)) / 2      # 分子の項の並べ替え
assert line2 == line3
print("差の鎖の 1〜3 行目が QQ 上の不定元 exp(x), exp(-x), exp(y), exp(-y) で厳密に一致する")
pairs = [(QQ(0), QQ(1)), (QQ(-1), QQ(0)), (QQ(-3), QQ(-2)), (QQ(1)/10^9, QQ(2)/10^9), (QQ(-20), QQ(30)), (QQ(5)/7, QQ(6)/7), (QQ(-74), QQ(-73))]
for x0, y0 in pairs:
    assert x0 < y0 and -y0 < -x0
    ex, ey, emx, emy = exp_ball(x0), exp_ball(y0), exp_ball(-x0), exp_ball(-y0)
    assert ex < ey and emy < emx                     # 準備の二つの不等式（ボールの上端 < 下端）
    assert (ey - ex) > 0 and (emx - emy) > 0 and (ey - ex) + (emx - emy) > 0   # 分子の正値性の三つの含意
    d = ((ey - ex) + (emx - emy)) / 2
    assert d > 0                                     # 3 行目
    assert (sinh_ball(y0) - sinh_ball(x0)).overlaps(d)
    assert sinh_ball(x0) < sinh_ball(y0)             # 最後の帰結
print(f"{len(pairs)} 組の点で準備の二つの不等式、差の正値性、sinh x < sinh y がボールの比較で成り立つ")
print("RESULT: PASS")
