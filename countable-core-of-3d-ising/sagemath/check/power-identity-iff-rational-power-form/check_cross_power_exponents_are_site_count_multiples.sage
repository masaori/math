# 対象ラベル: claim_power_identity_iff_rational_power_form
# 素指数の交差等式、隣接立方数の互いに素性、点数による可除性、商の不変性を検証する。
# 帰属: ZZ の厳密計算。浮動小数点と極限は使わない。

prime_exponent_seeds = [ZZ(-4), ZZ(-1), ZZ(0), ZZ(2), ZZ(5)]

for seed in prime_exponent_seeds:
    exponents = {box_size: ZZ(box_size) ** 3 * seed for box_size in range(1, 8)}
    for box_size in range(1, 7):
        left_site_count = ZZ(box_size) ** 3
        right_site_count = ZZ(box_size + 1) ** 3
        left_exponent = exponents[box_size]
        right_exponent = exponents[box_size + 1]

        assert gcd(left_site_count, right_site_count) == 1
        assert right_site_count * left_exponent == left_site_count * right_exponent
        assert left_exponent % left_site_count == 0
        assert right_exponent % right_site_count == 0
        assert left_exponent // left_site_count == right_exponent // right_site_count
        assert left_exponent // left_site_count == seed

print("RESULT: PASS")
