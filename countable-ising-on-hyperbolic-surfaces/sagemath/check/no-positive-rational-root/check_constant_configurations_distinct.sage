# 対象ラベル: theorem_no_positive_rational_root
# 式ペア: sigma_up != sigma_down
# 帰属: 有限集合

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/no-positive-rational-root/_prelude.sage")

for vertex_count, _ in examples:
    all_up = tuple(1 for _ in range(vertex_count))
    all_down = tuple(0 for _ in range(vertex_count))
    assert vertex_count >= 1
    assert all_up[0] != all_down[0]
    assert all_up != all_down

print("RESULT: PASS — nonempty vertex sets distinguish the two constant configurations")
