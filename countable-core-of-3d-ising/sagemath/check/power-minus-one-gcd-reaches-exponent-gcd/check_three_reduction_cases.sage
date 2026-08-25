# 対象ラベル: claim_power_minus_one_gcd_reaches_exponent_gcd
# 強い帰納法の三場合で、冪差の最大公約数が一段小さい指数対へ移ることを ZZ 上で確認する。

for c in range(1, 25):
    for m in range(1, 25):
        for n in range(1, 25):
            original_gcd = gcd(ZZ(c) ** ZZ(m) - 1, ZZ(c) ** ZZ(n) - 1)
            if m == n:
                reduced_gcd = gcd(ZZ(c) ** ZZ(m) - 1, ZZ(c) ** ZZ(m) - 1)
            elif m > n:
                assert (m - n) + n < m + n
                reduced_gcd = gcd(ZZ(c) ** (ZZ(m) - ZZ(n)) - 1, ZZ(c) ** ZZ(n) - 1)
            else:
                assert (n - m) + m < m + n
                reduced_gcd = gcd(ZZ(c) ** (ZZ(n) - ZZ(m)) - 1, ZZ(c) ** ZZ(m) - 1)
            assert original_gcd == reduced_gcd

print("RESULT: PASS")
