# 対象ラベル: claim_rational_power_point_numerator_divides_base_power_difference
# 法 a で差が 0 であることと a が差を割ることの一致を ZZ で確認する。

for a in range(1, 65):
    for difference in range(-4096, 4097):
        congruent_to_zero = ZZ(difference) % a == 0
        divisible = ZZ(a).divides(ZZ(difference))
        assert congruent_to_zero == divisible

print("RESULT: PASS")
