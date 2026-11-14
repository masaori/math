# 対象ラベル: eigenvector_of_A_theta_tilde
# Step 1 の準備の因数分解の恒等式 (λ − (g_1+r))(λ − (g_1−r)) = λ^2 − 2g_1λ + (g_1^2 − r^2) の 8 行の鎖を、
# QQ(i) 上の多項式環 K[λ, g1, r] で行の括弧どおりに組み、隣どうしを比べる。
# 本文の g_1, r ∈ ℝ と λ ∈ ℂ は、鎖の中では ℂ の元として掛け合わされるので、不定元として一般の等式を確かめる。
# 浮動小数点は使わない。
K = QuadraticField(-1, 'i')
R.<lam, g1, r> = PolynomialRing(K)

rows = [
    ("(λ−(g1+r))(λ−(g1−r))", (lam - (g1 + r)) * (lam - (g1 - r))),
    ("λ²−(g1−r)λ−(g1+r)λ+(g1+r)(g1−r)", lam**2 - (g1 - r)*lam - (g1 + r)*lam + (g1 + r)*(g1 - r)),        # 分配則
    ("λ²−2g1λ+(g1+r)(g1−r)", lam**2 - 2*g1*lam + (g1 + r)*(g1 - r)),                                   # 同類項の統合
    ("λ²−2g1λ+(g1²−g1r+rg1−r²)", lam**2 - 2*g1*lam + (((g1**2 - g1*r) + r*g1) - r**2)),                # 分配則
    ("λ²−2g1λ+(((g1²−g1r)+g1r)−r²)", lam**2 - 2*g1*lam + (((g1**2 - g1*r) + g1*r) - r**2)),             # 積の可換律
    ("λ²−2g1λ+(((g1²+(−(g1r)))+g1r)−r²)", lam**2 - 2*g1*lam + (((g1**2 + (-(g1*r))) + g1*r) - r**2)),  # def_complex_difference
    ("λ²−2g1λ+((g1²+((−(g1r))+g1r))−r²)", lam**2 - 2*g1*lam + ((g1**2 + ((-(g1*r)) + g1*r)) - r**2)),  # 和の結合律
    ("λ²−2g1λ+((g1²+0)−r²)", lam**2 - 2*g1*lam + ((g1**2 + R(0)) - r**2)),                            # negation_plus_self_is_zero_in_cc
    ("λ²−2g1λ+(g1²−r²)", lam**2 - 2*g1*lam + (g1**2 - r**2)),                                         # 加法の単位元
]
for t in range(len(rows) - 1):
    assert rows[t][1] == rows[t + 1][1], (t, rows[t][0], rows[t + 1][0])
    print(f"PASS: {rows[t][0]} = {rows[t + 1][0]}")
# 個々の行で当てた事実
assert r*g1 == g1*r and (-(g1*r)) + g1*r == R(0) and g1**2 + R(0) == g1**2
# 否定コントロール: 最後の行の符号を g1² + r² に替えると一致しない
assert rows[0][1] != lam**2 - 2*g1*lam + (g1**2 + r**2)
print("否定コントロール: g1² + r² では一致しない")
print("ALL PASS")
