"""配向類の局所行列式和と選択項が同じ継ぎ目符号を受けることを検査する。

対象: claim_winding_parity_symmetric_difference_additivity,
      claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

有限集合、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/curved-free-class-sum-selection-sign/check.sage")


def seam_twist_factor(side, a, b, single):
    horizontal, vertical = subset_parities(side, single)
    return K8(ZZ(-1) ** (a * horizontal + b * vertical))


class_checks_two = ZZ(0)
selection_checks_two = ZZ(0)
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    if not selectors or not character_is_trivial_general(2, single):
        continue
    for orientation in curved_free_orientations(2, single):
        base_value = class_sum_by_local_formula(
            2, doubled, single, orientation, 0, 0)
        for a in (0, 1):
            for b in (0, 1):
                factor = seam_twist_factor(2, a, b, single)
                assert class_sum_by_local_formula(
                    2, doubled, single, orientation, a, b) == factor * base_value
                class_checks_two += 1
    for selected in selectors:
        base_term = (signed_even_subgraph_weight(0, 0, doubled.union(selected))
                     * signed_even_subgraph_weight(
                         0, 0, doubled.union(single.difference(selected))))
        for a in (0, 1):
            for b in (0, 1):
                term = (signed_even_subgraph_weight(a, b, doubled.union(selected))
                        * signed_even_subgraph_weight(
                            a, b, doubled.union(single.difference(selected))))
                assert K8(term) == seam_twist_factor(2, a, b, single) * K8(base_term)
                selection_checks_two += 1

print("PASS: L=2 の配向類 %d 件・選択項 %d 件で継ぎ目符号の比を検査"
      % (class_checks_two, selection_checks_two))

class_checks_three = ZZ(0)
selection_checks_three = ZZ(0)
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    cycles = fundamental_cycles(3, single)
    selectors = set()
    for coefficients in cartesian_product([(0, 1)] * len(cycles)):
        selected = set()
        for coefficient, cycle in zip(coefficients, cycles):
            if coefficient:
                selected.symmetric_difference_update(cycle)
        selectors.add(frozenset(selected))
    for orientation in curved_free_orientations(3, single):
        base_value = class_sum_by_local_formula(
            3, frozenset(), single, orientation, 0, 0)
        for a in (0, 1):
            for b in (0, 1):
                factor = seam_twist_factor(3, a, b, single)
                assert class_sum_by_local_formula(
                    3, frozenset(), single, orientation, a, b) == factor * base_value
                class_checks_three += 1
    for selected in selectors:
        base_term = (signed_weight(3, 0, 0, selected)
                     * signed_weight(3, 0, 0, single.difference(selected)))
        for a in (0, 1):
            for b in (0, 1):
                term = (signed_weight(3, a, b, selected)
                        * signed_weight(3, a, b, single.difference(selected)))
                assert K8(term) == seam_twist_factor(3, a, b, single) * K8(base_term)
                selection_checks_three += 1

print("PASS: L=3, D=empty の配向類 %d 件・選択項 %d 件で継ぎ目符号の比を検査"
      % (class_checks_three, selection_checks_three))
