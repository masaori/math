# 対象ラベル: theorem_reciprocal_fisher_zero_power_sum_newton_recurrence
# 式ペア: phat_k = -(sum Omega(r) phat_(k-r) + k Omega(k)) / Omega(0)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    values, degree, polynomial = data["reciprocals"], data["degree"], data["polynomial"]
    constant = QQ(polynomial[0])
    for k in range(1, 2 * degree + 3):
        numerator = sum(
            (
                QQ(polynomial[r]) * power_sum(values, k - r)
                for r in range(1, min(k - 1, degree) + 1)
            ),
            QQbar(0),
        ) + k * QQ(polynomial[k])
        right = -numerator / constant
        assert power_sum(values, k) == right, (data["name"], k)
        assert right in QQ, (data["name"], k)
print("RESULT: PASS — every reciprocal Fisher-zero power sum satisfies the rational low-coefficient recurrence")
