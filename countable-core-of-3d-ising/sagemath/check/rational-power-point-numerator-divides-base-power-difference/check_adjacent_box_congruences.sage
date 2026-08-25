# 対象ラベル: claim_rational_power_point_numerator_divides_base_power_difference
# c^n と c^m がともに法 a で 2 に合同なら両者の差が法 a で 0 となることを ZZ で確認する。

checked = ZZ(0)
for a in range(1, 65):
    for c in range(1, 65):
        for n in range(1, 17):
            for m in range(n + 1, 18):
                first_power = ZZ(c) ** n
                second_power = ZZ(c) ** m
                if (first_power - 2) % a != 0 or (second_power - 2) % a != 0:
                    continue
                assert (second_power - first_power) % a == 0
                checked += 1

assert checked > 0
print("RESULT: PASS (", checked, " exact cases)")
