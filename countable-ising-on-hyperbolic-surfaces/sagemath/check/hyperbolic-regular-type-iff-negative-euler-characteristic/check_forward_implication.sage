# SageMath: 双曲正則型から負の Euler 標数への順方向を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_iff_negative_euler_characteristic
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-iff-negative-euler-characteristic/_prelude.sage")

for data in examples:
    p_bar, q_bar, e_bar, chi, coefficient = integer_data(data)
    is_hyperbolic = 2 * (data["p"] + data["q"]) < data["p"] * data["q"]
    assert not is_hyperbolic or chi < 0

print("RESULT: PASS — hyperbolic regular type implies negative Euler characteristic")
