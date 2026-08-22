# 対象ラベル: theorem_fisher_zero_power_sum_newton_recurrence
# 式ペア: alternating sum of adjacent indexed sums leaves h_1 and signed h_k
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-power-sum-newton-recurrence/_prelude.sage")
for data in examples:
    roots, degree = data["roots"], data["degree"]
    for k in range(2, degree + 1):
        left = sum(
            ((-1)**(r - 1) * (indexed_sum(roots, k, r) + indexed_sum(roots, k, r + 1)) for r in range(1, k)),
            QQbar(0),
        )
        right = indexed_sum(roots, k, 1) + (-1)**(k - 2) * indexed_sum(roots, k, k)
        assert left == right, (data["name"], k)
print("RESULT: PASS — intermediate indexed sums cancel in the alternating sum")
