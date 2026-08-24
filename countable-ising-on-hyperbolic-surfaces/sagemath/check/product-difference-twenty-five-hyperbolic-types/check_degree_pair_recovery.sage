# SageMath: 二十五の正の因子対から次数対を復元する
# 対象ラベル: theorem_product_difference_twenty_five_hyperbolic_types

factor_pairs = Set([
    (NN(1), NN(25)),
    (NN(5), NN(5)),
    (NN(25), NN(1)),
])
degree_pairs = Set((a + NN(2), b + NN(2)) for a, b in factor_pairs)
expected_degree_pairs = Set([
    (NN(3), NN(27)),
    (NN(7), NN(7)),
    (NN(27), NN(3)),
])

assert degree_pairs == expected_degree_pairs

print("RESULT: PASS — factor pairs recover exactly the three degree pairs")
