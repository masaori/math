factor_pairs = [(1, 70), (2, 35), (5, 14), (7, 10),
                (10, 7), (14, 5), (35, 2), (70, 1)]
expected_degree_pairs = [(3, 72), (4, 37), (7, 16), (9, 12),
                         (12, 9), (16, 7), (37, 4), (72, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding 2 recovers exactly", actual_degree_pairs)
