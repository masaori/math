degree_pairs = [(ZZ(3), ZZ(115)), (ZZ(115), ZZ(3))]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(113)

print("PASS: every classified degree pair has integer product difference 113")
