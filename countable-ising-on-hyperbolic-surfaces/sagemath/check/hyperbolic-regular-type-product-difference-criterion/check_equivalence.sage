# SageMath: 双曲正則型の積差による特徴付けを三つの正則型で厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_product_difference_criterion
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-product-difference-criterion/_prelude.sage")

for data in examples:
    p_bar, q_bar = integer_type(data)
    is_hyperbolic = 2 * (data["p"] + data["q"]) < data["p"] * data["q"]
    assert is_hyperbolic == (4 < (p_bar - 2) * (q_bar - 2))

print("RESULT: PASS — hyperbolicity is equivalent to the product-difference inequality")
