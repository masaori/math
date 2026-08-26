degree_pairs = [(3, 60), (4, 31), (31, 4), (60, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 58

print("PASS: every recovered degree pair has integer product difference 58")
