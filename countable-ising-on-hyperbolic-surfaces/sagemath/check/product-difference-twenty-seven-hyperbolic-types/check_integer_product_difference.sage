degree_pairs = [(3, 29), (5, 11), (11, 5), (29, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 27

print("PASS: every recovered degree pair has integer product difference 27")
