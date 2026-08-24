# 式ペア: 1 + M^3 e_v = 3 M^2 (M-1) e_b なら M^2 | 1 となり、M >= 2 に矛盾する。
# 帰属: ZZ。有限な整除性だけを使う。
for M in [ZZ(2), ZZ(3), ZZ(4), ZZ(5), ZZ(6)]:
    for e_v in [ZZ(1), ZZ(2), ZZ(3), ZZ(4)]:
        for e_b in [ZZ(2), ZZ(3), ZZ(4), ZZ(5)]:
            left_tail = M**3 * e_v
            right = ZZ(3) * M**2 * (M - 1) * e_b
            assert left_tail % M**2 == 0
            assert right % M**2 == 0
            assert (1 + left_tail) != right
            if (1 + left_tail) == right:
                assert ZZ(1) % M**2 == 0
            assert ZZ(1) % M**2 != 0
print("RESULT: PASS")

