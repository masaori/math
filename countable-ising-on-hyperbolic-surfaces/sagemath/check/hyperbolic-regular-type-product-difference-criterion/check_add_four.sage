# SageMath: 両辺へ四を加える同値変形を厳密検算する
# 対象ラベル: theorem_hyperbolic_regular_type_product_difference_criterion
load("countable-ising-on-hyperbolic-surfaces/sagemath/check/hyperbolic-regular-type-product-difference-criterion/_prelude.sage")

for data in examples:
    p_bar, q_bar = integer_type(data)
    difference = p_bar * q_bar - 2 * p_bar - 2 * q_bar
    assert (0 < difference) == (4 < difference + 4)

print("RESULT: PASS — adding four preserves and reflects strict order")
