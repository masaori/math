factor_pairs = [(1, 76), (2, 38), (4, 19), (19, 4), (38, 2), (76, 1)]
expected_degree_pairs = [(3, 78), (4, 40), (6, 21), (21, 6), (40, 4), (78, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
