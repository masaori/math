degree_pairs = [
    (ZZ(3), ZZ(118)),
    (ZZ(4), ZZ(60)),
    (ZZ(6), ZZ(31)),
    (ZZ(31), ZZ(6)),
    (ZZ(60), ZZ(4)),
    (ZZ(118), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(116)

print("PASS: every classified degree pair has integer product difference 116")
