# 対象ラベル: claim_rational_power_point_numerator_divides_twice_gap_power_minus_one
# 2c^g-2 = 2(c^g-1) と、零合同から得る整除を ZZ で確認する。

checked = ZZ(0)
for a in range(1, 65):
    for c in range(1, 33):
        for gap in range(1, 33):
            difference = 2 * ZZ(c) ** gap - 2
            factored = 2 * (ZZ(c) ** gap - 1)
            assert difference == factored
            if difference % a != 0:
                continue
            assert ZZ(a).divides(factored)
            checked += 1

assert checked > 0
print("RESULT: PASS (", checked, " exact cases)")
