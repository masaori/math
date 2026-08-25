factor_pairs = [(1, 56), (2, 28), (4, 14), (7, 8), (8, 7), (14, 4), (28, 2), (56, 1)]
expected_degree_pairs = [(3, 58), (4, 30), (6, 16), (9, 10), (10, 9), (16, 6), (30, 4), (58, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
