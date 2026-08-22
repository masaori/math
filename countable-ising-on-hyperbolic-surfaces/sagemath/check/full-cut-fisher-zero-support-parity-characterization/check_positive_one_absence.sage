# 対象ラベル: theorem_full_cut_fisher_zero_support_parity_characterization
# 式: Pbar_G(1) = 2^|V| != 0, hence mu_G(1) = 0
# 帰属: NN、ZZ、QQbar、QQbar[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-support-parity-characterization/_prelude.sage")


for data in example_data:
    value_at_one = QQbar(data["polynomial"](1))
    configuration_count = QQbar(2^data["vertex_count"])
    assert value_at_one == configuration_count, data["name"]
    assert configuration_count != 0, data["name"]
    assert data["plus_one_multiplicity"] == 0, data["name"]

print("RESULT: PASS — +1 is absent from every Fisher zero support")
