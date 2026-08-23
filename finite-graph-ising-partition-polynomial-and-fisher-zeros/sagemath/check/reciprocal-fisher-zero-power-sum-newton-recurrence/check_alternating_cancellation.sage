# 対象ラベル: theorem_reciprocal_fisher_zero_power_sum_newton_recurrence
# 式ペア: alternating sum of adjacent reciprocal-root indexed sums leaves hhat_1 and signed hhat_k
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    values, degree = data["reciprocals"], data["degree"]
    if degree == 0:
        continue
    for k in range(2, 2 * degree + 3):
        last_order = min(k - 1, degree)
        left = sum(
            (
                (-1)**(r - 1) * (indexed_sum(values, k, r) + indexed_sum(values, k, r + 1))
                for r in range(1, last_order + 1)
            ),
            QQbar(0),
        )
        right = indexed_sum(values, k, 1) + (-1)**(last_order - 1) * indexed_sum(values, k, last_order + 1)
        assert left == right, (data["name"], k)
print("RESULT: PASS — intermediate reciprocal-root indexed sums cancel in the alternating sum")
