degree_pairs = [
    (3, 38),
    (4, 20),
    (5, 14),
    (6, 11),
    (8, 8),
    (11, 6),
    (14, 5),
    (20, 4),
    (38, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 36

print("PASS: every recovered degree pair has integer product difference 36")
