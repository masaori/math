target = NN(107)
actual = Set([(a, target // a) for a in divisors(target)])
expected = Set([(1, 107), (107, 1)])

assert actual == expected
print("PASS: the positive factor pairs of 107 are complete")
