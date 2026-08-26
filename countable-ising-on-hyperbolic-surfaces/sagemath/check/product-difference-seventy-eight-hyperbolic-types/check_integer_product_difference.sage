degree_pairs = [(3, 80), (4, 41), (5, 28), (8, 15), (15, 8), (28, 5), (41, 4), (80, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 78

print("PASS: every recovered degree pair has integer product difference 78")
