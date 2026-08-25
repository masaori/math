degree_pairs = [(3, 54), (4, 28), (6, 15), (15, 6), (28, 4), (54, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 52

print("PASS: every recovered degree pair has integer product difference 52")
