# SageMath: 負の Euler 標数へ正の incidence 因子を掛ける一行を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_iff_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic/_prelude.sage")

data = examples[0]
p_bar, q_bar, e_bar, chi, coefficient = integer_data(data)
assert chi < 0
assert 0 < p_bar * q_bar
assert p_bar * q_bar * chi < 0

print("RESULT: PASS — multiplication by the positive incidence factor preserves negativity")
