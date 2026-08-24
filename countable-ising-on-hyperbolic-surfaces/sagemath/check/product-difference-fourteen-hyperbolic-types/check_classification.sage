# SageMath: 積差十四をもつ双曲正則型を厳密検算する
# 対象ラベル: theorem_product_difference_fourteen_hyperbolic_types

product_difference = NN(14)
positive_divisors = tuple(NN(a) for a in divisors(product_difference))
positive_factor_pairs = Set(
    (a, b)
    for a in positive_divisors
    for b in positive_divisors
    if a * b == product_difference
)
expected_factor_pairs = Set([
    (NN(1), NN(14)),
    (NN(2), NN(7)),
    (NN(7), NN(2)),
    (NN(14), NN(1)),
])

assert positive_divisors == (NN(1), NN(2), NN(7), NN(14))
assert positive_factor_pairs == expected_factor_pairs

degree_pairs = Set((a + 2, b + 2) for a, b in positive_factor_pairs)
expected_degree_pairs = Set([
    (NN(3), NN(16)),
    (NN(4), NN(9)),
    (NN(9), NN(4)),
    (NN(16), NN(3)),
])

assert degree_pairs == expected_degree_pairs

for p, q in degree_pairs:
    p_integer = ZZ(p)
    q_integer = ZZ(q)
    assert 2 * (p + q) < p * q
    assert (p_integer - 2) * (q_integer - 2) == ZZ(14)

print("RESULT: PASS — product difference fourteen gives exactly (3,16), (4,9), (9,4), and (16,3)")
