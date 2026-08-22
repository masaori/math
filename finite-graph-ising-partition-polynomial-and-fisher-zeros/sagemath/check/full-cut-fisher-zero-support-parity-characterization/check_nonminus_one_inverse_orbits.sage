# 対象ラベル: theorem_full_cut_fisher_zero_support_parity_characterization
# 式: Z_G minus {-1} is partitioned into two-element inverse orbits
# 帰属: 有限集合、QQbar

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-support-parity-characterization/_prelude.sage")


for data in example_data:
    root_support = data["root_support"]
    roots_away_from_minus_one = root_support.difference(Set([QQbar(-1)]))
    assert QQbar(1) not in root_support, data["name"]
    for alpha in roots_away_from_minus_one:
        inverse = alpha^(-1)
        assert inverse in roots_away_from_minus_one, (data["name"], alpha)
        assert inverse != alpha, (data["name"], alpha)
    assert len(roots_away_from_minus_one) == 2 * data["inverse_orbit_count"], data["name"]

print("RESULT: PASS — every root away from -1 lies in a two-element inverse orbit")
