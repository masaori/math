degree_pairs = [
    (ZZ(3), ZZ(124)),
    (ZZ(4), ZZ(63)),
    (ZZ(63), ZZ(4)),
    (ZZ(124), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(122)

print("PASS: every classified degree pair has integer product difference 122")
