factor_pairs = [
    (1, 88), (2, 44), (4, 22), (8, 11),
    (11, 8), (22, 4), (44, 2), (88, 1),
]
expected_degree_pairs = [
    (3, 90), (4, 46), (6, 24), (10, 13),
    (13, 10), (24, 6), (46, 4), (90, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
