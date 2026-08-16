# SageMath: 一次境界写像と係数写像の行列積の定義を厳密検算
# 対象ラベル: claim_even_edge_subset_maps_to_first_cycle
# 式ペア: (partial_1 chi(A))(w) = sum_e (sum_a 1[partial_G(e,a)=w]) chi(A)(e)
# 帰属: 形式的有限集合と GF(2) の有限行列・有限和だけを用いる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

for chosen in subsets(edges):
    coefficients = edge_subset_coefficient_map(chosen)
    product_value = first_boundary * coefficients
    for vertex_index, vertex in enumerate(vertices):
        expanded_value = sum(
            (
                first_boundary[vertex_index, edge_index] * coefficients[edge_index]
                for edge_index in range(len(edges))
            ),
            GF(2).zero(),
        )
        assert product_value[vertex_index] == expanded_value

print("RESULT: PASS — the first boundary matrix product equals its componentwise finite sum")
