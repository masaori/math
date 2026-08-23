# 対象ラベル: theorem_reciprocal_fisher_zero_power_sum_newton_recurrence
# 式ペア: ehat_r phat_(k-r) = hhat_r + hhat_(r+1)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    values, degree = data["reciprocals"], data["degree"]
    for k in range(2, degree + 1):
        for r in range(1, k):
            left = elementary(values, r) * power_sum(values, k - r)
            right = indexed_sum(values, k, r) + indexed_sum(values, k, r + 1)
            assert left == right, (data["name"], k, r)
print("RESULT: PASS — selected and unselected reciprocal-root indices give adjacent indexed sums")
