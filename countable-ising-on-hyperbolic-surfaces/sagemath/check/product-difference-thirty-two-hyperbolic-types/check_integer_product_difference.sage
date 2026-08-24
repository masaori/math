degree_pairs = [(3, 34), (4, 18), (6, 10), (10, 6), (18, 4), (34, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 32

print("PASS: every recovered degree pair has integer product difference 32")
