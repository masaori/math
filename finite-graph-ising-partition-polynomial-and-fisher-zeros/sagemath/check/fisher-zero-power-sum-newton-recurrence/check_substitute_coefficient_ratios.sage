# 対象ラベル: theorem_fisher_zero_power_sum_newton_recurrence
# 式ペア: substitute signed high-degree coefficient ratios into the Newton recurrence
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    roots, degree, polynomial = data["roots"], data["degree"], data["polynomial"]
    leading = QQ(polynomial[degree])
    for k in range(1, degree + 1):
        left = sum(
            ((-1)**(r - 1) * elementary(roots, r) * power_sum(roots, k - r) for r in range(1, k)),
            QQbar(0),
        ) + (-1)**(k - 1) * k * elementary(roots, k)
        right = sum(
            (
                (-1)**(r - 1)
                * ((-1)**r * QQ(polynomial[degree - r]) / leading)
                * power_sum(roots, k - r)
                for r in range(1, k)
            ),
            QQbar(0),
        ) + (-1)**(k - 1) * k * ((-1)**k * QQ(polynomial[degree - k]) / leading)
        assert left == right, (data["name"], k)
print("RESULT: PASS — Fisher-zero symmetric sums are replaced by high-degree coefficient ratios")
