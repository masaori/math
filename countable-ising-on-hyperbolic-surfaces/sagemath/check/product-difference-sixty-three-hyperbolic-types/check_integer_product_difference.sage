degree_pairs = [(3, 65), (5, 23), (9, 11), (11, 9), (23, 5), (65, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 63

print("PASS: every recovered degree pair has integer product difference 63")
