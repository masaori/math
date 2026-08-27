factor_pairs = [
    (1, 94), (2, 47), (47, 2), (94, 1),
]
expected_degree_pairs = [
    (3, 96), (4, 49), (49, 4), (96, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
