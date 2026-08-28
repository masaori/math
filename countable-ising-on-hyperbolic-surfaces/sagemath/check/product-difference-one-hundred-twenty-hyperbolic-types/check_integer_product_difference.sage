degree_pairs = [
    (ZZ(3), ZZ(122)), (ZZ(4), ZZ(62)), (ZZ(5), ZZ(42)), (ZZ(6), ZZ(32)),
    (ZZ(7), ZZ(26)), (ZZ(8), ZZ(22)), (ZZ(10), ZZ(17)), (ZZ(12), ZZ(14)),
    (ZZ(14), ZZ(12)), (ZZ(17), ZZ(10)), (ZZ(22), ZZ(8)), (ZZ(26), ZZ(7)),
    (ZZ(32), ZZ(6)), (ZZ(42), ZZ(5)), (ZZ(62), ZZ(4)), (ZZ(122), ZZ(3)),
]

for p, q in degree_pairs:
    assert (p - ZZ(2)) * (q - ZZ(2)) == ZZ(120)

print("PASS: every classified degree pair has integer product difference 120")
