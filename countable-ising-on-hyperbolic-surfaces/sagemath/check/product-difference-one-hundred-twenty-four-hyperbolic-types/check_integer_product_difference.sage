degree_pairs = [
    (ZZ(3), ZZ(126)),
    (ZZ(4), ZZ(64)),
    (ZZ(6), ZZ(33)),
    (ZZ(33), ZZ(6)),
    (ZZ(64), ZZ(4)),
    (ZZ(126), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(124)

print("PASS: every classified degree pair has integer product difference 124")
