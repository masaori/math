degree_pairs = [(3, 101), (5, 35), (11, 13), (13, 11), (35, 5), (101, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 99

print("PASS: every classified degree pair has integer product difference 99")
