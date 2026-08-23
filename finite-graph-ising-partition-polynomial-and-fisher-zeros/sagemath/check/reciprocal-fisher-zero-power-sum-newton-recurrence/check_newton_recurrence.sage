# 対象ラベル: theorem_reciprocal_fisher_zero_power_sum_newton_recurrence
# 式ペア: phat_k = sum (-1)^(r-1) ehat_r phat_(k-r) + (-1)^(k-1) k ehat_k
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    values, degree = data["reciprocals"], data["degree"]
    for k in range(1, degree + 1):
        right = sum(
            ((-1)**(r - 1) * elementary(values, r) * power_sum(values, k - r) for r in range(1, k)),
            QQbar(0),
        ) + (-1)**(k - 1) * k * elementary(values, k)
        assert power_sum(values, k) == right, (data["name"], k)
print("RESULT: PASS — the Newton recurrence holds for every available reciprocal Fisher-zero power sum")
