factor_pairs = [(1, 34), (2, 17), (17, 2), (34, 1)]
expected_degree_pairs = [(3, 36), (4, 19), (19, 4), (36, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
