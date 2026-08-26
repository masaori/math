degree_pairs = [(3, 68), (4, 35), (5, 24), (8, 13), (13, 8), (24, 5), (35, 4), (68, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 66

print("PASS: every recovered degree pair has integer product difference 66")
