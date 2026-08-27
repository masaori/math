degree_pairs = [
    (3, 94), (4, 48), (6, 25), (25, 6), (48, 4), (94, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 92

print("PASS: every classified degree pair has integer product difference 92")
