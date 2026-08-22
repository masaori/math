# 対象ラベル: theorem_coefficient_symmetry_characterizes_full_cut
# 式: Omega_G(|E|) = Omega_G(0) >= 1 から全辺二分割を復元する
# 帰属: 有限集合、NN

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/coefficient-symmetry-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    configurations, multiplicities, _ = partition_data(vertex_count, edges)
    if not has_symmetric_coefficients(multiplicities):
        continue

    assert multiplicities[-1] == multiplicities[0]
    assert multiplicities[-1] >= 1
    fully_broken_configurations = tuple(
        configuration
        for configuration in configurations
        if len(broken_edge_set(configuration, edges)) == len(edges)
    )
    assert len(fully_broken_configurations) == multiplicities[-1]
    assert fully_broken_configurations

    witness = fully_broken_configurations[0]
    recovered_cut = frozenset(
        vertex for vertex in range(vertex_count) if witness[vertex] == 1
    )
    assert is_full_cut(recovered_cut, edges)

print("RESULT: PASS — symmetric coefficients force a fully broken configuration and recover a full cut")
