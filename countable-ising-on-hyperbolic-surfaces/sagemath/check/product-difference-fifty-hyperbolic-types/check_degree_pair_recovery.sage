factor_pairs = [(1, 50), (2, 25), (5, 10), (10, 5), (25, 2), (50, 1)]
expected_degree_pairs = [(3, 52), (4, 27), (7, 12), (12, 7), (27, 4), (52, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
