# SageMath: 十八の正の因子対から次数対を復元する
# 対象ラベル: theorem_product_difference_eighteen_hyperbolic_types

factor_pairs = Set([
    (NN(1), NN(18)),
    (NN(2), NN(9)),
    (NN(3), NN(6)),
    (NN(6), NN(3)),
    (NN(9), NN(2)),
    (NN(18), NN(1)),
])
degree_pairs = Set((a + NN(2), b + NN(2)) for a, b in factor_pairs)
expected_degree_pairs = Set([
    (NN(3), NN(20)),
    (NN(4), NN(11)),
    (NN(5), NN(8)),
    (NN(8), NN(5)),
    (NN(11), NN(4)),
    (NN(20), NN(3)),
])

assert degree_pairs == expected_degree_pairs

print("RESULT: PASS — factor pairs recover exactly the six degree pairs")
