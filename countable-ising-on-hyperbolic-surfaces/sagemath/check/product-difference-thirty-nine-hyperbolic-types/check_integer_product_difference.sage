degree_pairs = [(3, 41), (5, 15), (15, 5), (41, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 39

print("PASS: every recovered degree pair has integer product difference 39")
