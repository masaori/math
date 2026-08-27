factor_pairs = [
    (1, 86), (2, 43), (43, 2), (86, 1),
]
expected_degree_pairs = [
    (3, 88), (4, 45), (45, 4), (88, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
