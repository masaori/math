"""標準形の四寄与を鍵の幾何統計の F_2 線型式で表せるかを探索する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/parity-identity-standard-contributions-not-topological/construction.sage")

def statistics_vector(side, doubled, single, selector):
    """鍵から機械的に計算できる F_2 統計の候補基底を返す。"""
    epsilon_h, epsilon_v = subset_parities(side, single)
    union_h, union_v = subset_parities(side, doubled.union(selector))
    crossing = (union_h * epsilon_v + epsilon_h * union_v) % 2
    doubled_h, doubled_v = subset_parities(side, doubled)
    components = single_edge_components(side, single)
    vertices = set()
    for base in single:
        vertices.update(base_endpoints(side, base))
    size_parity = ZZ(len(single)) % 2
    vertex_parity = ZZ(len(vertices)) % 2
    quartic_parity = (ZZ(len(single)) - ZZ(len(vertices))) % 2
    component_parity = ZZ(len(components)) % 2
    doubled_parity = ZZ(len(doubled)) % 2
    names = [
        "1", "|E|", "|D|", "eps_h(E)", "eps_v(E)", "eps_h*eps_v",
        "<DuC0,E>", "eps_h(D)", "eps_v(D)", "c(E)", "|V(E)|", "n4(E)",
        "|E|*eps_h(E)", "|E|*eps_v(E)", "|E|*<DuC0,E>",
    ]
    values = [
        ZZ(1), size_parity, doubled_parity, epsilon_h, epsilon_v,
        (epsilon_h * epsilon_v) % 2,
        crossing, doubled_h, doubled_v, component_parity, vertex_parity,
        quartic_parity,
        (size_parity * epsilon_h) % 2, (size_parity * epsilon_v) % 2,
        (size_parity * crossing) % 2,
    ]
    return names, values


rows = []
piece_columns = []
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    if not selectors or not character_is_trivial_general(2, single):
        continue
    selector = min(selectors, key=lambda item: tuple(sorted(item)))
    _, pieces = standard_pattern(2, doubled, single, selector)
    names, values = statistics_vector(2, doubled, single, selector)
    rows.append(values)
    piece_columns.append(pieces)

for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    if not curved_free_orientations(3, single):
        continue
    _, pieces = standard_pattern(3, frozenset(), single, frozenset())
    names, values = statistics_vector(3, frozenset(), single, frozenset())
    rows.append(values)
    piece_columns.append(pieces)
