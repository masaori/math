# SageMath: 整数の狭義下界四と非狭義下界五の同値性を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_nonstrict_product_difference_criterion
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-nonstrict-product-difference-criterion/_prelude.sage")

for data in examples:
    product_difference = integer_product_difference(data)
    assert (4 < product_difference) == (5 <= product_difference)

print("RESULT: PASS — integer discreteness replaces the strict lower bound four by the non-strict lower bound five")
