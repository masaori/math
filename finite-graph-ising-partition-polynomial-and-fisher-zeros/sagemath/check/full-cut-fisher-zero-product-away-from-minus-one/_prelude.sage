# 対象ラベル: theorem_full_cut_fisher_zero_product_away_from_minus_one
# 帰属: 有限集合、NN、ZZ、QQbar、QQbar[x] だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-minus-one-multiplicity-parity/_prelude.sage")


for data in example_data:
    root_multiplicities = data["root_multiplicities"]
    data["roots_away_from_minus_one"] = Set(
        alpha
        for alpha in root_multiplicities
        if alpha != QQbar(-1)
    )
