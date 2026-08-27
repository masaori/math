factor_pairs = [
    (1, 95), (5, 19), (19, 5), (95, 1),
]
expected_degree_pairs = [
    (3, 97), (7, 21), (21, 7), (97, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
