# 対象ラベル: claim_rational_power_point_numerator_divides_twice_gap_power_minus_one
# c^(L^3) と c^((L+1)^3) がともに法 a で 2 に合同なら、
# 2c^g（g=(L+1)^3-L^3）が法 a で 2 に合同であることを ZZ で確認する。

checked = ZZ(0)
for a in range(1, 65):
    for c in range(1, 33):
        for L in range(1, 9):
            lower_count = ZZ(L) ** 3
            upper_count = ZZ(L + 1) ** 3
            gap = upper_count - lower_count
            lower_power = ZZ(c) ** lower_count
            upper_power = ZZ(c) ** upper_count
            if (lower_power - 2) % a != 0 or (upper_power - 2) % a != 0:
                continue
            assert lower_power * ZZ(c) ** gap == upper_power
            assert (2 * ZZ(c) ** gap - 2) % a == 0
            checked += 1

assert checked > 0
print("RESULT: PASS (", checked, " exact cases)")
