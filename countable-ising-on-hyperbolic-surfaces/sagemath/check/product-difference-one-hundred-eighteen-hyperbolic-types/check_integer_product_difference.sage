degree_pairs = [
    (ZZ(3), ZZ(120)),
    (ZZ(4), ZZ(61)),
    (ZZ(61), ZZ(4)),
    (ZZ(120), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(118)

print("PASS: every classified degree pair has integer product difference 118")
