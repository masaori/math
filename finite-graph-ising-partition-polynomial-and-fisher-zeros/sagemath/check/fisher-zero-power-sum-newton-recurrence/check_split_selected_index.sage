# 対象ラベル: theorem_fisher_zero_power_sum_newton_recurrence
# 式ペア: e_r p_(k-r) = h_r + h_(r+1)
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    roots, degree = data["roots"], data["degree"]
    for k in range(2, degree + 1):
        for r in range(1, k):
            left = elementary(roots, r) * power_sum(roots, k - r)
            right = indexed_sum(roots, k, r) + indexed_sum(roots, k, r + 1)
            assert left == right, (data["name"], k, r)
print("RESULT: PASS — selected and unselected indices give adjacent indexed sums")
