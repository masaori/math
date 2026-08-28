degree_pairs = [(ZZ(3), ZZ(108)), (ZZ(4), ZZ(55)), (ZZ(55), ZZ(4)), (ZZ(108), ZZ(3))]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(106)

print("PASS: every classified degree pair has integer product difference 106")
