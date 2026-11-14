# 対象ラベル: eigenvector_of_A_theta_tilde
# Step 1 の det(A(θ) − λI) の鎖のうち、行列式の定義の行 (g_1−λ)(g_1−λ) − a(−b) から
# λ^2 − (2_ℂg_1)λ + (g_1^2 + ab) までの 27 個の式（26 行）を、QQ(i) 上の多項式環 K[λ, g1, a, b] で
# 行の括弧どおりに組み、隣どうしを比べる。浮動小数点は使わない。
K = QuadraticField(-1, 'i')
R.<lam, g1, a, b> = PolynomialRing(K)
m1 = R(-1)      # -1_ℂ
one = R(1)      # 1_ℂ
two = R(2)      # 2_ℂ
GL = g1*lam
T = (two*g1)*lam
D = (g1 - lam)*(g1 - lam)
E = g1 + (-lam)

rows = [
    ("(g1−λ)(g1−λ) − a(−b)", D - a*(-b)),
    ("(g1−λ)(g1−λ) + (−(a(−b)))", D + (-(a*(-b)))),                                          # def_complex_difference
    ("(g1−λ)(g1−λ) + (−(−(ab)))", D + (-(-(a*b)))),                                           # complex_times_negation
    ("(g1−λ)(g1−λ) + ab", D + a*b),                                                            # double_negation
    ("(g1+(−λ))(g1+(−λ)) + ab", E*E + a*b),                                                    # def_complex_difference ×2
    ("(g1(g1+(−λ)) + (−λ)(g1+(−λ))) + ab", (g1*E + (-lam)*E) + a*b),                          # 右からの分配律
    ("((g1g1+g1(−λ)) + ((−λ)g1+(−λ)(−λ))) + ab", ((g1*g1 + g1*(-lam)) + ((-lam)*g1 + (-lam)*(-lam))) + a*b),  # 左からの分配律 ×2
    ("((g1g1+(−(g1λ))) + ((−λ)g1+(−λ)(−λ))) + ab", ((g1*g1 + (-GL)) + ((-lam)*g1 + (-lam)*(-lam))) + a*b),   # complex_times_negation
    ("((g1g1+(−(g1λ))) + ((−(λg1))+(−(λ(−λ))))) + ab", ((g1*g1 + (-GL)) + ((-(lam*g1)) + (-(lam*(-lam))))) + a*b),  # negation_times_complex ×2
    ("((g1g1+(−(g1λ))) + ((−(λg1))+(−(−(λλ))))) + ab", ((g1*g1 + (-GL)) + ((-(lam*g1)) + (-(-(lam*lam))))) + a*b),  # complex_times_negation
    ("((g1g1+(−(g1λ))) + ((−(λg1))+λλ)) + ab", ((g1*g1 + (-GL)) + ((-(lam*g1)) + lam*lam)) + a*b),          # double_negation
    ("((g1g1+(−(g1λ))) + ((−(g1λ))+λλ)) + ab", ((g1*g1 + (-GL)) + ((-GL) + lam*lam)) + a*b),                 # 積の可換律
    ("(((g1g1+(−(g1λ)))+(−(g1λ))) + λλ) + ab", (((g1*g1 + (-GL)) + (-GL)) + lam*lam) + a*b),                  # 結合律（右→左）
    ("((g1g1+((−(g1λ))+(−(g1λ)))) + λλ) + ab", ((g1*g1 + ((-GL) + (-GL))) + lam*lam) + a*b),                  # 結合律
    ("((g1g1+((−1)(g1λ)+(−1)(g1λ))) + λλ) + ab", ((g1*g1 + (m1*GL + m1*GL)) + lam*lam) + a*b),                # multiply_by_minus_one ×2
    ("((g1g1+(−1)(g1λ+g1λ)) + λλ) + ab", ((g1*g1 + m1*(GL + GL)) + lam*lam) + a*b),                           # 左からの分配律（右→左）
    ("((g1g1+(−1)(1(g1λ)+1(g1λ))) + λλ) + ab", ((g1*g1 + m1*(one*GL + one*GL)) + lam*lam) + a*b),             # 積の単位元 ×2（右→左）
    ("((g1g1+(−1)((1+1)(g1λ))) + λλ) + ab", ((g1*g1 + m1*((one + one)*GL)) + lam*lam) + a*b),                 # 右からの分配律（右→左）
    ("((g1g1+(−1)(2(g1λ))) + λλ) + ab", ((g1*g1 + m1*(two*GL)) + lam*lam) + a*b),                             # one_plus_one_is_two_in_cc
    ("((g1g1+(−1)((2g1)λ)) + λλ) + ab", ((g1*g1 + m1*T) + lam*lam) + a*b),                                    # 積の結合律（右→左）
    ("((g1g1+(−((2g1)λ))) + λλ) + ab", ((g1*g1 + (-T)) + lam*lam) + a*b),                                     # multiply_by_minus_one（右→左）
    ("(λλ+(g1g1+(−((2g1)λ)))) + ab", (lam*lam + (g1*g1 + (-T))) + a*b),                                       # 加法の可換律
    ("(λλ+((−((2g1)λ))+g1g1)) + ab", (lam*lam + ((-T) + g1*g1)) + a*b),                                       # 加法の可換律
    ("((λλ+(−((2g1)λ)))+g1g1) + ab", ((lam*lam + (-T)) + g1*g1) + a*b),                                       # 結合律（右→左）
    ("(λλ+(−((2g1)λ))) + (g1g1+ab)", (lam*lam + (-T)) + (g1*g1 + a*b)),                                       # 結合律
    ("(λλ−(2g1)λ) + (g1g1+ab)", (lam*lam - T) + (g1*g1 + a*b)),                                               # def_complex_difference（右→左）
    ("λ²−(2g1)λ + (g1²+ab)", (lam**2 - T) + (g1**2 + a*b)),                                                   # square ×2（右→左）
]
assert len(rows) == 27
for t in range(len(rows) - 1):
    assert rows[t][1] == rows[t + 1][1], (t, rows[t][0], rows[t + 1][0])
    print(f"PASS: {rows[t][0]} = {rows[t + 1][0]}")
# 先頭の式が Sage の組み込みの行列式と一致すること
A = matrix(R, [[g1 - lam, a], [-b, g1 - lam]])
assert rows[0][1] == A.det()
# 個々の行で当てた事実
assert a*(-b) == -(a*b) and g1*(-lam) == -(g1*lam) and lam*(-lam) == -(lam*lam)   # complex_times_negation
assert (-lam)*g1 == -(lam*g1) and (-lam)*(-lam) == -(lam*(-lam))                   # negation_times_complex
assert -(-(a*b)) == a*b and -(-(lam*lam)) == lam*lam                               # double_negation_in_cc
assert -GL == m1*GL and -T == m1*T                                                 # multiply_by_minus_one
assert one + one == two and one*GL == GL and two*GL == T                           # one_plus_one・積の単位元・積の結合律
assert lam**2 == lam*lam and g1**2 == g1*g1                                        # square_of_complex_number_is_product
# 否定コントロール: 係数を 2 でなく 1 にしても、ab の符号を逆にしても一致しない
assert rows[0][1] != (lam**2 - g1*lam) + (g1**2 + a*b)
assert rows[0][1] != (lam**2 - T) + (g1**2 - a*b)
print("否定コントロール: 係数 1、ab の符号反転では一致しない")
print("ALL PASS")
