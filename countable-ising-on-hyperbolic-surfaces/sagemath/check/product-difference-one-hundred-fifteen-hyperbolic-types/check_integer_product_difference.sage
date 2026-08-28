degree_pairs = [
    (ZZ(3), ZZ(117)),
    (ZZ(7), ZZ(25)),
    (ZZ(25), ZZ(7)),
    (ZZ(117), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(115)

print("PASS: every classified degree pair has integer product difference 115")
