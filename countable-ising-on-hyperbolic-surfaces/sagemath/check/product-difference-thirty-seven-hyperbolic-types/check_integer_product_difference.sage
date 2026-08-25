degree_pairs = [(3, 39), (39, 3)]

for p, q in degree_pairs:
    p_bar = ZZ(p)
    q_bar = ZZ(q)
    assert (p_bar - 2) * (q_bar - 2) == 37

print("PASS: every recovered degree pair has integer product difference 37")
