# SageMath: 二十一の正の因子対を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_one_hyperbolic_types

product_difference = NN(21)
positive_divisors = tuple(NN(a) for a in divisors(product_difference))
positive_factor_pairs = Set(
    (a, b)
    for a in positive_divisors
    for b in positive_divisors
    if a * b == product_difference
)
expected_factor_pairs = Set([
    (NN(1), NN(21)),
    (NN(3), NN(7)),
    (NN(7), NN(3)),
    (NN(21), NN(1)),
])

assert positive_divisors == (NN(1), NN(3), NN(7), NN(21))
assert positive_factor_pairs == expected_factor_pairs

print("RESULT: PASS — twenty-one has exactly the four positive factor pairs")
