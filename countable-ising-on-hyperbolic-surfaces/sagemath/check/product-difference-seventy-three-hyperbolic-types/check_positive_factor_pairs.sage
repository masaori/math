target = NN(73)
expected_pairs = Set([(1, 73), (73, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert target.is_prime()
assert actual_pairs == expected_pairs
print("PASS: 73 is prime and has exactly the positive factor pairs", sorted(actual_pairs))
