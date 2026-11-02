# 対象ラベル: arcsinh_argument_two_sided_bounds
# 準備の鎖 s - y = (y+s)(s-y)/(y+s) = 1/(y+s)、下からの評価の三行 y+s = 2y + (s-y) = 2y + 1/(y+s) ≥ 2y、
# 上からの評価の三行 y+s = 2y + (s-y) = 2y + 1/(y+s) ≤ 2y + 1/(2y) を確かめる。
# 帰属:
# - 等号の行は関数体 QQ(y)[s]/(s² - y² - 1) の等号として厳密に（s は √(y²+1) の満たす関係式だけを持つ）。
# - 大小の行と主張は、y ∈ QQ_{>0} の点で s = √(y²+1) を AA（実代数的数）で作り、厳密に比べる（浮動小数点なし）。
load("../../_shared/sine_cosine_by_definition.sage")
Fy.<y> = FunctionField(QQ); Rs.<S> = Fy[]; L.<s> = Fy.extension(S^2 - y^2 - 1)
assert (y + s) * (s - y) == 1                                  # arcsinh_argument_times_conjugate_is_one
assert s - y == (y + s) * (s - y) / (y + s) == 1 / (y + s)     # 準備の鎖
assert y + s == 2*y + (s - y) == 2*y + 1/(y + s)               # 下・上からの評価の 1・2 行目
assert 1/(y + s) == 2*y * (1/((y + s)*2*y)) and (y + s) * (1/((y + s)*2*y)) == 1/(2*y)   # 1/(y+s) ≤ 1/(2y) の鎖の等号
print("準備の鎖と、二つの評価の 1・2 行目が QQ(y)[s]/(s²-y²-1) で成り立つ")
YS = [QQ(1)/1000, QQ(1)/10, QQ(1)/2, QQ(1), QQ(3), QQ(100), QQ(10)^6]
for y0 in YS:
    s0 = sqrt_nonneg(y0^2 + 1)
    assert y0 + s0 > 0 and (y0 + s0) * (s0 - y0) == 1
    assert 1/(y0 + s0) > 0 and 2*y0 + 1/(y0 + s0) >= 2*y0                 # 下からの評価の 3 行目
    m = 1/((y0 + s0)*2*y0); assert m > 0 and 2*y0*m <= (y0 + s0)*m          # 1/(y+s) ≤ 1/(2y) の鎖の 2 行目
    assert y0 + s0 >= 2*y0 > 0 and 1/(y0 + s0) <= 1/(2*y0)
    assert 2*y0 + 1/(y0 + s0) <= 2*y0 + 1/(2*y0)                          # 上からの評価の 3 行目
    assert 2*y0 <= y0 + s0 <= 2*y0 + 1/(2*y0)                             # 主張
print(f"{len(YS)} 点の y > 0 で大小の行と主張が AA で厳密に成り立つ")
y0 = QQ(-1); s0 = sqrt_nonneg(2)
assert not (y0 + s0 <= 2*y0 + 1/(2*y0))
print("対照: y = -1 では上からの評価が成り立たない（y > 0 が要る）")
print("RESULT: PASS")
