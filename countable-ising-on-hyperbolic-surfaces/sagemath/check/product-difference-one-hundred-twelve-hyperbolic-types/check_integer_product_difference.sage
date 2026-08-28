degree_pairs = [
    (ZZ(3), ZZ(114)),
    (ZZ(4), ZZ(58)),
    (ZZ(6), ZZ(30)),
    (ZZ(9), ZZ(18)),
    (ZZ(10), ZZ(16)),
    (ZZ(16), ZZ(10)),
    (ZZ(18), ZZ(9)),
    (ZZ(30), ZZ(6)),
    (ZZ(58), ZZ(4)),
    (ZZ(114), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(112)

print("PASS: every classified degree pair has integer product difference 112")
