# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product_support_parity
# 式ペア: 1 = (-1)^(2n) = (-1)^|Z_G| in the even case
# 帰属: NN、QQbar

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-distinct-fisher-zero-product-support-parity/_prelude.sage")


for data in example_data:
    cardinality = data["root_support_cardinality"]
    if not data["root_support_is_odd"]:
        n = NN(cardinality // 2)
        assert cardinality == 2*n, data["name"]
        assert QQbar(1) == QQbar(-1)^(2*n), data["name"]
        assert QQbar(-1)^(2*n) == QQbar(-1)^cardinality, data["name"]

print("RESULT: PASS — the even-support sign equals (-1) to the support cardinality")
