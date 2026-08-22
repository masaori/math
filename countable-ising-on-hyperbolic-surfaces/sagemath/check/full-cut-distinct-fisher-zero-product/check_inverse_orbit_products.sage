# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product
# 式: product(beta for beta in O) = alpha * alpha^(-1) = 1
# 帰属: 有限集合、QQbar

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-distinct-fisher-zero-product/_prelude.sage")


for data in example_data:
    for orbit in data["inverse_orbits"]:
        alpha = next(iter(orbit))
        assert orbit == Set([alpha, alpha^(-1)]), (data["name"], alpha)
        assert prod(orbit, QQbar(1)) == QQbar(1), (data["name"], alpha)

print("RESULT: PASS — every two-element inverse orbit has product 1")
