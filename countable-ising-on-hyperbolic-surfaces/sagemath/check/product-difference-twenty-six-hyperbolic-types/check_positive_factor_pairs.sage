# SageMath: 二十六の正の因子対を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_six_hyperbolic_types

product_difference = NN(26)
positive_divisors = tuple(NN(a) for a in divisors(product_difference))
positive_factor_pairs = Set(
    (a, b)
    for a in positive_divisors
    for b in positive_divisors
    if a * b == product_difference
)
expected_factor_pairs = Set([
    (NN(1), NN(26)),
    (NN(2), NN(13)),
    (NN(13), NN(2)),
    (NN(26), NN(1)),
])

assert positive_divisors == (NN(1), NN(2), NN(13), NN(26))
assert positive_factor_pairs == expected_factor_pairs

print("RESULT: PASS — twenty-six has exactly the four positive factor pairs")
