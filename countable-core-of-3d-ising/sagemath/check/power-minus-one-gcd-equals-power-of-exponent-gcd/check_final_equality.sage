# 対象ラベル: claim_power_minus_one_gcd_equals_power_of_exponent_gcd
# 到達形と最終等式を本文の順に ZZ 上で確認する。

for c in range(1, 17):
    for m in range(1, 33):
        for n in range(1, 33):
            exponent_gcd = gcd(ZZ(m), ZZ(n))
            original_gcd = gcd(ZZ(c) ** ZZ(m) - 1, ZZ(c) ** ZZ(n) - 1)
            terminal_gcd = gcd(
                ZZ(c) ** exponent_gcd - 1,
                ZZ(c) ** exponent_gcd - 1,
            )
            final_value = ZZ(c) ** gcd(ZZ(m), ZZ(n)) - 1
            assert original_gcd == terminal_gcd
            assert terminal_gcd == final_value
            assert original_gcd == final_value

print("RESULT: PASS")
