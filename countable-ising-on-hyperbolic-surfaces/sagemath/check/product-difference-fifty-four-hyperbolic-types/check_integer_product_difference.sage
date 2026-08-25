degree_pairs = [(3, 56), (4, 29), (5, 20), (8, 11), (11, 8), (20, 5), (29, 4), (56, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 54

print("PASS: every recovered degree pair has integer product difference 54")
