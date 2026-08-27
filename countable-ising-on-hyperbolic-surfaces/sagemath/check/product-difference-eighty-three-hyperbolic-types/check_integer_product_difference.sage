degree_pairs = [(3, 85), (85, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 83

print("PASS: every classified degree pair has integer product difference 83")
