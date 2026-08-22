# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product
# 式: product(Z_G) = -1 if -1 belongs to Z_G, and 1 otherwise
# 帰属: 有限集合、QQbar

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-distinct-fisher-zero-product/_prelude.sage")


for data in example_data:
    orbit_product = prod(
        (prod(orbit, QQbar(1)) for orbit in data["inverse_orbits"]),
        QQbar(1),
    )
    expected = -orbit_product if QQbar(-1) in data["root_support"] else orbit_product
    assert data["distinct_root_product"] == expected, data["name"]
    assert expected == (-1 if QQbar(-1) in data["root_support"] else 1), data["name"]

print("RESULT: PASS — the distinct-root product is determined by membership of -1")
