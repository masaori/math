# 対象ラベル: theorem_full_cut_fisher_zero_product_away_from_minus_one
# 式: Z_G minus {-1} is partitioned into two-element inverse orbits
# 帰属: 有限集合、QQbar

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-product-away-from-minus-one/_prelude.sage")


for data in example_data:
    remaining = data["roots_away_from_minus_one"]
    orbit_count = NN(0)
    while remaining:
        alpha = next(iter(remaining))
        inverse = alpha^(-1)
        assert alpha != inverse, (data["name"], alpha)
        assert inverse in remaining, (data["name"], alpha)
        remaining = remaining.difference(Set([alpha, inverse]))
        orbit_count += 1
    assert 2 * orbit_count == len(data["roots_away_from_minus_one"]), data["name"]

print("RESULT: PASS — every root away from -1 lies in a two-element inverse orbit")
