degree_pairs = [
    (ZZ(3), ZZ(127)),
    (ZZ(7), ZZ(27)),
    (ZZ(27), ZZ(7)),
    (ZZ(127), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(125)

print("PASS: every classified degree pair has integer product difference 125")
