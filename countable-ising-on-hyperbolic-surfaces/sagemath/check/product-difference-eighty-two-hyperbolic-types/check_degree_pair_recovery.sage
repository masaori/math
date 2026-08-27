factor_pairs = [(1, 82), (2, 41), (41, 2), (82, 1)]
expected_degree_pairs = [(3, 84), (4, 43), (43, 4), (84, 3)]
actual_degree_pairs = [(a + 2, b + 2) for a, b in factor_pairs]

assert actual_degree_pairs == expected_degree_pairs
print("PASS: adding two recovers exactly the classified degree pairs")
