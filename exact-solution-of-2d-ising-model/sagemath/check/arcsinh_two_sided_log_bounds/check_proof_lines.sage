# 対象ラベル: arcsinh_two_sided_log_bounds
# 下からの評価の二行 arcsinh(y) = log(y+s) ≥ log(2y) と、上からの評価の五行
# arcsinh(y) = log(y+s) ≤ log(2y + 1/(2y)) = log(2y(1 + 1/(4y²))) = log(2y) + log(1 + 1/(4y²)) ≤ log(2y) + 1/(4y²) を確かめる。
# 帰属:
# - 四則と分配則の二行 2y + 1/(2y) = 2y + 2y·1/(4y²) = 2y(1 + 1/(4y²)) は QQ(y) の等号として厳密に。
# - log の引数の大小（y+s と 2y、2y + 1/(2y)）は AA で厳密に。
# - log の値の行は、y ∈ QQ_{>0} の点で Arb のボールへ脱出して確かめる（log の値が QQ に入らないため）。
#   1 行目の arcsinh(y) は本文の定義 log(y + √(y²+1)) を Arb の log で囲んだものと、Arb の asinh（別の経路）の両方で見る。
load("../../_shared/log_integral_by_balls.sage")
Fy = QQ['y'].fraction_field(); y = Fy.gen()
assert 2*y + 1/(2*y) == 2*y + 2*y*(1/(4*y^2)) == 2*y*(1 + 1/(4*y^2))
print("四則と分配則の二行 2y + 1/(2y) = 2y + 2y·1/(4y²) = 2y(1 + 1/(4y²)) が QQ(y) で成り立つ")
YS = [QQ(1)/1000, QQ(1)/10, QQ(1)/2, QQ(1), QQ(3), QQ(100), QQ(10)^6]
for y0 in YS:
    s0 = AA(y0^2 + 1).sqrt()
    assert 2*y0 <= y0 + s0 <= 2*y0 + 1/(2*y0)                     # log の引数の大小（AA）
    a0 = arcsinh_ball(y0)
    assert surely_equal(a0, RBF512(y0).arcsinh())                 # 1 行目（定義）を別の経路でも
    l1 = log_ball(y0 + s0)
    assert surely_equal(a0, l1)
    assert surely_le(log_ball(2*y0), l1)                          # 下からの評価の 2 行目
    l2 = log_ball(2*y0 + 1/(2*y0)); assert surely_le(l1, l2)
    l3 = log_ball(2*y0 * (1 + 1/(4*y0^2))); assert surely_equal(l2, l3)
    l4 = log_ball(2*y0) + log_ball(1 + 1/(4*y0^2)); assert surely_equal(l3, l4)
    l5 = log_ball(2*y0) + 1/(4*y0^2); assert surely_le(l4, l5)
    assert surely_le(log_ball(2*y0), a0) and surely_le(a0, l5)    # 主張
print(f"{len(YS)} 点の y > 0 で両方の評価の各行と主張がボールで確定する")
y0 = QQ(10)
assert surely_lt(log_ball(2*y0) + 1/(8*y0^2), arcsinh_ball(y0))
print("対照: y = 10 で上の余り 1/(4y²) を 1/(8y²) に減らすと成り立たない")
print("RESULT: PASS")
