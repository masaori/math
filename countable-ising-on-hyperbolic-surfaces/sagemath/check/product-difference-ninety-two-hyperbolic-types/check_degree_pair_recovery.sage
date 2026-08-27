factor_pairs = [
    (1, 92), (2, 46), (4, 23), (23, 4), (46, 2), (92, 1),
]
expected_degree_pairs = [
    (3, 94), (4, 48), (6, 25), (25, 6), (48, 4), (94, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
