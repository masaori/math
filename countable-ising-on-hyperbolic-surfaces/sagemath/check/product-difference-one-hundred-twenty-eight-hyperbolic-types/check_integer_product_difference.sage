degree_pairs = [
    (ZZ(3), ZZ(130)), (ZZ(4), ZZ(66)), (ZZ(6), ZZ(34)), (ZZ(10), ZZ(18)),
    (ZZ(18), ZZ(10)), (ZZ(34), ZZ(6)), (ZZ(66), ZZ(4)), (ZZ(130), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(128)

print("PASS: every classified degree pair has integer product difference 128")
