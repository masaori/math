degree_pairs = [
    (3, 96), (4, 49), (49, 4), (96, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 94

print("PASS: every classified degree pair has integer product difference 94")
