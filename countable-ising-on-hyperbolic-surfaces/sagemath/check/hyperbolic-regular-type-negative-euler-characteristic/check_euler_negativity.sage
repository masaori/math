# SageMath: Euler incidence 等式から Euler 標数の負性までを厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-negative-euler-characteristic/_prelude.sage")

assert p_bar * q_bar * chi == coefficient * e_bar
assert coefficient * e_bar < 0
assert 0 < p_bar * q_bar
assert chi < 0

print("RESULT: PASS — the regular hyperbolic quotient cellulation has negative Euler characteristic")
