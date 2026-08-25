target = NN(41)
expected_pairs = Set([(1, 41), (41, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert target.is_prime()
assert actual_pairs == expected_pairs
print("PASS: 41 is prime and has exactly the positive factor pairs", sorted(actual_pairs))
