# 対象ラベル: claim_power_minus_one_gcd_reaches_exponent_gcd
# gcd(m-n,n)=gcd(m,n) を ZZ 上で確認する。

for n in range(1, 65):
    for m in range(n + 1, 97):
        original_gcd = gcd(ZZ(m), ZZ(n))
        reduced_gcd = gcd(ZZ(m) - ZZ(n), ZZ(n))
        assert original_gcd.divides(reduced_gcd)
        assert reduced_gcd.divides(original_gcd)
        assert reduced_gcd == original_gcd

print("RESULT: PASS")
