degree_pairs = [(3, 67), (7, 15), (15, 7), (67, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 65

print("PASS: every recovered degree pair has integer product difference 65")
