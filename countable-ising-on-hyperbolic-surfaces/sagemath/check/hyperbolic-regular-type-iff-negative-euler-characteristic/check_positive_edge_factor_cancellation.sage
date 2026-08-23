# SageMath: 正の辺数因子から Euler incidence 係数の負性を反映する一行を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_iff_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic/_prelude.sage")

data = examples[0]
p_bar, q_bar, e_bar, chi, coefficient = integer_data(data)
assert 0 < e_bar
assert coefficient * e_bar < 0
assert coefficient < 0

print("RESULT: PASS — the positive edge factor reflects negativity of the coefficient")
