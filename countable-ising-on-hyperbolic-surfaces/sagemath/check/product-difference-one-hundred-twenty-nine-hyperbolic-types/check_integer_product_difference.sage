degree_pairs = [
    (ZZ(3), ZZ(131)), (ZZ(5), ZZ(45)), (ZZ(45), ZZ(5)), (ZZ(131), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(129)

print("PASS: every classified degree pair has integer product difference 129")
