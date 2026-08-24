# SageMath: 二十二の正の因子対を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_two_hyperbolic_types

product_difference = NN(22)
positive_divisors = tuple(NN(a) for a in divisors(product_difference))
positive_factor_pairs = Set(
    (a, b)
    for a in positive_divisors
    for b in positive_divisors
    if a * b == product_difference
)
expected_factor_pairs = Set([
    (NN(1), NN(22)),
    (NN(2), NN(11)),
    (NN(11), NN(2)),
    (NN(22), NN(1)),
])

assert positive_divisors == (NN(1), NN(2), NN(11), NN(22))
assert positive_factor_pairs == expected_factor_pairs

print("RESULT: PASS — twenty-two has exactly the four positive factor pairs")
