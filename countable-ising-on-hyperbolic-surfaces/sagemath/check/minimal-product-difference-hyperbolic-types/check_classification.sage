# SageMath: 最小積差をもつ双曲正則型を厳密検算する
# 対象ラベル: theorem_minimal_product_difference_hyperbolic_types

prime_value = NN(5)
positive_divisors = tuple(NN(a) for a in divisors(prime_value))
positive_factor_pairs = Set(
    (a, b)
    for a in positive_divisors
    for b in positive_divisors
    if a * b == prime_value
)
expected_factor_pairs = Set([(NN(1), NN(5)), (NN(5), NN(1))])

assert prime_value.is_prime()
assert positive_divisors == (NN(1), NN(5))
assert positive_factor_pairs == expected_factor_pairs

degree_pairs = Set((a + 2, b + 2) for a, b in positive_factor_pairs)
expected_degree_pairs = Set([(NN(3), NN(7)), (NN(7), NN(3))])

assert degree_pairs == expected_degree_pairs

for p, q in degree_pairs:
    p_integer = ZZ(p)
    q_integer = ZZ(q)
    assert 2 * (p + q) < p * q
    assert (p_integer - 2) * (q_integer - 2) == ZZ(5)

print("RESULT: PASS — the minimal product difference five gives exactly (3,7) and (7,3)")
