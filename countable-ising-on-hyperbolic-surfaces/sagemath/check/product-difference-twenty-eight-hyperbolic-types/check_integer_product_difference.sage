degree_pairs = [(3, 30), (4, 16), (6, 9), (9, 6), (16, 4), (30, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 28

print("PASS: every recovered degree pair has integer product difference 28")
