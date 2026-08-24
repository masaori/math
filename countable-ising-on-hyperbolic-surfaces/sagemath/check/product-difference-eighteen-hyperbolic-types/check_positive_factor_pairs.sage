# SageMath: 十八の正の因子対を厳密検算する
# 対象ラベル: theorem_product_difference_eighteen_hyperbolic_types

product_difference = NN(18)
positive_divisors = tuple(NN(a) for a in divisors(product_difference))
positive_factor_pairs = Set(
    (a, b)
    for a in positive_divisors
    for b in positive_divisors
    if a * b == product_difference
)
expected_factor_pairs = Set([
    (NN(1), NN(18)),
    (NN(2), NN(9)),
    (NN(3), NN(6)),
    (NN(6), NN(3)),
    (NN(9), NN(2)),
    (NN(18), NN(1)),
])

assert positive_divisors == (NN(1), NN(2), NN(3), NN(6), NN(9), NN(18))
assert positive_factor_pairs == expected_factor_pairs

print("RESULT: PASS — eighteen has exactly the six positive factor pairs")
