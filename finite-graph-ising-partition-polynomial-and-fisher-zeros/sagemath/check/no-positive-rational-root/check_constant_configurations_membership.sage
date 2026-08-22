# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: sigma_up, sigma_down in S_G
# 帰属: 有限集合

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/no-positive-rational-root/_prelude.sage")

for vertex_count, edges in examples:
    _, configurations, _, _, _ = partition_data(vertex_count, edges)
    all_up = tuple(1 for _ in range(vertex_count))
    all_down = tuple(0 for _ in range(vertex_count))
    assert all_up in configurations
    assert all_down in configurations

print("RESULT: PASS — both constant maps belong to the finite spin-configuration set")
