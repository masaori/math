# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: 次数が三未満なら第三係数和と相異なる順序付き三重和は空和 0
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    if data["degree"] < 3:
        for a in algebraic_evaluation_points:
            assert coefficient_sum(data, a, 3) == QQbar(0), (data["name"], a)
            assert ordered_distinct_triple_sum(data, a) == QQbar(0), (data["name"], a)
print("RESULT: PASS — low-degree third-order sums are exact empty sums")
