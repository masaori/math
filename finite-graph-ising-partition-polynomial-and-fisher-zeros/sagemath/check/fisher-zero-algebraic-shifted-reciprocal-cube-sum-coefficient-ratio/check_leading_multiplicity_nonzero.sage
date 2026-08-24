# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: the positive leading multiplicity is nonzero in NN
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    leading_multiplicity = data["multiplicities"][data["degree"]]
    assert leading_multiplicity > 0, data["name"]
    assert leading_multiplicity != 0, data["name"]
print("RESULT: PASS — every positive leading multiplicity is nonzero in NN")
