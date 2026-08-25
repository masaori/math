degree_pairs = [(3, 48), (4, 25), (25, 4), (48, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 46

print("PASS: every recovered degree pair has integer product difference 46")
