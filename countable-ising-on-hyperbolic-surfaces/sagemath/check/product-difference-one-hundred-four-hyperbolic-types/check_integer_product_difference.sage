degree_pairs = [(3, 106), (4, 54), (6, 28), (10, 15), (15, 10), (28, 6), (54, 4), (106, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 104

print("PASS: every classified degree pair has integer product difference 104")
