# 対象ラベル: theorem_fisher_zero_power_sum_newton_recurrence
# 式ペア: p_k = sum (-1)^(r-1) e_r p_(k-r) + (-1)^(k-1) k e_k
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    roots, degree = data["roots"], data["degree"]
    for k in range(1, degree + 1):
        right = sum(
            ((-1)**(r - 1) * elementary(roots, r) * power_sum(roots, k - r) for r in range(1, k)),
            QQbar(0),
        ) + (-1)**(k - 1) * k * elementary(roots, k)
        assert power_sum(roots, k) == right, (data["name"], k)
print("RESULT: PASS — the Newton recurrence holds for every available Fisher-zero power sum")
