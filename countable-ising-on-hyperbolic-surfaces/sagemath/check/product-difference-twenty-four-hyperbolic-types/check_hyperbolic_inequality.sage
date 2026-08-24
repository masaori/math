# SageMath: 復元した次数対の双曲不等式を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_four_hyperbolic_types

degree_pairs = Set([
    (NN(3), NN(26)),
    (NN(4), NN(14)),
    (NN(5), NN(10)),
    (NN(6), NN(8)),
    (NN(8), NN(6)),
    (NN(10), NN(5)),
    (NN(14), NN(4)),
    (NN(26), NN(3)),
])

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("RESULT: PASS — all eight degree pairs satisfy the hyperbolic inequality")
