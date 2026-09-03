"""曲がり型を持たない均衡配向の重み付き数を、一辺二で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

自明文字で選択集合が非空な各ファイバーについて、曲がり型頂点を持たない
均衡配向 o の重みを 2^s(o)（s(o) は直進型次数 4 頂点数）とする。
この重みの総和が E の巡回空間の位数 2^(|E|-|V(E)|+c(E)) に等しく、
各ねじれで非零の配向類の位相和が選択和と同じ符号を持つことを検査する。
有限集合、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/trivial-character-orientation-local-factor/check.sage")

fiber_checks = ZZ(0)
twist_checks = ZZ(0)
weighted_orientation_distribution = {}

for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    inside = even_subgraphs_inside(single)
    character_is_trivial = all(character_value(single, item) == 1
                               for item in inside)
    if not selectors or not character_is_trivial:
        continue

    vertex_count, component_count = nonempty_vertex_and_component_counts(single)
    cycle_rank = ZZ(len(single)) - vertex_count + component_count
    classes = {}
    for phi in fiber:
        orientation = induced_orientation(phi, single)
        orientation_key = tuple(sorted(orientation.items()))
        classes.setdefault(orientation_key, []).append(phi)

    curved_free = []
    weighted_count = ZZ(0)
    for orientation_key, part in classes.items():
        orientation = dict(orientation_key)
        curved, straight = local_vertex_counts(single, orientation)
        if curved == 0:
            curved_free.append((orientation, part, straight))
            weighted_count += ZZ(2) ** straight

    expected_count = ZZ(2) ** cycle_rank
    assert weighted_count == expected_count
    assert expected_count == len(selectors)
    weighted_orientation_distribution[(cycle_rank, len(curved_free))] = (
        weighted_orientation_distribution.get((cycle_rank, len(curved_free)), ZZ(0)) + 1
    )
    fiber_checks += 1

    for a in (0, 1):
        for b in (0, 1):
            signed_selection_sum = sum(
                (
                    signed_even_subgraph_weight(a, b, doubled.union(selected))
                    * signed_even_subgraph_weight(
                        a, b, doubled.union(single.difference(selected)))
                    for selected in selectors
                ),
                ZZ(0),
            )
            selection_sign = ZZ(sign(signed_selection_sum))
            assert abs(signed_selection_sum) == expected_count

            curved_free_sum = K8(0)
            for orientation, part, straight in curved_free:
                part_sum = sum(
                    (contributions[permutation_key(phi)][(a, b)] for phi in part),
                    K8(0),
                )
                assert part_sum in ZZ
                assert ZZ(part_sum) == selection_sign * ZZ(2) ** straight
                curved_free_sum += part_sum

            assert curved_free_sum == K8(signed_selection_sum)
            twist_checks += 1

assert fiber_checks == 369
assert twist_checks == 1476
print("weighted orientation distribution %s" %
      sorted(weighted_orientation_distribution.items()))
print("PASS: 曲がり型を持たない均衡配向の重み付き数と符号を %d ファイバー・%d ねじれで検査" %
      (fiber_checks, twist_checks))
