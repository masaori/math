# 対象ラベル: theorem_full_cut_fisher_zero_support_parity_characterization
# 帰属: 有限集合、NN、ZZ、QQbar、QQbar[x] だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-fisher-zero-minus-one-multiplicity-parity/_prelude.sage")


for data, (_name, vertex_count, edges) in zip(example_data, examples):
    root_multiplicities = data["root_multiplicities"]
    root_support = Set(root_multiplicities.keys())
    remaining = root_support.difference(Set([QQbar(-1)]))
    inverse_orbit_count = NN(0)
    while remaining:
        alpha = next(iter(remaining))
        inverse = alpha^(-1)
        assert inverse in remaining, (data["name"], alpha)
        assert inverse != alpha, (data["name"], alpha)
        remaining = remaining.difference(Set([alpha, inverse]))
        inverse_orbit_count += 1

    incident_edge_counts = tuple(
        NN(sum(1 for source, target in edges if source == vertex or target == vertex))
        for vertex in range(vertex_count)
    )
    data["root_support"] = root_support
    data["inverse_orbit_count"] = inverse_orbit_count
    data["minus_one_indicator"] = NN(1 if data["minus_one_multiplicity"] > 0 else 0)
    data["odd_incident_vertex_exists"] = any(count % 2 == 1 for count in incident_edge_counts)
