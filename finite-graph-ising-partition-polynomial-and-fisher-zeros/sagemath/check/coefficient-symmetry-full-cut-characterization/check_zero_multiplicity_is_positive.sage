# 対象ラベル: theorem_coefficient_symmetry_characterizes_full_cut
# 式: Omega_G(0) >= 1
# 帰属: 有限集合、NN

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/coefficient-symmetry-full-cut-characterization/_prelude.sage")

for name, vertex_count, edges in examples:
    configurations, multiplicities, _ = partition_data(vertex_count, edges)
    all_down = tuple(0 for _ in range(vertex_count))
    assert all_down in configurations
    assert broken_edge_set(all_down, edges) == frozenset()
    assert multiplicities[0] >= 1

print("RESULT: PASS — the all-down configuration lies in every zero-broken-edge fiber")
