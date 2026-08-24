# SageMath: 標準単射後の整数積差を厳密検算する
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
    p_integer = ZZ(p)
    q_integer = ZZ(q)
    assert (p_integer - ZZ(2)) * (q_integer - ZZ(2)) == ZZ(24)

print("RESULT: PASS — all eight degree pairs have integer product difference twenty-four")
