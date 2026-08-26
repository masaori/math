degree_pairs = [(3, 66), (4, 34), (6, 18), (10, 10), (18, 6), (34, 4), (66, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 64

print("PASS: every recovered degree pair has integer product difference 64")
