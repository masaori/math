degree_pairs = [
    (ZZ(3), ZZ(110)), (ZZ(4), ZZ(56)), (ZZ(5), ZZ(38)),
    (ZZ(6), ZZ(29)), (ZZ(8), ZZ(20)), (ZZ(11), ZZ(14)),
    (ZZ(14), ZZ(11)), (ZZ(20), ZZ(8)), (ZZ(29), ZZ(6)),
    (ZZ(38), ZZ(5)), (ZZ(56), ZZ(4)), (ZZ(110), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(108)

print("PASS: every classified degree pair has integer product difference 108")
