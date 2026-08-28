degree_pairs = [
    (ZZ(3), ZZ(121)),
    (ZZ(9), ZZ(19)),
    (ZZ(19), ZZ(9)),
    (ZZ(121), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(119)

print("PASS: every classified degree pair has integer product difference 119")
