degree_pairs = [
    (3, 90), (4, 46), (6, 24), (10, 13),
    (13, 10), (24, 6), (46, 4), (90, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 88

print("PASS: every classified degree pair has integer product difference 88")
