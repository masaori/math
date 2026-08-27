degree_pairs = [
    (3, 98), (4, 50), (5, 34), (6, 26), (8, 18), (10, 14),
    (14, 10), (18, 8), (26, 6), (34, 5), (50, 4), (98, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 96

print("PASS: every classified degree pair has integer product difference 96")
