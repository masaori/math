# SageMath: 双曲不等式から Euler incidence 係数が負になる一行を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-negative-euler-characteristic/_prelude.sage")

assert 2 * p_bar + 2 * q_bar < p_bar * q_bar
assert coefficient < 0

print("RESULT: PASS — the Euler-incidence coefficient is negative in ZZ")
