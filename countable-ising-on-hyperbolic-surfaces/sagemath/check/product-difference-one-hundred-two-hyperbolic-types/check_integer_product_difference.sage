degree_pairs = [(3, 104), (4, 53), (5, 36), (8, 19), (19, 8), (36, 5), (53, 4), (104, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 102

print("PASS: every classified degree pair has integer product difference 102")
