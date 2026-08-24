# SageMath: 標準単射後の整数積差を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_one_hyperbolic_types

degree_pairs = Set([
    (NN(3), NN(23)),
    (NN(5), NN(9)),
    (NN(9), NN(5)),
    (NN(23), NN(3)),
])

for p, q in degree_pairs:
    p_integer = ZZ(p)
    q_integer = ZZ(q)
    assert (p_integer - ZZ(2)) * (q_integer - ZZ(2)) == ZZ(21)

print("RESULT: PASS — all four degree pairs have integer product difference twenty-one")
