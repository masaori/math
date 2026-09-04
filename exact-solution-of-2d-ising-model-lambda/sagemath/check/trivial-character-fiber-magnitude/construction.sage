"""自明文字ファイバーの共通絶対値を巡回階数で記述し、一辺二で検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/kac-ward-fiber-signed-selection-equality/construction.sage")


def even_subgraphs_inside(edge_subset):
    return [subset for subset in base_edge_subsets
            if subset.issubset(edge_subset) and is_even_edge_subset(subset)]


def nonempty_vertex_and_component_counts(edge_subset):
    adjacency = {}
    for edge in edge_subset:
        first, second = endpoints(L, edge + (0,))
        adjacency.setdefault(first, set()).add(second)
        adjacency.setdefault(second, set()).add(first)
    seen = set()
    component_count = 0
    for root in adjacency:
        if root in seen:
            continue
        component_count += 1
        seen.add(root)
        stack = [root]
        while stack:
            vertex = stack.pop()
            for neighbor in adjacency[vertex]:
                if neighbor not in seen:
                    seen.add(neighbor)
                    stack.append(neighbor)
    return ZZ(len(adjacency)), ZZ(component_count)


def character_value(single, even_subgraph):
    single_h, single_v = subset_winding_parities(single)
    subgraph_h, subgraph_v = subset_winding_parities(even_subgraph)
    return ZZ(-1) ** (single_h * subgraph_v + single_v * subgraph_h)


trivial_nonempty_fibers = ZZ(0)
comparisons = ZZ(0)
rank_distribution = {}
magnitude_distribution = {}

for (doubled, single), fiber in all_fibers.items():
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    inside = even_subgraphs_inside(single)
    vertex_count, component_count = nonempty_vertex_and_component_counts(single)
    cycle_rank = ZZ(len(single)) - vertex_count + component_count

    character_is_trivial = all(character_value(single, item) == 1
                               for item in inside)
    if not selectors or not character_is_trivial:
        continue

    trivial_nonempty_fibers += 1
    rank_distribution[cycle_rank] = rank_distribution.get(cycle_rank, 0) + 1
    expected_magnitude = ZZ(2) ** cycle_rank
    magnitude_distribution[expected_magnitude] = (
        magnitude_distribution.get(expected_magnitude, 0) + 1)

    for a in (0, 1):
        for b in (0, 1):
            fiber_phase_sum = sum(
                (contributions[permutation_key(phi)][(a, b)] for phi in fiber),
                K8(0),
            )
            signed_selection_sum = sum(
                (
                    signed_even_subgraph_weight(a, b,
                                                doubled.union(selected))
                    * signed_even_subgraph_weight(
                        a, b, doubled.union(single.difference(selected)))
                    for selected in selectors
                ),
                ZZ(0),
            )
            comparisons += 1
