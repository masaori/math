degree_pairs = [
    (ZZ(3), ZZ(112)),
    (ZZ(4), ZZ(57)),
    (ZZ(7), ZZ(24)),
    (ZZ(12), ZZ(13)),
    (ZZ(13), ZZ(12)),
    (ZZ(24), ZZ(7)),
    (ZZ(57), ZZ(4)),
    (ZZ(112), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(110)

print("PASS: every classified degree pair has integer product difference 110")
