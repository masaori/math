degree_pairs = [(3, 79), (9, 13), (13, 9), (79, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 77

print("PASS: every recovered degree pair has integer product difference 77")
