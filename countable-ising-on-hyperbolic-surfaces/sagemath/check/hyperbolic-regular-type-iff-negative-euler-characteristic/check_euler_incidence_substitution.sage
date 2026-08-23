# SageMath: Euler incidence 等式による積の置換を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_iff_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic/_prelude.sage")

data = examples[0]
p_bar, q_bar, e_bar, chi, coefficient = integer_data(data)
assert p_bar * q_bar * chi == coefficient * e_bar
assert p_bar * q_bar * chi < 0
assert coefficient * e_bar < 0

print("RESULT: PASS — Euler incidence identity preserves the negative product")
