target = NN(71)
expected_pairs = Set([(1, 71), (71, 1)])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert target.is_prime()
assert actual_pairs == expected_pairs
print("PASS: 71 is prime and has exactly the positive factor pairs", sorted(actual_pairs))
