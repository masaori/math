degree_pairs = [(3, 47), (5, 17), (7, 11), (11, 7), (17, 5), (47, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 45

print("PASS: every recovered degree pair has integer product difference 45")
