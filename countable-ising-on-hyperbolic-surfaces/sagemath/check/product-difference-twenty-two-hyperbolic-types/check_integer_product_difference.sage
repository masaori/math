# SageMath: 標準単射後の整数積差を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_two_hyperbolic_types

degree_pairs = Set([
    (NN(3), NN(24)),
    (NN(4), NN(13)),
    (NN(13), NN(4)),
    (NN(24), NN(3)),
])

for p, q in degree_pairs:
    p_integer = ZZ(p)
    q_integer = ZZ(q)
    assert (p_integer - ZZ(2)) * (q_integer - ZZ(2)) == ZZ(22)

print("RESULT: PASS — all four degree pairs have integer product difference twenty-two")
