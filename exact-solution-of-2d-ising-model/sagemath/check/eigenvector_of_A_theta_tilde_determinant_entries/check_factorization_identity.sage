# 対象ラベル: eigenvector_of_A_theta_tilde
# Step 1 の準備の因数分解の恒等式 (λ − (x+y))(λ − (x−y)) = λ^2 − 2_ℂxλ + (x^2 − y^2)（λ, x, y ∈ ℂ）の 31 個の式の鎖を、
# QQ(i) 上の多項式環 K[λ, x, y] で行の括弧どおりに組み、隣どうしを比べる。
# det の鎖の最後の行は、この恒等式を x → (g_1)_ℂ, y → r_ℂ として引く。
# 浮動小数点は使わない。
K = QuadraticField(-1, 'i')
R.<lam, x, y> = PolynomialRing(K)
m1 = R(-1)      # -1_ℂ
two = R(2)      # 2_ℂ
NN = (-(x + y)) * (-(x - y))
L2 = lam**2 - (two*x)*lam

rows = [
    ("(λ−(x+y))(λ−(x−y))", (lam - (x + y)) * (lam - (x - y))),
    ("(λ+(−(x+y)))(λ+(−(x−y)))", (lam + (-(x + y))) * (lam + (-(x - y)))),                        # def_complex_difference ×2
    ("λ(λ+(−(x−y)))+(−(x+y))(λ+(−(x−y)))", lam*(lam + (-(x - y))) + (-(x + y))*(lam + (-(x - y)))),  # 右からの分配律
    ("(λλ+λ(−(x−y)))+((−(x+y))λ+NN)", (lam*lam + lam*(-(x - y))) + ((-(x + y))*lam + NN)),          # 左からの分配律 ×2
    ("((λλ+λ(−(x−y)))+(−(x+y))λ)+NN", ((lam*lam + lam*(-(x - y))) + (-(x + y))*lam) + NN),          # 結合律（右→左）
    ("(λλ+(λ(−(x−y))+(−(x+y))λ))+NN", (lam*lam + (lam*(-(x - y)) + (-(x + y))*lam)) + NN),          # 結合律
    ("(λλ+((−(x−y))λ+(−(x+y))λ))+NN", (lam*lam + ((-(x - y))*lam + (-(x + y))*lam)) + NN),          # 積の可換律
    ("(λλ+((−(x−y))+(−(x+y)))λ)+NN", (lam*lam + ((-(x - y)) + (-(x + y)))*lam) + NN),               # 右からの分配律（右→左）
    ("(λλ+((−1)(x−y)+(−1)(x+y))λ)+NN", (lam*lam + (m1*(x - y) + m1*(x + y))*lam) + NN),             # multiply_by_minus_one ×2
    ("(λλ+((−1)((x−y)+(x+y)))λ)+NN", (lam*lam + (m1*((x - y) + (x + y)))*lam) + NN),                # 左からの分配律（右→左）
    ("(λλ+(−((x−y)+(x+y)))λ)+NN", (lam*lam + (-((x - y) + (x + y)))*lam) + NN),                     # multiply_by_minus_one（右→左）
    ("(λλ+(−((x+y)+(x−y)))λ)+NN", (lam*lam + (-((x + y) + (x - y)))*lam) + NN),                     # 加法の可換律
    ("(λλ+(−(2x))λ)+NN", (lam*lam + (-(two*x))*lam) + NN),                                          # sum_plus_difference
    ("(λλ+(−((2x)λ)))+NN", (lam*lam + (-((two*x)*lam))) + NN),                                      # negation_times_complex
    ("(λλ−(2x)λ)+NN", (lam*lam - (two*x)*lam) + NN),                                                # def_complex_difference（右→左）
    ("(λ²−(2x)λ)+NN", L2 + NN),                                                                     # square（右→左）
    ("(λ²−(2x)λ)+(−((x+y)(−(x−y))))", L2 + (-((x + y)*(-(x - y))))),                                # negation_times_complex
    ("(λ²−(2x)λ)+(−(−((x+y)(x−y))))", L2 + (-(-((x + y)*(x - y))))),                                # complex_times_negation
    ("(λ²−(2x)λ)+(x+y)(x−y)", L2 + (x + y)*(x - y)),                                                # double_negation
    ("(λ²−(2x)λ)+(x(x−y)+y(x−y))", L2 + (x*(x - y) + y*(x - y))),                                   # 右からの分配律
    ("(λ²−(2x)λ)+(x(x+(−y))+y(x+(−y)))", L2 + (x*(x + (-y)) + y*(x + (-y)))),                       # def_complex_difference ×2
    ("(λ²−(2x)λ)+((xx+x(−y))+(yx+y(−y)))", L2 + ((x*x + x*(-y)) + (y*x + y*(-y)))),                 # 左からの分配律 ×2
    ("(λ²−(2x)λ)+((xx+(−(xy)))+(yx+(−(yy))))", L2 + ((x*x + (-(x*y))) + (y*x + (-(y*y))))),         # complex_times_negation ×2
    ("(λ²−(2x)λ)+(((xx+(−(xy)))+yx)+(−(yy)))", L2 + (((x*x + (-(x*y))) + y*x) + (-(y*y)))),         # 結合律（右→左）
    ("(λ²−(2x)λ)+(((xx−xy)+yx)−yy)", L2 + (((x*x - x*y) + y*x) - y*y)),                             # def_complex_difference ×2（右→左）
    ("(λ²−(2x)λ)+(((x²−xy)+yx)−y²)", L2 + (((x**2 - x*y) + y*x) - y**2)),                           # square ×2（右→左）
    ("(λ²−(2x)λ)+(((x²−xy)+xy)−y²)", L2 + (((x**2 - x*y) + x*y) - y**2)),                           # 積の可換律
    ("(λ²−(2x)λ)+(((x²+(−(xy)))+xy)−y²)", L2 + (((x**2 + (-(x*y))) + x*y) - y**2)),                 # def_complex_difference
    ("(λ²−(2x)λ)+((x²+((−(xy))+xy))−y²)", L2 + ((x**2 + ((-(x*y)) + x*y)) - y**2)),                 # 和の結合律
    ("(λ²−(2x)λ)+((x²+0)−y²)", L2 + ((x**2 + R(0)) - y**2)),                                        # negation_plus_self_is_zero_in_cc
    ("(λ²−(2x)λ)+(x²−y²)", L2 + (x**2 - y**2)),                                                     # 加法の単位元
]
assert len(rows) == 31
for t in range(len(rows) - 1):
    assert rows[t][1] == rows[t + 1][1], (t, rows[t][0], rows[t + 1][0])
    print(f"PASS: {rows[t][0]} = {rows[t + 1][0]}")
# 個々の行で当てた事実
a, b = x, y
assert (a + b) + (a - b) == two*a                                   # sum_plus_difference_is_twice_first_in_cc
assert (-(two*x))*lam == -((two*x)*lam)                             # negation_times_complex_is_negation_of_product_in_cc
assert (x + y)*(-(x - y)) == -((x + y)*(x - y))                     # complex_times_negation_is_negation_of_product_in_cc
assert -(-((x + y)*(x - y))) == (x + y)*(x - y)                     # double_negation_in_cc
assert -(x - y) == m1*(x - y) and -(x + y) == m1*(x + y)            # multiply_by_minus_one
assert lam**2 == lam*lam and x**2 == x*x and y**2 == y*y            # square_of_complex_number_is_product
assert y*x == x*y and (-(x*y)) + x*y == R(0) and x**2 + R(0) == x**2
# 否定コントロール: 最後の行の符号を x² + y² に替えると一致しない。係数を 2 でなく 1 にしても一致しない
assert rows[0][1] != L2 + (x**2 + y**2)
assert rows[0][1] != (lam**2 - x*lam) + (x**2 - y**2)
print("否定コントロール: x² + y²、係数 1 では一致しない")
print("ALL PASS")
