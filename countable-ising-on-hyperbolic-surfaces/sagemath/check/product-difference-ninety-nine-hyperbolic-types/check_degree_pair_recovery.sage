factor_pairs = [(1, 99), (3, 33), (9, 11), (11, 9), (33, 3), (99, 1)]
expected_degree_pairs = [(3, 101), (5, 35), (11, 13), (13, 11), (35, 5), (101, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
