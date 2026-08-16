# SageMath: 係数写像の二場合による有限和の添字付け替えを厳密検算
# 対象ラベル: claim_even_edge_subset_maps_to_first_cycle
# 式ペア: sum_e incidence(w,e) chi(A)(e) = sum_{(e,a) in A x End, partial_G(e,a)=w} 1
# 帰属: 形式的有限集合と GF(2) の有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for chosen in subsets(edges):
    coefficients = edge_subset_coefficient_map(chosen)
    for vertex_index, vertex in enumerate(vertices):
        coefficient_weighted_sum = sum(
            (
                first_boundary[vertex_index, edge_index] * coefficients[edge_index]
                for edge_index in range(len(edges))
            ),
            GF(2).zero(),
        )
        assert coefficient_weighted_sum == endpoint_incidence_sum(chosen, vertex)

print("RESULT: PASS — coefficient-map filtering equals the incidence sum over the chosen edges")
