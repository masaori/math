degree_pairs = [(3, 72), (4, 37), (7, 16), (9, 12),
                (12, 9), (16, 7), (37, 4), (72, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 70

print("PASS: every recovered degree pair has integer product difference 70")
