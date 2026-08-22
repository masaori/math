# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product
# 帰属: 有限集合、NN、ZZ、QQbar、QQbar[x] だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/full-cut-fisher-zero-support-parity-characterization/_prelude.sage")


for data in example_data:
    root_support = data["root_support"]
    remaining = root_support.difference(Set([QQbar(-1)]))
    inverse_orbits = []
    while remaining:
        alpha = next(iter(remaining))
        inverse = alpha^(-1)
        orbit = Set([alpha, inverse])
        assert orbit.cardinality() == 2, (data["name"], alpha)
        assert orbit.issubset(remaining), (data["name"], alpha)
        inverse_orbits.append(orbit)
        remaining = remaining.difference(orbit)

    data["inverse_orbits"] = tuple(inverse_orbits)
    data["distinct_root_product"] = prod(root_support, QQbar(1))
