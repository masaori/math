degree_pairs = [(3, 46), (4, 24), (6, 13), (13, 6), (24, 4), (46, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 44

print("PASS: every recovered degree pair has integer product difference 44")
