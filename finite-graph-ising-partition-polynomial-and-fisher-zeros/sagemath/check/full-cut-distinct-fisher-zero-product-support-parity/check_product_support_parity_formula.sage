# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product_support_parity
# 式: product(Z_G) = (-1)^|Z_G|
# 帰属: 有限集合、NN、QQbar

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-distinct-fisher-zero-product-support-parity/_prelude.sage")


for data in example_data:
    expected = QQbar(-1)^data["root_support_cardinality"]
    assert data["distinct_root_product"] == expected, data["name"]

print("RESULT: PASS — the distinct-root product equals (-1) to the root-support cardinality")
