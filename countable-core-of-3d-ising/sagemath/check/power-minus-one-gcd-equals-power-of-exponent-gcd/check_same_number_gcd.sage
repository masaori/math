# 対象ラベル: claim_power_minus_one_gcd_equals_power_of_exponent_gcd
# gcd(a,a)=a を、本文と同じ相互整除から ZZ 上で確認する。

for a in range(0, 4097):
    value = ZZ(a)
    common_gcd = gcd(value, value)
    assert value.divides(common_gcd)
    assert common_gcd.divides(value)
    assert common_gcd == value

print("RESULT: PASS")
