degree_pairs = [
    (3, 62), (4, 32), (5, 22), (6, 17), (7, 14), (8, 12),
    (12, 8), (14, 7), (17, 6), (22, 5), (32, 4), (62, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 60

print("PASS: every recovered degree pair has integer product difference 60")
