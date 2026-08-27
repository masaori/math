factor_pairs = [
    (1, 90), (2, 45), (3, 30), (5, 18), (6, 15), (9, 10),
    (10, 9), (15, 6), (18, 5), (30, 3), (45, 2), (90, 1),
]
expected_degree_pairs = [
    (3, 92), (4, 47), (5, 32), (7, 20), (8, 17), (11, 12),
    (12, 11), (17, 8), (20, 7), (32, 5), (47, 4), (92, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
