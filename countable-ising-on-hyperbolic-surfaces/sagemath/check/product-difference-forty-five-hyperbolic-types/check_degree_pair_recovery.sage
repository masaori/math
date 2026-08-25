factor_pairs = [(1, 45), (3, 15), (5, 9), (9, 5), (15, 3), (45, 1)]
expected_degree_pairs = [(3, 47), (5, 17), (7, 11), (11, 7), (17, 5), (47, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
