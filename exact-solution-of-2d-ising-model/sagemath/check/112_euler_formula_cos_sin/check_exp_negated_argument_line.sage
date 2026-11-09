# 対象ラベル: euler_formula_cos_sin
# 証明の準備の exp(-iθ) の鎖の 1 行目 exp(-(iθ_C)) = exp(i(-θ)_C) を確かめる。
# 根拠は i_times_negated_real_is_negation_of_i_times（i(-θ)_C = -(iθ_C)）を右辺から左辺へ当てること。
# その主張の鎖は sagemath/check/i_times_negated_real_is_negation_of_i_times/ が一行ずつ確かめている。
# ここでは exp の引数どうしが等しいこと（左辺の引数は主張の読みの -(iθ_C) = (-1_C)(iθ_C)、
# 右辺の引数は i と (-θ)_C の積）だけを確かめ、exp の値は組まない。
# 帰属: QQ(i) 上の多項式環（θ は実数の不定元 t。包含の像 θ_C も同じ t）。浮動小数点なし。
Ki = QuadraticField(-1, 'i')
i = Ki.gen()
R = PolynomialRing(Ki, 't')
t = R.gen()
lhs_arg = R(-1) * (i * t)       # -(iθ_C)：multiply_by_minus_one の (-1_C)(iθ_C)
rhs_arg = i * R(-t)             # i(-θ)_C：ℝ の符号反転 -θ の像と i の積
assert lhs_arg == rhs_arg
# 対照: 符号を落とした iθ_C とは一致しない
assert lhs_arg != i * t
print("checked the line exp(-(iθ_C)) = exp(i(-θ)_C): arguments agree")
print("RESULT: PASS")
