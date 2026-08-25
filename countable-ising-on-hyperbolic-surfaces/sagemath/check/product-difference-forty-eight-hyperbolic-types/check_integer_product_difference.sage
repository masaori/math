degree_pairs = [(3, 50), (4, 26), (5, 18), (6, 14), (8, 10), (10, 8), (14, 6), (18, 5), (26, 4), (50, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 48

print("PASS: every recovered degree pair has integer product difference 48")
