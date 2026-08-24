# SageMath: 二十四の正の因子対から次数対を復元する
# 対象ラベル: theorem_product_difference_twenty_four_hyperbolic_types

factor_pairs = Set([
    (NN(1), NN(24)),
    (NN(2), NN(12)),
    (NN(3), NN(8)),
    (NN(4), NN(6)),
    (NN(6), NN(4)),
    (NN(8), NN(3)),
    (NN(12), NN(2)),
    (NN(24), NN(1)),
])
degree_pairs = Set((a + NN(2), b + NN(2)) for a, b in factor_pairs)
expected_degree_pairs = Set([
    (NN(3), NN(26)),
    (NN(4), NN(14)),
    (NN(5), NN(10)),
    (NN(6), NN(8)),
    (NN(8), NN(6)),
    (NN(10), NN(5)),
    (NN(14), NN(4)),
    (NN(26), NN(3)),
])

assert degree_pairs == expected_degree_pairs

print("RESULT: PASS — factor pairs recover exactly the eight degree pairs")
