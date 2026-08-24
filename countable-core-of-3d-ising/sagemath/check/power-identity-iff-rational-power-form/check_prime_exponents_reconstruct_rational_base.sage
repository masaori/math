# 対象ラベル: claim_power_identity_iff_rational_power_form
# 有限個の非零素指数から正の有理数 c を復元し、各値が c の点数乗になることを検証する。
# 帰属: QQ と ZZ の厳密計算。浮動小数点、無限積、級数、極限は使わない。

def prime_exponent(value, prime):
    return ZZ(value.numerator().valuation(prime) - value.denominator().valuation(prime))

common_base = QQ(18) / QQ(35)
support = [ZZ(2), ZZ(3), ZZ(5), ZZ(7)]
base_exponents = {prime: prime_exponent(common_base, prime) for prime in support}

reconstructed_base = prod(QQ(prime) ** base_exponents[prime] for prime in support)
assert reconstructed_base == common_base

for box_size in range(1, 7):
    site_count = ZZ(box_size) ** 3
    partition_value = common_base ** site_count
    for prime in support:
        assert prime_exponent(partition_value, prime) == site_count * base_exponents[prime]
    assert reconstructed_base ** site_count == partition_value

print("RESULT: PASS")
