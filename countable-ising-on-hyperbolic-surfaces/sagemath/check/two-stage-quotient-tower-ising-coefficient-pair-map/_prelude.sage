# 対象ラベル: def_quotient_tower_two_stage_ising_coefficient_pair_map

import itertools

ZZx.<x> = PolynomialRing(ZZ)

fine_vertices = ("fine_v0", "fine_v1", "fine_v2", "fine_v3")
fine_edges = (
    ("fine_v0", "fine_v1"),
    ("fine_v2", "fine_v1"),
    ("fine_v2", "fine_v3"),
    ("fine_v0", "fine_v3"),
)

coarse_vertices = ("coarse_v0", "coarse_v1")
coarse_edges = (
    ("coarse_v0", "coarse_v1"),
    ("coarse_v0", "coarse_v1"),
)

induced_vertex_map = {
    "fine_v0": "coarse_v0",
    "fine_v1": "coarse_v1",
    "fine_v2": "coarse_v0",
    "fine_v3": "coarse_v1",
}
induced_edge_map = {
    0: 0,
    1: 0,
    2: 1,
    3: 1,
}


def multiplicities(vertices, edges):
    result = {m: ZZ(0) for m in range(len(edges) + 1)}
    for spin_values in itertools.product((0, 1), repeat=len(vertices)):
        spin = dict(zip(vertices, spin_values))
        broken_count = sum(1 for source, target in edges if spin[source] != spin[target])
        result[broken_count] += 1
    return result


fine_multiplicities = multiplicities(fine_vertices, fine_edges)
coarse_multiplicities = multiplicities(coarse_vertices, coarse_edges)


def zero_extended(multiplicity_map, edge_count, degree):
    if degree <= edge_count:
        return multiplicity_map[degree]
    return ZZ(0)


def coefficient_pair(degree):
    return (
        zero_extended(fine_multiplicities, len(fine_edges), degree),
        zero_extended(coarse_multiplicities, len(coarse_edges), degree),
    )


fine_partition_polynomial = sum(
    fine_multiplicities[m] * x**m for m in range(len(fine_edges) + 1)
)
coarse_partition_polynomial = sum(
    coarse_multiplicities[m] * x**m for m in range(len(coarse_edges) + 1)
)
