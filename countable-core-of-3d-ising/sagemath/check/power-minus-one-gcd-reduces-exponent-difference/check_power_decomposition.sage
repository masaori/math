# 対象ラベル: claim_power_minus_one_gcd_exponent_difference_step
# c^m-1=c^(m-n)(c^n-1)+(c^(m-n)-1) を ZZ で確認する。

for c in range(1, 33):
    for n in range(1, 17):
        for m in range(n + 1, 33):
            left = ZZ(c) ** ZZ(m) - 1
            right = ZZ(c) ** (ZZ(m) - ZZ(n)) * (ZZ(c) ** ZZ(n) - 1) + (ZZ(c) ** (ZZ(m) - ZZ(n)) - 1)
            assert left == right

print("RESULT: PASS")
