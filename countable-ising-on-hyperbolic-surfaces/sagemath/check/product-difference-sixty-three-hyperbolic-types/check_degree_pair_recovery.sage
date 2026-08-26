factor_pairs = [(1, 63), (3, 21), (7, 9), (9, 7), (21, 3), (63, 1)]
expected_degree_pairs = [(3, 65), (5, 23), (9, 11), (11, 9), (23, 5), (65, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
