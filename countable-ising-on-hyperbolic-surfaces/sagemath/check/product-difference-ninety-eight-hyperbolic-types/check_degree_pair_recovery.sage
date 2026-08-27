factor_pairs = [(1, 98), (2, 49), (7, 14), (14, 7), (49, 2), (98, 1)]
expected_degree_pairs = [(3, 100), (4, 51), (9, 16), (16, 9), (51, 4), (100, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
