# 対象ラベル: monoid_of_polar_representation
# 証明の「1 は ℝ の乗法の単位元」「0 は ℝ の加法の単位元」（set_and_algebra_notation）の行を、
# 行に書いた形（x·1 = x、1·x = x、x + 0 = x、0 + x = x）と代入どおりに、多項式環の等号で一行ずつ比べる（浮動小数点を使わない）。
def mul_right(x): return (x * 1, x)   # x·1 = x
def mul_left(x):  return (1 * x, x)   # 1·x = x
def add_right(x): return (x + 0, x)   # x + 0 = x
def add_left(x):  return (0 + x, x)   # 0 + x = x
R.<r, theta> = PolynomialRing(QQ)
rows = [
    mul_right(r),      # [(r·1, θ+0)] = [(r, θ+0)]
    add_right(theta),  # [(r, θ+0)] = [(r, θ)]
    mul_left(r),       # [(1·r, 0+θ)] = [(r, 0+θ)]
    add_left(theta),   # [(r, 0+θ)] = [(r, θ)]
]
assert all(R(lhs) == R(rhs) for lhs, rhs in rows)
# 鎖の両端: 成分 (r·1, θ+0) と (r, θ)、(1·r, 0+θ) と (r, θ)
assert (r*R(1), theta + R(0)) == (r, theta) and (R(1)*r, R(0) + theta) == (r, theta)
assert R(2)*r != r   # 対照: 単位元でない元を掛けると一致しない
print("4 unit rows of monoid_of_polar_representation"); print("RESULT: PASS")
