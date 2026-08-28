degree_pairs = [
    (ZZ(3), ZZ(125)),
    (ZZ(5), ZZ(43)),
    (ZZ(43), ZZ(5)),
    (ZZ(125), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(123)

print("PASS: every classified degree pair has integer product difference 123")
