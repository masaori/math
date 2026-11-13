# 対象ラベル: twice_times_inverse_of_two_is_original_in_cc
# 主張の前置き: 2_C = (2,0) ≠ (0,0) = 0_C なので 2_C ∈ C^×。
# 証明の四行の鎖の五つの項（z ∈ C）:
#   (2_C z) 2_C^{-1} = (z 2_C) 2_C^{-1} = z (2_C 2_C^{-1}) = z 1_C = z
# z を不定元にした QQ(i) 上の有理関数体で、各行に書かれた式どおりに項を組み、隣り合う項が等しいことを確かめる。
# 2_C^{-1} は 2_C 2_C^{-1} = 1_C を満たす元（multiplicative_group_of_cc の逆元）として QQ の 1/2 を置く。
# 帰属: 係数はすべて QQ(i) の元。浮動小数点と RR / CC への脱出はない。

K.<I> = QuadraticField(-1)
R.<z> = PolynomialRing(K)
F = R.fraction_field()
z = F(z)
two = F(2)
two_inv = F(QQ(1) / 2)
one = F(1)
assert (QQ(2), QQ(0)) != (QQ(0), QQ(0))          # 前置き: 2_C = (2,0) ≠ (0,0) = 0_C
assert two * two_inv == one                       # multiplicative_group_of_cc の逆元
chain = [
    (two * z) * two_inv,     # (2_C z) 2_C^{-1}
    (z * two) * two_inv,     # (z 2_C) 2_C^{-1}      積の可換律
    z * (two * two_inv),     # z (2_C 2_C^{-1})      積の結合律
    z * one,                 # z 1_C                 multiplicative_group_of_cc の逆元
    z,                       # z                     積の単位元
]
for k in range(len(chain) - 1):
    assert chain[k] == chain[k + 1], k
# 具体的な値での当てはめ（Z_Y_linearly_independent が z → c_0, c_z, c_x, ic_y で引く形）
for w in (K(0), K(1), I, K(3) - 2 * I, K(-5) / 7):
    assert (K(2) * w) * K(2)^-1 == w
# 否定の対照: 2_C^{-1} の代わりに 2_C を掛けると z に戻らない
assert (two * z) * two != z
print("checked the chain of 5 terms over QQ(i)(z)")
print("RESULT: PASS")
