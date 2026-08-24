expected_pairs = Set([(1, 29), (29, 1)])
actual_pairs = Set([(a, 29 // a) for a in divisors(29)])

assert is_prime(29)
assert actual_pairs == expected_pairs
print("PASS: 29 is prime and its positive factor pairs are exactly", sorted(actual_pairs))
