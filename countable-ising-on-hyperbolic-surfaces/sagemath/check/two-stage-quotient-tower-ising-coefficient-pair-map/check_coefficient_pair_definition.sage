# 対象ラベル: def_quotient_tower_two_stage_ising_coefficient_pair_map

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "_prelude.sage"))

expected_pairs = {
    0: (ZZ(2), ZZ(2)),
    1: (ZZ(0), ZZ(0)),
    2: (ZZ(12), ZZ(2)),
    3: (ZZ(0), ZZ(0)),
    4: (ZZ(2), ZZ(0)),
    5: (ZZ(0), ZZ(0)),
}

for degree, expected_pair in expected_pairs.items():
    assert coefficient_pair(degree) == expected_pair

for fine_edge_index, (fine_source, fine_target) in enumerate(fine_edges):
    coarse_source, coarse_target = coarse_edges[induced_edge_map[fine_edge_index]]
    assert induced_vertex_map[fine_source] == coarse_source
    assert induced_vertex_map[fine_target] == coarse_target

assert fine_partition_polynomial == 2 + 12 * x**2 + 2 * x**4
assert coarse_partition_polynomial == 2 + 2 * x**2
assert sum(fine_multiplicities.values()) == 2 ** len(fine_vertices)
assert sum(coarse_multiplicities.values()) == 2 ** len(coarse_vertices)

print(
    "RESULT: PASS — the fine four-cycle and coarse two-vertex parallel-edge graph "
    "produce the stated raw Ising coefficient pairs with exact zero extension"
)
