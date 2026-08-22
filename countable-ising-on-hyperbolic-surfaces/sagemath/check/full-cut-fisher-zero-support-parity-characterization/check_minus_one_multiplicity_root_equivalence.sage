# 対象ラベル: theorem_full_cut_fisher_zero_support_parity_characterization
# 式: epsilon_G = 1 iff mu_G(-1) > 0 iff Pbar_G(-1) = 0 iff Z_G(-1) = 0
# 帰属: NN、ZZ、QQbar、QQbar[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-support-parity-characterization/_prelude.sage")


for data in example_data:
    indicator_is_one = data["minus_one_indicator"] == 1
    multiplicity_is_positive = data["minus_one_multiplicity"] > 0
    algebraic_value_is_zero = QQbar(data["polynomial"](-1)) == 0
    integer_value_is_zero = ZZ(data["polynomial"](-1)) == 0
    assert indicator_is_one == multiplicity_is_positive, data["name"]
    assert multiplicity_is_positive == algebraic_value_is_zero, data["name"]
    assert algebraic_value_is_zero == integer_value_is_zero, data["name"]

print("RESULT: PASS — the -1 indicator, positive multiplicity, and root conditions are equivalent")
