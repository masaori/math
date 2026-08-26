factor_pairs = [
    (1, 72), (2, 36), (3, 24), (4, 18), (6, 12), (8, 9),
    (9, 8), (12, 6), (18, 4), (24, 3), (36, 2), (72, 1),
]
expected_degree_pairs = [
    (3, 74), (4, 38), (5, 26), (6, 20), (8, 14), (10, 11),
    (11, 10), (14, 8), (20, 6), (26, 5), (38, 4), (74, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
