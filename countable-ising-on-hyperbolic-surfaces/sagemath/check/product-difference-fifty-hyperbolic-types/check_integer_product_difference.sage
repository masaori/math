degree_pairs = [(3, 52), (4, 27), (7, 12), (12, 7), (27, 4), (52, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 50

print("PASS: every recovered degree pair has integer product difference 50")
