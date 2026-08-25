# 対象ラベル: claim_numerator_divides_twice_base_minus_one
# gcd(2u,2v)=2gcd(u,v) を本文と同じ相互整除とともに ZZ 上で確認する。

for u in range(0, 257):
    for v in range(0, 257):
        u = ZZ(u)
        v = ZZ(v)
        scaled_gcd = gcd(2 * u, 2 * v)
        twice_gcd = 2 * gcd(u, v)
        assert twice_gcd.divides(scaled_gcd)
        assert scaled_gcd.divides(twice_gcd)
        assert scaled_gcd == twice_gcd

print("RESULT: PASS")
