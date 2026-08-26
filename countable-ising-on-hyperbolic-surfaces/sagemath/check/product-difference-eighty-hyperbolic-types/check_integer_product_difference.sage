degree_pairs = [
    (3, 82), (4, 42), (6, 22), (7, 18), (10, 12),
    (12, 10), (18, 7), (22, 6), (42, 4), (82, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 80

print("PASS: every recovered degree pair has integer product difference 80")
