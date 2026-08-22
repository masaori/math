# 対象ラベル: theorem_full_cut_fisher_zero_product_away_from_minus_one
# 式: alpha^mu(alpha) (alpha^-1)^mu(alpha^-1) = 1
# 帰属: NN、QQbar

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-product-away-from-minus-one/_prelude.sage")


for data in example_data:
    root_multiplicities = data["root_multiplicities"]
    for alpha in data["roots_away_from_minus_one"]:
        inverse = alpha^(-1)
        multiplicity = root_multiplicities[alpha]
        inverse_multiplicity = root_multiplicities[inverse]
        assert inverse_multiplicity == multiplicity, (data["name"], alpha)
        orbit_product = alpha^multiplicity * inverse^inverse_multiplicity
        assert orbit_product == QQbar(1), (data["name"], alpha)

print("RESULT: PASS — every two-element inverse orbit has multiplicity-weighted product one")
