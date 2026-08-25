# 対象ラベル: claim_power_minus_one_gcd_equals_power_of_exponent_gcd
# 直前の到達形を gcd(a,a)=a で書き換える段を ZZ 上で確認する。

for c in range(1, 17):
    for m in range(1, 33):
        for n in range(1, 33):
            exponent_gcd = gcd(ZZ(m), ZZ(n))
            power_minus_one = ZZ(c) ** exponent_gcd - 1
            terminal_gcd = gcd(power_minus_one, power_minus_one)
            assert terminal_gcd == power_minus_one

print("RESULT: PASS")
