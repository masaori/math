# SageMath: 積差八をもつ双曲正則型を厳密検算する
# 対象ラベル: theorem_product_difference_eight_hyperbolic_types

product_difference = NN(8)
positive_divisors = tuple(NN(a) for a in divisors(product_difference))
positive_factor_pairs = Set(
    (a, b)
    for a in positive_divisors
    for b in positive_divisors
    if a * b == product_difference
)
expected_factor_pairs = Set([
    (NN(1), NN(8)),
    (NN(2), NN(4)),
    (NN(4), NN(2)),
    (NN(8), NN(1)),
])

assert positive_divisors == (NN(1), NN(2), NN(4), NN(8))
assert positive_factor_pairs == expected_factor_pairs

degree_pairs = Set((a + 2, b + 2) for a, b in positive_factor_pairs)
expected_degree_pairs = Set([
    (NN(3), NN(10)),
    (NN(4), NN(6)),
    (NN(6), NN(4)),
    (NN(10), NN(3)),
])

assert degree_pairs == expected_degree_pairs

for p, q in degree_pairs:
    p_integer = ZZ(p)
    q_integer = ZZ(q)
    assert 2 * (p + q) < p * q
    assert (p_integer - 2) * (q_integer - 2) == ZZ(8)

print("RESULT: PASS — product difference eight gives exactly (3,10), (4,6), (6,4), and (10,3)")
