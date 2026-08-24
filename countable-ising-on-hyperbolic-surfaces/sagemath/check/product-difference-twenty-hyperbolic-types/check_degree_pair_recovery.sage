# SageMath: 二十の正の因子対から次数対を復元する
# 対象ラベル: theorem_product_difference_twenty_hyperbolic_types

factor_pairs = Set([
    (NN(1), NN(20)),
    (NN(2), NN(10)),
    (NN(4), NN(5)),
    (NN(5), NN(4)),
    (NN(10), NN(2)),
    (NN(20), NN(1)),
])
degree_pairs = Set((a + NN(2), b + NN(2)) for a, b in factor_pairs)
expected_degree_pairs = Set([
    (NN(3), NN(22)),
    (NN(4), NN(12)),
    (NN(6), NN(7)),
    (NN(7), NN(6)),
    (NN(12), NN(4)),
    (NN(22), NN(3)),
])

assert degree_pairs == expected_degree_pairs

print("RESULT: PASS — factor pairs recover exactly the six degree pairs")
