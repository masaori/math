# 対象ラベル: claim_power_minus_one_gcd_exponent_difference_step
# 指数の差への一段の還元を ZZ で確認する。

for c in range(1, 65):
    for n in range(1, 25):
        for m in range(n + 1, 49):
            first_gcd = gcd(ZZ(c) ** ZZ(m) - 1, ZZ(c) ** ZZ(n) - 1)
            reduced_gcd = gcd(ZZ(c) ** (ZZ(m) - ZZ(n)) - 1, ZZ(c) ** ZZ(n) - 1)
            assert first_gcd == reduced_gcd

print("RESULT: PASS")
