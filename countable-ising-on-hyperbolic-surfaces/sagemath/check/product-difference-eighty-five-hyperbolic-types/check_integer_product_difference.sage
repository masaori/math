degree_pairs = [
    (3, 87), (7, 19), (19, 7), (87, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 85

print("PASS: every classified degree pair has integer product difference 85")
