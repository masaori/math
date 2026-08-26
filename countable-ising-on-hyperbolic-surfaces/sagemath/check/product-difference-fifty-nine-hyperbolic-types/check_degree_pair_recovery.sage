factor_pairs = [(1, 59), (59, 1)]
expected_degree_pairs = [(3, 61), (61, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
