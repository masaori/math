# SageMath: 標準単射後の整数積差を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_hyperbolic_types

degree_pairs = Set([
    (NN(3), NN(22)),
    (NN(4), NN(12)),
    (NN(6), NN(7)),
    (NN(7), NN(6)),
    (NN(12), NN(4)),
    (NN(22), NN(3)),
])

for p, q in degree_pairs:
    p_integer = ZZ(p)
    q_integer = ZZ(q)
    assert (p_integer - ZZ(2)) * (q_integer - ZZ(2)) == ZZ(20)

print("RESULT: PASS — all six degree pairs have integer product difference twenty")
