degree_pairs = [
    (NN(3), NN(83)), (NN(5), NN(29)), (NN(11), NN(11)),
    (NN(29), NN(5)), (NN(83), NN(3)),
]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
