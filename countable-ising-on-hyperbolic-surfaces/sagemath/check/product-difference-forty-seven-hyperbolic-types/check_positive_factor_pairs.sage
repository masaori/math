target = NN(47)
expected_pairs = Set([(1, 47), (47, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert target.is_prime()
assert actual_pairs == expected_pairs
print("PASS: 47 is prime and has exactly the positive factor pairs", sorted(actual_pairs))
