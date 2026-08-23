# SageMath: 負の Euler incidence 係数と正の辺数の積を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-negative-euler-characteristic/_prelude.sage")

assert coefficient < 0
assert 0 < e_bar
assert coefficient * e_bar < 0

print("RESULT: PASS — the negative coefficient times the positive edge count is negative")
