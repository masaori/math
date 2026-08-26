degree_pairs = [(NN(3), NN(68)), (NN(4), NN(35)), (NN(5), NN(24)), (NN(8), NN(13)), (NN(13), NN(8)), (NN(24), NN(5)), (NN(35), NN(4)), (NN(68), NN(3))]

for p, q in degree_pairs:
    assert NN(3) <= p
    assert NN(3) <= q
    assert NN(2) * (p + q) < p * q

print("PASS: every recovered degree pair satisfies the natural-number hyperbolic inequality")
