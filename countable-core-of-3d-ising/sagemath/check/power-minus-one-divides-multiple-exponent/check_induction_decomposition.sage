# 対象ラベル: claim_power_minus_one_divides_multiple_exponent
# 帰納段で用いる分解を ZZ で確認する。

for c in range(1, 33):
    for n in range(1, 17):
        for k in range(0, 17):
            left = ZZ(c) ** (ZZ(n) * (ZZ(k) + 1)) - 1
            right = ZZ(c) ** (ZZ(n) * ZZ(k)) * (ZZ(c) ** ZZ(n) - 1) + (ZZ(c) ** (ZZ(n) * ZZ(k)) - 1)
            assert left == right

print("RESULT: PASS")
