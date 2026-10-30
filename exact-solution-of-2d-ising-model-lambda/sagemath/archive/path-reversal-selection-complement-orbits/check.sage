"""経路反転軌道と選択補集合軌道を厳密検査する。

対象: claim_path_reversal_selection_complement_orbits。

一辺 L=2 の全ファイバーと四つのスピン構造について、経路反転と選択補集合が
同じ符号の集合を一元または二元の互いに素な軌道へ分けることを検査する。
浮動小数点は使わない。
"""

load("sagemath/check/fiber-phase-integer-decomposition/check.sage")


def reverse_edge(edge):
    kind, i, j, direction = edge
    return (kind, i, j, 1 - direction)


def path_reversal(phi):
    inverse = {image: edge for edge, image in phi.items()}
    return {edge: reverse_edge(inverse[reverse_edge(edge)]) for edge in oriented}


selection_base_edges = [(kind, i, j) for kind in ("h", "v") for i in range(L) for j in range(L)]
selection_subsets = [frozenset(subset) for subset in Subsets(set(selection_base_edges))]


def selection_edge_endpoints(edge):
    kind, i, j = edge
    return ((i, j), (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j))


def is_even_selection_subset(subset):
    degree = {}
    for edge in subset:
        for vertex in selection_edge_endpoints(edge):
            degree[vertex] = degree.get(vertex, 0) + 1
    return all(value % 2 == 0 for value in degree.values())


def selection_winding_parities(subset):
    return (
        sum(ZZ(kind == "h" and j == L - 1) for kind, i, j in subset) % 2,
        sum(ZZ(kind == "v" and i == L - 1) for kind, i, j in subset) % 2,
    )


def selection_exponent(a, b, doubled, single, selected):
    first_h, first_v = selection_winding_parities(doubled.union(selected))
    second_h, second_v = selection_winding_parities(doubled.union(single.difference(selected)))
    return ZZ((1 + a) * first_h + (1 + b) * first_v + first_h * first_v
              + (1 + a) * second_h + (1 + b) * second_v + second_h * second_v)


def involution_orbits(elements, involution):
    remaining = set(elements)
    orbits = []
    while remaining:
        element = next(iter(remaining))
        orbit = frozenset((element, involution(element)))
        assert orbit.issubset(remaining)
        assert 1 <= len(orbit) <= 2
        orbits.append(orbit)
        remaining.difference_update(orbit)
    assert set().union(*orbits) == set(elements) if orbits else not elements
    assert sum(len(orbit) for orbit in orbits) == len(elements)
    return orbits


permutation_checks = 0
selection_checks = 0
for (doubled, single), fiber in all_fibers.items():
    selectors = {
        selected for selected in selection_subsets
        if selected.issubset(single)
        and is_even_selection_subset(doubled.union(selected))
    }
    for a in (0, 1):
        for b in (0, 1):
            for sign in (K8(1), K8(-1)):
                signed_permutations = {
                    permutation_key(phi): phi for phi in fiber
                    if phase_contribution(phi, a, b) == sign
                }
                permutation_orbits = involution_orbits(
                    signed_permutations,
                    lambda key: permutation_key(path_reversal(signed_permutations[key])),
                )
                assert all(
                    phase_contribution(signed_permutations[key], a, b) == sign
                    for orbit in permutation_orbits for key in orbit
                )
                permutation_checks += len(signed_permutations)

                integer_sign = ZZ(sign)
                signed_selectors = {
                    selected for selected in selectors
                    if ZZ(-1) ** selection_exponent(a, b, doubled, single, selected) == integer_sign
                }
                selection_orbits = involution_orbits(
                    signed_selectors,
                    lambda selected: single.difference(selected),
                )
                if single:
                    assert all(len(orbit) == 2 for orbit in selection_orbits)
                assert all(
                    ZZ(-1) ** selection_exponent(a, b, doubled, single, selected) == integer_sign
                    for orbit in selection_orbits for selected in orbit
                )
                selection_checks += len(signed_selectors)

print("PASS: L=%d の符号別置換 %d 件と符号別選択 %d 件を、"
      "経路反転軌道と選択補集合軌道へ互いに素に分割"
      % (L, permutation_checks, selection_checks))
