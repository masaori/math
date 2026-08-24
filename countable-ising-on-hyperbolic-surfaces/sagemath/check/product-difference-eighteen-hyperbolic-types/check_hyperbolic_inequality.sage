# SageMath: 復元した次数対の双曲不等式を厳密検算する
# 対象ラベル: theorem_product_difference_eighteen_hyperbolic_types

degree_pairs = Set([
    (NN(3), NN(20)),
    (NN(4), NN(11)),
    (NN(5), NN(8)),
    (NN(8), NN(5)),
    (NN(11), NN(4)),
    (NN(20), NN(3)),
])

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("RESULT: PASS — all six degree pairs satisfy the hyperbolic inequality")
