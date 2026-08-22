# 対象ラベル: theorem_full_cut_fisher_zero_product_away_from_minus_one
# 式: product_{alpha in Z_G minus {-1}} alpha^mu_G(alpha) = 1
# 帰属: 有限集合、NN、QQbar

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-product-away-from-minus-one/_prelude.sage")


for data in example_data:
    root_multiplicities = data["root_multiplicities"]
    total_product = prod(
        alpha^root_multiplicities[alpha]
        for alpha in data["roots_away_from_minus_one"]
    )
    assert QQbar(total_product) == QQbar(1), data["name"]

print("RESULT: PASS — the multiplicity-weighted product away from -1 is one")
