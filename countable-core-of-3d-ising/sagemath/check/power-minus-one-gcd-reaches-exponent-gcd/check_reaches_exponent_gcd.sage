# 対象ラベル: claim_power_minus_one_gcd_reaches_exponent_gcd
# 還元の到達点 gcd(c^m-1,c^n-1)=gcd(c^g-1,c^g-1) を ZZ 上で確認する。

for c in range(1, 33):
    for m in range(1, 33):
        for n in range(1, 33):
            exponent_gcd = gcd(ZZ(m), ZZ(n))
            original_gcd = gcd(ZZ(c) ** ZZ(m) - 1, ZZ(c) ** ZZ(n) - 1)
            terminal_gcd = gcd(
                ZZ(c) ** exponent_gcd - 1,
                ZZ(c) ** exponent_gcd - 1,
            )
            assert original_gcd == terminal_gcd

print("RESULT: PASS")
