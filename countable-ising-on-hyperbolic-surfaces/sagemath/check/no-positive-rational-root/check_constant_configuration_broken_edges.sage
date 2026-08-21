# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: B_G(sigma_up) = emptyset および B_G(sigma_down) = emptyset
# 帰属: 有限集合

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/no-positive-rational-root/_prelude.sage")

for vertex_count, edges in examples:
    all_up = tuple(1 for _ in range(vertex_count))
    all_down = tuple(0 for _ in range(vertex_count))
    up_broken_edges = tuple(
        edge
        for edge in edges
        if all_up[edge[0]] != all_up[edge[1]]
    )
    down_broken_edges = tuple(
        edge
        for edge in edges
        if all_down[edge[0]] != all_down[edge[1]]
    )
    assert up_broken_edges == ()
    assert down_broken_edges == ()

print("RESULT: PASS — both constant configurations have the empty broken-edge set")
