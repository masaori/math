degree_pairs = [(3, 78), (4, 40), (6, 21), (21, 6), (40, 4), (78, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 76

print("PASS: every recovered degree pair has integer product difference 76")
