# 対象ラベル: claim_numerator_divides_twice_threshold_box_value_minus_one
# 有限等比和の四段と (c - 1) | (c^n - 1) を ZZ 上で確認する。

for c in range(1, 65):
    c = ZZ(c)
    for n in range(1, 33):
        n = ZZ(n)
        left_product = (c - 1) * sum(c ** k for k in range(n))
        distributed_difference = sum(c ** (k + 1) for k in range(n)) - sum(c ** k for k in range(n))
        reindexed_difference = sum(c ** k for k in range(1, n + 1)) - sum(c ** k for k in range(n))
        cancelled_difference = c ** n - c ** 0
        final_difference = c ** n - 1
        assert left_product == distributed_difference
        assert distributed_difference == reindexed_difference
        assert reindexed_difference == cancelled_difference
        assert cancelled_difference == final_difference
        assert (c - 1).divides(final_difference)

print("RESULT: PASS")
