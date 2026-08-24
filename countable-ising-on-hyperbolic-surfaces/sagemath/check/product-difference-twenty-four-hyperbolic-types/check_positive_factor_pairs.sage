# SageMath: 二十四の正の因子対を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_four_hyperbolic_types

product_difference = NN(24)
positive_divisors = tuple(NN(a) for a in divisors(product_difference))
positive_factor_pairs = Set(
    (a, b)
    for a in positive_divisors
    for b in positive_divisors
    if a * b == product_difference
)
expected_factor_pairs = Set([
    (NN(1), NN(24)),
    (NN(2), NN(12)),
    (NN(3), NN(8)),
    (NN(4), NN(6)),
    (NN(6), NN(4)),
    (NN(8), NN(3)),
    (NN(12), NN(2)),
    (NN(24), NN(1)),
])

assert positive_divisors == (NN(1), NN(2), NN(3), NN(4), NN(6), NN(8), NN(12), NN(24))
assert positive_factor_pairs == expected_factor_pairs

print("RESULT: PASS — twenty-four has exactly the eight positive factor pairs")
