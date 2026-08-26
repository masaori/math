factor_pairs = [
    (1, 81), (3, 27), (9, 9), (27, 3), (81, 1),
]
expected_degree_pairs = [
    (3, 83), (5, 29), (11, 11), (29, 5), (83, 3),
]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
