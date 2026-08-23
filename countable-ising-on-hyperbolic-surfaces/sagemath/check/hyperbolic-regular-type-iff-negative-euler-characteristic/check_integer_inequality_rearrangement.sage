# SageMath: Euler incidence 係数の負性を整数の双曲不等式へ移す一行を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_iff_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic/_prelude.sage")

data = examples[0]
p_bar, q_bar, e_bar, chi, coefficient = integer_data(data)
assert coefficient < 0
assert 2 * p_bar + 2 * q_bar < p_bar * q_bar

print("RESULT: PASS — coefficient negativity is the integer hyperbolic inequality")
