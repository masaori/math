# 対象ラベル: theorem_full_cut_fisher_zero_product_away_from_minus_one
# 式: Pbar_G(1) = 2^|V| != 0, hence mu_G(1) = 0
# 帰属: NN、ZZ、QQbar、QQbar[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-product-away-from-minus-one/_prelude.sage")


for data in example_data:
    polynomial = data["polynomial"]
    vertex_count = data["vertex_count"]
    value_at_one = QQbar(polynomial(1))
    all_configuration_count = QQbar(2^vertex_count)
    assert value_at_one == all_configuration_count, data["name"]
    assert all_configuration_count != 0, data["name"]
    assert data["plus_one_multiplicity"] == 0, data["name"]

print("RESULT: PASS — +1 has value 2^|V| and multiplicity zero")
