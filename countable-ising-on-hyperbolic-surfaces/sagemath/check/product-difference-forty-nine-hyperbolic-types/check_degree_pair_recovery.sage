factor_pairs = [(1, 49), (7, 7), (49, 1)]
expected_degree_pairs = [(3, 51), (9, 9), (51, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
