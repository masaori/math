degree_pairs = [
    (ZZ(3), ZZ(128)), (ZZ(4), ZZ(65)), (ZZ(5), ZZ(44)),
    (ZZ(8), ZZ(23)), (ZZ(9), ZZ(20)), (ZZ(11), ZZ(16)),
    (ZZ(16), ZZ(11)), (ZZ(20), ZZ(9)), (ZZ(23), ZZ(8)),
    (ZZ(44), ZZ(5)), (ZZ(65), ZZ(4)), (ZZ(128), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(126)

print("PASS: every classified degree pair has integer product difference 126")
