degree_pairs = [
    (ZZ(3), ZZ(119)),
    (ZZ(5), ZZ(41)),
    (ZZ(11), ZZ(15)),
    (ZZ(15), ZZ(11)),
    (ZZ(41), ZZ(5)),
    (ZZ(119), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(117)

print("PASS: every classified degree pair has integer product difference 117")
