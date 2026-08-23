# SageMath: 双曲正則型の非狭義積差による特徴付けを三つの正則型で厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_nonstrict_product_difference_criterion
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-nonstrict-product-difference-criterion/_prelude.sage")

for data in examples:
    is_hyperbolic = 2 * (data["p"] + data["q"]) < data["p"] * data["q"]
    assert is_hyperbolic == (5 <= integer_product_difference(data))

print("RESULT: PASS — hyperbolicity is equivalent to the non-strict product-difference inequality")
