factor_pairs = [(1, 46), (2, 23), (23, 2), (46, 1)]
expected_degree_pairs = [(3, 48), (4, 25), (25, 4), (48, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
