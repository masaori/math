# 対象ラベル: theorem_fisher_zero_power_sum_newton_recurrence
# 式ペア: p_k = -(sum Omega(d-r) p_(k-r) + k Omega(d-k)) / Omega(d)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    roots, degree, polynomial = data["roots"], data["degree"], data["polynomial"]
    leading = QQ(polynomial[degree])
    for k in range(1, degree + 1):
        numerator = sum(
            (QQ(polynomial[degree - r]) * power_sum(roots, k - r) for r in range(1, k)),
            QQbar(0),
        ) + k * QQ(polynomial[degree - k])
        right = -numerator / leading
        assert power_sum(roots, k) == right, (data["name"], k)
        assert right in QQ, (data["name"], k)
print("RESULT: PASS — every Fisher-zero power sum satisfies the rational high-coefficient recurrence")
