factor_pairs = [(1, 39), (3, 13), (13, 3), (39, 1)]
expected_degree_pairs = [(3, 41), (5, 15), (15, 5), (41, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
