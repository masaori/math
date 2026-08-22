# 対象ラベル: theorem_full_cut_fisher_zero_support_parity_characterization
# 式: Pbar_G(0) = Omega_G(0) != 0, hence mu_G(0) = 0
# 帰属: NN、ZZ、QQbar、QQbar[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-support-parity-characterization/_prelude.sage")


for data in example_data:
    integer_value_at_zero = ZZ(data["polynomial"](0))
    algebraic_value_at_zero = QQbar(integer_value_at_zero)
    assert integer_value_at_zero >= 1, data["name"]
    assert algebraic_value_at_zero != 0, data["name"]
    assert QQbar(0) not in data["root_support"], data["name"]

print("RESULT: PASS — zero has positive constant value and multiplicity zero")
