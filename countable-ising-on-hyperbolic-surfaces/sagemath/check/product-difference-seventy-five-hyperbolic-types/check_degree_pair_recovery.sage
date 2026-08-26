factor_pairs = [(1, 75), (3, 25), (5, 15), (15, 5), (25, 3), (75, 1)]
expected_degree_pairs = [(3, 77), (5, 27), (7, 17), (17, 7), (27, 5), (77, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
