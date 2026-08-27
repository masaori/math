factor_pairs = [(1, 100), (2, 50), (4, 25), (5, 20), (10, 10), (20, 5), (25, 4), (50, 2), (100, 1)]
expected_degree_pairs = [(3, 102), (4, 52), (6, 27), (7, 22), (12, 12), (22, 7), (27, 6), (52, 4), (102, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
