# SageMath: 積差形への分配律による因数分解を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_product_difference_criterion
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-product-difference-criterion/_prelude.sage")

for data in examples:
    p_bar, q_bar = integer_type(data)
    assert p_bar * q_bar - 2 * p_bar - 2 * q_bar + 4 == (p_bar - 2) * (q_bar - 2)

print("RESULT: PASS — distributivity gives the product-difference form")
