# SageMath: 整数の双曲不等式を自然数へ反映する一行を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_iff_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic/_prelude.sage")

data = examples[0]
p_bar, q_bar, e_bar, chi, coefficient = integer_data(data)
assert 2 * p_bar + 2 * q_bar < p_bar * q_bar
assert 2 * (data["p"] + data["q"]) < data["p"] * data["q"]

print("RESULT: PASS — the integer inequality reflects to the natural-number inequality")
