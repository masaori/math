factor_pairs = [(1, 104), (2, 52), (4, 26), (8, 13), (13, 8), (26, 4), (52, 2), (104, 1)]
expected_degree_pairs = [(3, 106), (4, 54), (6, 28), (10, 15), (15, 10), (28, 6), (54, 4), (106, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
