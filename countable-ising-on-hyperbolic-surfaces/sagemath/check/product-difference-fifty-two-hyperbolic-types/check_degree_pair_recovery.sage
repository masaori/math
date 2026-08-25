factor_pairs = [(1, 52), (2, 26), (4, 13), (13, 4), (26, 2), (52, 1)]
expected_degree_pairs = [(3, 54), (4, 28), (6, 15), (15, 6), (28, 4), (54, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
