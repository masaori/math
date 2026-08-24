factor_pairs = [(1, 28), (2, 14), (4, 7), (7, 4), (14, 2), (28, 1)]
expected_degree_pairs = [(3, 30), (4, 16), (6, 9), (9, 6), (16, 4), (30, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
