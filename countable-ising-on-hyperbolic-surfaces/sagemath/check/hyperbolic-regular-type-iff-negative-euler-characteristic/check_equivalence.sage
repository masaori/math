# SageMath: 双曲正則型と負の Euler 標数の同値性を三つの正則セル分割で厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_iff_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic/_prelude.sage")

for data in examples:
    p_bar, q_bar, e_bar, chi, coefficient = integer_data(data)
    assert p_bar * q_bar * chi == coefficient * e_bar
    is_hyperbolic = 2 * (data["p"] + data["q"]) < data["p"] * data["q"]
    assert is_hyperbolic == (chi < 0)

print("RESULT: PASS — hyperbolic regular type is equivalent to negative Euler characteristic")
