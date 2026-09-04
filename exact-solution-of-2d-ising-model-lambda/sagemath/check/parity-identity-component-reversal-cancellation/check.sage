"""成分反転で内部側と切断線側の偶奇変化が相殺することを検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

曲がり型なし均衡配向 o の一つの辺連結成分 K を全反転した配向を o^K と
する。動辺数は変わらない。偶奇恒等式の左辺を

  動辺数 + 内部辺対 + 切断線辺対 + 局所位相

へ分けた前段の分解に対して、内部側（動辺数 + 内部辺対 + 局所位相）の
変化と切断線辺対の変化が F_2 で等しいことを検査する。従って両変化は
全体では二度現れて相殺する。

一辺二の全対象と一辺三の D=empty の自明文字対象について、全ての
曲がり型なし均衡配向と全ての辺連結成分を調べる。有限集合、F_2、整数、
Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-interior-orientation-dependence/check.sage")


def single_edge_components(side, single):
    """単純通過辺集合の非空な辺連結成分を返す。"""
    remaining = set(single)
    components = []
    while remaining:
        seed = min(remaining)
        stack = [seed]
        component = set()
        while stack:
            edge = stack.pop()
            if edge in component:
                continue
            component.add(edge)
            tail, head = base_endpoints(side, edge)
            for other in remaining:
                other_tail, other_head = base_endpoints(side, other)
                if tail in (other_tail, other_head) or head in (other_tail, other_head):
                    stack.append(other)
        remaining -= component
        components.append(frozenset(component))
    return components


def reverse_component(orientation, component):
    return {
        edge: (1 - direction if edge in component else direction)
        for edge, direction in orientation.items()
    }


def check_component_reversals(side, doubled, single, orientations):
    checks = ZZ(0)
    changing = ZZ(0)
    for orientation in orientations:
        pieces, total = pair_and_seam_decomposition(
            side, doubled, single, orientation)
        moved, interior, seam, local_phase = pieces
        for component in single_edge_components(side, single):
            reversed_orientation = reverse_component(orientation, component)
            assert reversed_orientation in orientations
            reversed_pieces, reversed_total = pair_and_seam_decomposition(
                side, doubled, single, reversed_orientation)
            reversed_moved, reversed_interior, reversed_seam, reversed_local_phase = reversed_pieces

            interior_change = (moved + interior + local_phase
                               + reversed_moved + reversed_interior
                               + reversed_local_phase) % 2
            seam_change = (seam + reversed_seam) % 2
            assert moved == reversed_moved
            assert interior_change == seam_change
            assert total == reversed_total
            checks += 1
            changing += interior_change
    return checks, changing


checks_two = ZZ(0)
changing_two = ZZ(0)
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    if not selectors or not character_is_trivial_general(2, single):
        continue
    orientations = curved_free_orientations(2, single)
    count, changing = check_component_reversals(
        2, doubled, single, orientations)
    checks_two += count
    changing_two += changing

checks_three = ZZ(0)
changing_three = ZZ(0)
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    orientations = curved_free_orientations(3, single)
    if not orientations:
        continue
    count, changing = check_component_reversals(
        3, frozenset(), single, orientations)
    checks_three += count
    changing_three += changing

assert checks_two > 0 and checks_three > 0
assert changing_two > 0 and changing_three > 0
print("PASS: 成分反転で内部側と切断線側の偶奇変化が相殺"
      "（一辺二 %d 反転・非零変化 %d 件、一辺三 %d 反転・非零変化 %d 件）"
      % (checks_two, changing_two, checks_three, changing_three))
