degree_pairs = [(3, 84), (4, 43), (43, 4), (84, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 82

print("PASS: every classified degree pair has integer product difference 82")
