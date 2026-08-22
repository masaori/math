# 対象ラベル: theorem_fisher_zero_sum_coefficient_ratio
# 式ペア: e_0 in B_G(sigma_0) から d >= b_G(sigma_0) >= 1

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    assert len(data["edges"]) > 0, data["name"]
    assert any(broken_count >= 1 for broken_count in data["broken_counts"]), data["name"]
    assert data["degree"] == max(
        exponent for exponent, multiplicity in enumerate(data["multiplicities"]) if multiplicity > 0
    ), data["name"]
    assert data["degree"] >= 1, data["name"]

print("RESULT: PASS — every nonempty-edge example has a broken-edge witness and positive polynomial degree")
