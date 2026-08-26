# 対象ラベル: claim_numerator_divides_twice_threshold_box_value_minus_one
# 整除の二倍への移送と推移で a | 2(c^n - 1) を得る段を ZZ 上で確認する。

for c in range(1, 33):
    c = ZZ(c)
    for n in range(1, 17):
        n = ZZ(n)
        base_difference = c - 1
        power_difference = c ** n - 1
        assert base_difference.divides(power_difference)
        assert (2 * base_difference).divides(2 * power_difference)
        candidate_divisors = range(1, 129) if base_difference == 0 else divisors(2 * base_difference)
        for a in candidate_divisors:
            a = ZZ(a)
            assert a.divides(2 * base_difference)
            assert a.divides(2 * power_difference)

print("RESULT: PASS")
