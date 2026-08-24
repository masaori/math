# 式ペア: 1 + #V_M e_v = #E_M e_b を箱の点数・辺数へ代入する。
# 帰属: ZZ。有限な整数等式だけを使う。
for M in [ZZ(2), ZZ(3), ZZ(4), ZZ(5)]:
    point_count = M**3
    edge_count = ZZ(3) * M**2 * (M - 1)
    for e_v in [ZZ(1), ZZ(2), ZZ(3)]:
        for e_b in [ZZ(2), ZZ(3), ZZ(4)]:
            assert 1 + point_count * e_v == 1 + M**3 * e_v
            assert edge_count * e_b == 3 * M**2 * (M - 1) * e_b
print("RESULT: PASS")

