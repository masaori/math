# SageMath: 自然数の双曲不等式を整数へ移す一行を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_product_difference_criterion
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-product-difference-criterion/_prelude.sage")

for data in examples:
    p_bar, q_bar = integer_type(data)
    assert (2 * (data["p"] + data["q"]) < data["p"] * data["q"]) == (2 * p_bar + 2 * q_bar < p_bar * q_bar)

print("RESULT: PASS — the natural-number hyperbolic inequality embeds into ZZ")
