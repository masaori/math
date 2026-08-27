degree_pairs = [
    (3, 95), (5, 33), (33, 5), (95, 3),
]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 93

print("PASS: every classified degree pair has integer product difference 93")
