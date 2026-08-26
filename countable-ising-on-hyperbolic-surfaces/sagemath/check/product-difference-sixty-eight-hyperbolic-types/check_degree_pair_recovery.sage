factor_pairs = [(1, 68), (2, 34), (4, 17), (17, 4), (34, 2), (68, 1)]
expected_degree_pairs = [(3, 70), (4, 36), (6, 19), (19, 6), (36, 4), (70, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
