# 対象ラベル: claim_numerator_divides_twice_threshold_box_value_minus_one
# Z_{L_0}(q) = c^n の代入で最終整除へ移る段を ZZ 上で確認する。

for c in range(1, 33):
    c = ZZ(c)
    for n in range(1, 17):
        n = ZZ(n)
        threshold_box_value = c ** n
        candidate_divisors = range(1, 129) if c == 1 else divisors(2 * (c - 1))
        for a in candidate_divisors:
            a = ZZ(a)
            assert a.divides(2 * (c - 1))
            assert threshold_box_value == c ** n
            assert a.divides(2 * (threshold_box_value - 1))

print("RESULT: PASS")
