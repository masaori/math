# SageMath: 復元した次数対の双曲不等式を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_six_hyperbolic_types

degree_pairs = Set([
    (NN(3), NN(28)),
    (NN(4), NN(15)),
    (NN(15), NN(4)),
    (NN(28), NN(3)),
])

for p, q in degree_pairs:
    assert NN(2) * (p + q) < p * q

print("RESULT: PASS — all four degree pairs satisfy the hyperbolic inequality")
