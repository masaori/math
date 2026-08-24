expected_pairs = Set([(1, 31), (31, 1)])
actual_pairs = Set([(a, 31 // a) for a in divisors(31)])

assert is_prime(31)
assert actual_pairs == expected_pairs
print("PASS: 31 is prime and its positive factor pairs are exactly", sorted(actual_pairs))
