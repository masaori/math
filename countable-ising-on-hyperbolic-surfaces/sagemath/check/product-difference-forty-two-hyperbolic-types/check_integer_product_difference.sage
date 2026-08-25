degree_pairs = [(3, 44), (4, 23), (5, 16), (8, 9), (9, 8), (16, 5), (23, 4), (44, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 42

print("PASS: every recovered degree pair has integer product difference 42")
