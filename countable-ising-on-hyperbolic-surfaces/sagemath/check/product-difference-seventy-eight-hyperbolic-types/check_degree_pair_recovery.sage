factor_pairs = [(1, 78), (2, 39), (3, 26), (6, 13), (13, 6), (26, 3), (39, 2), (78, 1)]
expected_degree_pairs = [(3, 80), (4, 41), (5, 28), (8, 15), (15, 8), (28, 5), (41, 4), (80, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
