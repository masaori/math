# SageMath: 偶辺部分集合の境界偶奇が全頂点で零になることを厳密検算
# 対象ラベル: claim_even_edge_subset_maps_to_first_cycle
# 式ペア: beta_G(A)(w) = 0 for A in Z_1(G)
# 帰属: 形式的有限集合と GF(2) だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

even_subsets = [chosen for chosen in subsets(edges) if is_even_edge_subset(chosen)]
assert len(even_subsets) > 1

for chosen in even_subsets:
    coefficients = edge_subset_coefficient_map(chosen)
    assert first_boundary * coefficients == vector(
        GF(2),
        [GF(2).zero() for vertex in vertices],
    )
    for vertex in vertices:
        assert boundary_parity(chosen, vertex) == GF(2).zero()

print("RESULT: PASS — every enumerated even edge subset maps into the kernel of the first boundary matrix")
