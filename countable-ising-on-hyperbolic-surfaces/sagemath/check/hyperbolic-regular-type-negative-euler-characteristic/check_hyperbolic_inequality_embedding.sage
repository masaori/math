# SageMath: 双曲正則型の自然数不等式を整数へ移す一行を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-negative-euler-characteristic/_prelude.sage")

assert 2 * (p + q) < p * q
assert 2 * p_bar + 2 * q_bar < p_bar * q_bar

print("RESULT: PASS — the hyperbolic natural-number inequality embeds into ZZ")
