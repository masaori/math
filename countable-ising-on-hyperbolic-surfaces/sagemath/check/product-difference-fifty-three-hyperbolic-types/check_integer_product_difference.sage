degree_pairs = [(3, 55), (55, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 53

print("PASS: every recovered degree pair has integer product difference 53")
