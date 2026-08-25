# 対象ラベル: claim_power_minus_one_gcd_exponent_difference_step
# 二つの最大公約数が互いに割り合うことを ZZ で確認する。

for c in range(1, 33):
    for n in range(1, 17):
        for m in range(n + 1, 33):
            first_gcd = gcd(ZZ(c) ** ZZ(m) - 1, ZZ(c) ** ZZ(n) - 1)
            reduced_gcd = gcd(ZZ(c) ** (ZZ(m) - ZZ(n)) - 1, ZZ(c) ** ZZ(n) - 1)
            assert first_gcd.divides(reduced_gcd)
            assert reduced_gcd.divides(first_gcd)

print("RESULT: PASS")
