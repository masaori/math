# 対象ラベル: theorem_reciprocal_fisher_zero_cube_sum_coefficient_ratio
# 式ペア: e1hat^3 - 3(e1hat e2hat - 3e3hat) - 6e3hat = e1hat^3 - 3e1hat e2hat + 9e3hat - 6e3hat

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/reciprocal-fisher-zero-cube-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    roots = data["roots"]
    first = reciprocal_elementary(roots, 1)
    second = reciprocal_elementary(roots, 2)
    third = reciprocal_elementary(roots, 3)
    left = first**3 - 3 * (first * second - 3 * third) - 6 * third
    right = first**3 - 3 * first * second + 9 * third - 6 * third
    assert left == right, data["name"]

print("RESULT: PASS — distribution after the reciprocal repeated-pair substitution is exact")
