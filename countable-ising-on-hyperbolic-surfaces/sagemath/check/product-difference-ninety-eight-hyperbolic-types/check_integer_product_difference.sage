degree_pairs = [(3, 100), (4, 51), (9, 16), (16, 9), (51, 4), (100, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 98

print("PASS: every classified degree pair has integer product difference 98")
