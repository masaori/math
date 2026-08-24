degree_pairs = [
    (3, 32),
    (4, 17),
    (5, 12),
    (7, 8),
    (8, 7),
    (12, 5),
    (17, 4),
    (32, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 30

print("PASS: every recovered degree pair has integer product difference 30")
