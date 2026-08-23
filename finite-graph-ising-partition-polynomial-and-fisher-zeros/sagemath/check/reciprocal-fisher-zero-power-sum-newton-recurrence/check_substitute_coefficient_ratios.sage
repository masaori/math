# 対象ラベル: theorem_reciprocal_fisher_zero_power_sum_newton_recurrence
# 式ペア: substitute signed low-degree coefficient ratios into the reciprocal-root Newton recurrence
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    values, degree, polynomial = data["reciprocals"], data["degree"], data["polynomial"]
    constant = QQ(polynomial[0])
    for k in range(1, 2 * degree + 3):
        left = sum(
            (
                (-1)**(r - 1) * elementary(values, r) * power_sum(values, k - r)
                for r in range(1, min(k - 1, degree) + 1)
            ),
            QQbar(0),
        ) + (-1)**(k - 1) * k * elementary(values, k)
        right = sum(
            (
                (-1)**(r - 1)
                * ((-1)**r * QQ(polynomial[r]) / constant)
                * power_sum(values, k - r)
                for r in range(1, min(k - 1, degree) + 1)
            ),
            QQbar(0),
        ) + (-1)**(k - 1) * k * ((-1)**k * QQ(polynomial[k]) / constant)
        assert left == right, (data["name"], k)
print("RESULT: PASS — reciprocal Fisher-zero symmetric sums are replaced by low-degree coefficient ratios")
