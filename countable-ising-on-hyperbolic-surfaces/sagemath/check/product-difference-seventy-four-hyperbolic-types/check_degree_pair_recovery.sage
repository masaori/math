factor_pairs = [(1, 74), (2, 37), (37, 2), (74, 1)]
expected_degree_pairs = [(3, 76), (4, 39), (39, 4), (76, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
