# SageMath: 端点 incidence の GF(2) 和と境界偶奇の一致を厳密検算
# 対象ラベル: claim_even_edge_subset_maps_to_first_cycle
# 式ペア: sum_{(e,a) in A x End, partial_G(e,a)=w} 1 = beta_G(A)(w)
# 帰属: 形式的有限集合、自然数の有限個数、GF(2) だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for chosen in subsets(edges):
    for vertex in vertices:
        assert endpoint_incidence_sum(chosen, vertex) == boundary_parity(chosen, vertex)

print("RESULT: PASS — the GF(2) endpoint-incidence sum equals the stated boundary parity")
