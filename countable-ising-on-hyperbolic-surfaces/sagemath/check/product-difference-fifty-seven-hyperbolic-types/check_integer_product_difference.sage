degree_pairs = [(3, 59), (5, 21), (21, 5), (59, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 57

print("PASS: every recovered degree pair has integer product difference 57")
