degree_pairs = [
    (ZZ(3), ZZ(132)), (ZZ(4), ZZ(67)), (ZZ(7), ZZ(28)), (ZZ(12), ZZ(15)),
    (ZZ(15), ZZ(12)), (ZZ(28), ZZ(7)), (ZZ(67), ZZ(4)), (ZZ(132), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(130)

print("PASS: every classified degree pair has integer product difference 130")
