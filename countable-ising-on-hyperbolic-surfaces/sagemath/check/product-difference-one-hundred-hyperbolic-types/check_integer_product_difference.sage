degree_pairs = [(3, 102), (4, 52), (6, 27), (7, 22), (12, 12), (22, 7), (27, 6), (52, 4), (102, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 100

print("PASS: every classified degree pair has integer product difference 100")
