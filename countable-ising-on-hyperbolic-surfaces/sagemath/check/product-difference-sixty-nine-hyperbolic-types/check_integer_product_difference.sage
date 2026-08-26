degree_pairs = [(3, 71), (5, 25), (25, 5), (71, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 69

print("PASS: every recovered degree pair has integer product difference 69")
