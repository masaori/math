# SageMath: 二十六の正の因子対から次数対を復元する
# 対象ラベル: theorem_product_difference_twenty_six_hyperbolic_types

factor_pairs = Set([
    (NN(1), NN(26)),
    (NN(2), NN(13)),
    (NN(13), NN(2)),
    (NN(26), NN(1)),
])
degree_pairs = Set((a + NN(2), b + NN(2)) for a, b in factor_pairs)
expected_degree_pairs = Set([
    (NN(3), NN(28)),
    (NN(4), NN(15)),
    (NN(15), NN(4)),
    (NN(28), NN(3)),
])

assert degree_pairs == expected_degree_pairs

print("RESULT: PASS — factor pairs recover exactly the four degree pairs")
