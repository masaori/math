degree_pairs = [
    (ZZ(3), ZZ(134)), (ZZ(4), ZZ(68)), (ZZ(5), ZZ(46)), (ZZ(6), ZZ(35)),
    (ZZ(8), ZZ(24)), (ZZ(13), ZZ(14)), (ZZ(14), ZZ(13)), (ZZ(24), ZZ(8)),
    (ZZ(35), ZZ(6)), (ZZ(46), ZZ(5)), (ZZ(68), ZZ(4)), (ZZ(134), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(132)

print("PASS: every classified degree pair has integer product difference 132")
