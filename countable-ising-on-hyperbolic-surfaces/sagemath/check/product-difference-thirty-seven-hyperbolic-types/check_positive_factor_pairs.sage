target = NN(37)
expected_pairs = Set([
    (1, 37),
    (37, 1),
])
actual_pairs = Set([(a, target // a) for a in divisors(target)])

assert target.is_prime()
assert actual_pairs == expected_pairs
print("PASS: 37 is prime and has exactly the positive factor pairs", sorted(actual_pairs))
