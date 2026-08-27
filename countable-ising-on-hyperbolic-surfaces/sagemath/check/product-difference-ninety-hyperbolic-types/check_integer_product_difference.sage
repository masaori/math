degree_pairs = [
    (3, 92), (4, 47), (5, 32), (7, 20), (8, 17), (11, 12),
    (12, 11), (17, 8), (20, 7), (32, 5), (47, 4), (92, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 90

print("PASS: every classified degree pair has integer product difference 90")
