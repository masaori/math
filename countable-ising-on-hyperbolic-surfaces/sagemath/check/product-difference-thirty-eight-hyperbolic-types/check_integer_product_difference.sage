degree_pairs = [(3, 40), (4, 21), (21, 4), (40, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 38

print("PASS: every recovered degree pair has integer product difference 38")
