degree_pairs = [
    (3, 88), (4, 45), (45, 4), (88, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 86

print("PASS: every classified degree pair has integer product difference 86")
