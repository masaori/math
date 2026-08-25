factor_pairs = [(1, 35), (5, 7), (7, 5), (35, 1)]
expected_degree_pairs = [(3, 37), (7, 9), (9, 7), (37, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
