# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: the embedded positive leading coefficient is nonzero in QQbar
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    assert data["multiplicities"][data["degree"]] > 0, data["name"]
    assert data["leading_coefficient"] != 0, data["name"]
print("RESULT: PASS — the positive leading multiplicity remains nonzero under both embeddings")
