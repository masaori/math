degree_pairs = [(3, 107), (5, 37), (7, 23), (9, 17), (17, 9), (23, 7), (37, 5), (107, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 105

print("PASS: every classified degree pair has integer product difference 105")
