# SageMath: ホモロジー類写像のファイバーによる有限和の分割を厳密検算
# 対象ラベル: theorem_homology_class_polynomials_recombine
# 式: sum_h sum_{A in eta_C^{-1}({h})} weight(A) = sum_{A in Z_1(G)} weight(A)
# 帰属: 形式的有限集合、GF(2) 上の有限商、ZZ[u,v] だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

fibers = {
    homology_class: {
        chosen
        for chosen in even_edge_subsets
        if homology_class_map(chosen) == homology_class
    }
    for homology_class in first_homology_group
}

assert set().union(*fibers.values()) == set(even_edge_subsets)
for left_class in first_homology_group:
    for right_class in first_homology_group:
        if left_class != right_class:
            assert fibers[left_class].isdisjoint(fibers[right_class])
assert expanded_fiber_sum == even_subgraph_polynomial

print("RESULT: PASS — the fibers partition all even edge subsets and preserve the finite polynomial sum")
