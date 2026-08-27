degree_pairs = [
    (3, 93), (9, 15), (15, 9), (93, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 91

print("PASS: every classified degree pair has integer product difference 91")
