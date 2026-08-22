# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product
# 式: Pbar_G(1) = 2^|V| != 0 and mu_G(1) = 0
# 帰属: NN、ZZ、QQbar、QQbar[x]

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-distinct-fisher-zero-product/_prelude.sage")


for data in example_data:
    value_at_one = QQbar(data["polynomial"](1))
    assert value_at_one == QQbar(2^data["vertex_count"]), data["name"]
    assert value_at_one != 0, data["name"]
    assert QQbar(1) not in data["root_support"], data["name"]

print("RESULT: PASS — 1 is absent from every distinct Fisher root support")
