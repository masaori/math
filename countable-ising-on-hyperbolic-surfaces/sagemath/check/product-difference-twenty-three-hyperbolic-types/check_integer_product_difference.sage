# SageMath: 標準単射後の整数積差を厳密検算する
# 対象ラベル: theorem_product_difference_twenty_three_hyperbolic_types

degree_pairs = Set([
    (NN(3), NN(25)),
    (NN(25), NN(3)),
])

for p, q in degree_pairs:
    p_integer = ZZ(p)
    q_integer = ZZ(q)
    assert (p_integer - ZZ(2)) * (q_integer - ZZ(2)) == ZZ(23)

print("RESULT: PASS — both degree pairs have integer product difference twenty-three")
