degree_pairs = [(3, 53), (5, 19), (19, 5), (53, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 51

print("PASS: every recovered degree pair has integer product difference 51")
