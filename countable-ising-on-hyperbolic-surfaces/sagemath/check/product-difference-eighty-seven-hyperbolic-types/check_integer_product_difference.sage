degree_pairs = [
    (3, 89), (5, 31), (31, 5), (89, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 87

print("PASS: every classified degree pair has integer product difference 87")
