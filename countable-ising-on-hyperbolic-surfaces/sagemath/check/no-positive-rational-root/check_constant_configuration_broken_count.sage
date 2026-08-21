# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: b_G(sigma_down) = 0
# 帰属: 有限集合、NN

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/no-positive-rational-root/_prelude.sage")

for vertex_count, edges in examples:
    all_down = tuple(0 for _ in range(vertex_count))
    broken_edges = tuple(
        edge
        for edge in edges
        if all_down[edge[0]] != all_down[edge[1]]
    )
    assert NN(len(broken_edges)) == NN.zero()

print("RESULT: PASS — the all-down configuration has broken-edge count zero")
