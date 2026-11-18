# 対象ラベル: multiplicative_group_of_cc
# 証明の「逆元の存在」の鎖のうち、参照で根拠を書いた 2 行を、参照先の定め方どおりに確かめる（浮動小数点を使わない）。
#   第 2 の等号: definition_of_cc の積 (a,b)(c,d) := (ac − bd, ad + bc) の c → a/(a²+b²), d → −b/(a²+b²)。
#   最後の等号: inclusion_rr_to_cc の 1_C = (1,0) を右辺から左辺へ。
# 成分は QQ(a, b)（有理関数体）に置き、a² + b² ≠ 0 は分母として使える元であることだけを使う。
load("../../_shared/complex_as_real_pairs.sage")
F.<a, b> = FractionField(PolynomialRing(QQ, 'a, b'))
s = a^2 + b^2
z = (a, b)
w = (a/s, -b/s)
# 第 2 の等号の左辺を definition_of_cc の積で組み、行に書いた右辺（a·a/s − b·(−b/s), a·(−b/s) + b·a/s）と比べる
row2 = (a*(a/s) - b*(-b/s), a*(-b/s) + b*(a/s))
assert cc_mul(z, w) == row2
# 対照: c と d を入れ替えて当てると一致しない
assert cc_mul(z, (w[1], w[0])) != row2
# 最後の等号: 鎖の直前の値 (1, 0) が inclusion_rr_to_cc の 1_C と等しい
assert iota(1, F) == (F(1), F(0))
assert iota(1, F) != (F(0), F(1))   # 対照
# 鎖の両端: z·w = 1_C
assert cc_mul(z, w) == iota(1, F)
print("inverse chain cited rows of multiplicative_group_of_cc"); print("RESULT: PASS")
