# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product_support_parity
# 式ペア: product(Z_G) = -1 when |Z_G| = 2n + 1
# 帰属: 有限集合、NN、QQbar

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-distinct-fisher-zero-product-support-parity/_prelude.sage")


for data in example_data:
    if data["root_support_is_odd"]:
        assert data["distinct_root_product"] == QQbar(-1), data["name"]

print("RESULT: PASS — odd root support gives distinct-root product -1")
