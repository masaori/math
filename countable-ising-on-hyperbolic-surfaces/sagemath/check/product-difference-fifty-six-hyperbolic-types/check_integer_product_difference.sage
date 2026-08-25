degree_pairs = [(3, 58), (4, 30), (6, 16), (9, 10), (10, 9), (16, 6), (30, 4), (58, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 56

print("PASS: every recovered degree pair has integer product difference 56")
