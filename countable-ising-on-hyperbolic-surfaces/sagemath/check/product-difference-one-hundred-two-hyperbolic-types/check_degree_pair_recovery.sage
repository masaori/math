factor_pairs = [(1, 102), (2, 51), (3, 34), (6, 17), (17, 6), (34, 3), (51, 2), (102, 1)]
expected_degree_pairs = [(3, 104), (4, 53), (5, 36), (8, 19), (19, 8), (36, 5), (53, 4), (104, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
