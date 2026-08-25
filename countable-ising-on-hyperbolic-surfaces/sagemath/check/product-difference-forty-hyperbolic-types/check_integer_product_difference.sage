degree_pairs = [(3, 42), (4, 22), (6, 12), (7, 10), (10, 7), (12, 6), (22, 4), (42, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 40

print("PASS: every recovered degree pair has integer product difference 40")
