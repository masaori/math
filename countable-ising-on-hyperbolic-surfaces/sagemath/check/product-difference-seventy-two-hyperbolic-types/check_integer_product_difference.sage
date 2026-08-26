degree_pairs = [
    (3, 74), (4, 38), (5, 26), (6, 20), (8, 14), (10, 11),
    (11, 10), (14, 8), (20, 6), (26, 5), (38, 4), (74, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 72

print("PASS: every recovered degree pair has integer product difference 72")
