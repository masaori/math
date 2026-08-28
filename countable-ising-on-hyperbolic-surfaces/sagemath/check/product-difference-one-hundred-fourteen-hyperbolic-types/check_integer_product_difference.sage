degree_pairs = [
    (ZZ(3), ZZ(116)),
    (ZZ(4), ZZ(59)),
    (ZZ(5), ZZ(40)),
    (ZZ(8), ZZ(21)),
    (ZZ(21), ZZ(8)),
    (ZZ(40), ZZ(5)),
    (ZZ(59), ZZ(4)),
    (ZZ(116), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(114)

print("PASS: every classified degree pair has integer product difference 114")
