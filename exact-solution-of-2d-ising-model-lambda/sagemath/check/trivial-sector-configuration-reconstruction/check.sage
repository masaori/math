# 対象ラベル: claim_trivial_sector_configuration_reconstruction
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))


def edge_subsets(L):
    edge_list = list(range(1, 2 * L * L + 1))
    for size in range(len(edge_list) + 1):
        for subset in combinations(edge_list, size):
            yield frozenset(subset)


def broken_edge_set(L, sigma):
    return frozenset(edge for edge in range(1, 2 * L * L + 1)
                     if sigma[endpoints(L, edge)[0]] != sigma[endpoints(L, edge)[1]])


def dual_edge(L, edge):
    if edge <= L * L:
        index = edge - 1
        i, j = index // L, index % L
        return edge_number_vertical(L, i, j + 1)
    index = edge - L * L - 1
    i, j = index // L, index % L
    return edge_number_horizontal(L, i + 1, j)


def incidence_count(L, subset, vertex):
    return sum(ZZ(1) for edge in subset for endpoint in endpoints(L, edge)
               if endpoint == vertex)


def is_even_subgraph(L, subset):
    return all(incidence_count(L, subset, vertex) % 2 == 0
               for vertex in vertices(L))


def winding_sector(L, subset):
    horizontal_cut = frozenset(edge_number_horizontal(L, i, -1) for i in range(L))
    vertical_cut = frozenset(edge_number_vertical(L, -1, j) for j in range(L))
    return (len(subset.intersection(horizontal_cut)) % 2,
            len(subset.intersection(vertical_cut)) % 2)


for L in (1, 2, 3):
    fibers = {}
    for sigma in configurations(L):
        dual_broken = frozenset(dual_edge(L, edge) for edge in broken_edge_set(L, sigma))
        fibers.setdefault(dual_broken, []).append(sigma)

    trivial_sector = {
        subset for subset in edge_subsets(L)
        if is_even_subgraph(L, subset) and winding_sector(L, subset) == (0, 0)
    }
    assert set(fibers) == trivial_sector
    assert all(len(preimages) == 2 for preimages in fibers.values())
    for preimages in fibers.values():
        sigma, tau = preimages
        assert all(tau[vertex] == -sigma[vertex] for vertex in vertices(L))
    print("L=%d: 自明セクター %d 個の各原像が全スピン反転の二配位" %
          (L, len(trivial_sector)))

print("RESULT: PASS")

# 原像二点の全数検査に続き、A から独立構成した道和の各行を検査する。
check_files = (
    'check_horizontal_indicator_projection.sage',
    'check_vertical_indicator_projection.sage',
    'check_parity_representative.sage',
    'check_configuration_definition.sage',
    'check_spin_disagreement_four_cases.sage',
    'check_horizontal_difference.sage',
    'check_vertical_path_expansion.sage',
    'check_vertical_face_substitution.sage',
    'check_vertical_telescoping.sage',
    'check_vertical_terminal_representative.sage',
    'check_vertical_zero_projection.sage',
    'check_vertical_characteristic_two.sage',
    'check_vertical_periodic_boundary.sage',
    'check_broken_definition.sage',
    'check_broken_exponent_substitution.sage',
    'check_broken_parity.sage',
    'check_broken_membership.sage',
    'check_dual_image_substitution.sage',
    'check_dual_image_inverse.sage',
)
for check_file in check_files:
    load(os.path.join(_dir, check_file))

print("行別検算: %d files; 部分グラフ数 %s" %
      (len(check_files), {L: sum(case['L'] == L for case in _rc_cases) for L in (1, 2, 3)}))
print("RESULT: PASS")
