factor_pairs = [(1, 105), (3, 35), (5, 21), (7, 15), (15, 7), (21, 5), (35, 3), (105, 1)]
expected_degree_pairs = [(3, 107), (5, 37), (7, 23), (9, 17), (17, 9), (23, 7), (37, 5), (107, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
