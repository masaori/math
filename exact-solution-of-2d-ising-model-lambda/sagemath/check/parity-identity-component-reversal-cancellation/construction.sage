"""成分反転で内部側と切断線側の偶奇変化が相殺することを検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-interior-orientation-dependence/construction.sage")


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
