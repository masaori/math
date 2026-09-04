"""生成森座標を生の置換へ持ち上げる対応が符号を保存しないことを検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

曲がり型なし均衡配向を誘導する各置換から、直進型頂点での左折・右折を
読み取り、成分指示元を先頭に置いた Kruskal 基本閉路基底の係数へ移す。
得られた巡回空間の元を辞書式最小の選択集合へ対称差で加える対応は、生の
置換ごとには符号を保存しない。従って一般証明は、局所行列式の展開前の
置換ではなく、相殺を済ませた配向類の局所行列式和を単位に組む必要がある。
"""

load("sagemath/check/curved-free-selection-spanning-forest-coordinates/check.sage")
load("sagemath/check/curved-free-selection-separated-bit-bijection/check.sage")


def graph_endpoints(edge, side):
    kind, i, j = edge
    if kind == "h":
        return (i, j), (i, (j + 1) % side)
    assert kind == "v"
    return (i, j), ((i + 1) % side, j)


def graph_components(chosen, side):
    remaining = set(chosen)
    result = []
    while remaining:
        stack = [min(remaining)]
        component = set()
        while stack:
            edge = stack.pop()
            if edge in component:
                continue
            component.add(edge)
            ends = graph_endpoints(edge, side)
            for other in remaining:
                if other not in component and set(graph_endpoints(other, side)) & set(ends):
                    stack.append(other)
        remaining -= component
        result.append(frozenset(component))
    return sorted(result, key=lambda item: tuple(sorted(item)))


def graph_fundamental_cycles(chosen, side):
    vertices = sorted({vertex for edge in chosen for vertex in graph_endpoints(edge, side)})
    parent = {vertex: vertex for vertex in vertices}

    def root(vertex):
        while parent[vertex] != vertex:
            vertex = parent[vertex]
        return vertex

    tree_edges = []
    cotree_edges = []
    for edge in sorted(chosen):
        tail, head = graph_endpoints(edge, side)
        tail_root, head_root = root(tail), root(head)
        if tail_root == head_root:
            cotree_edges.append(edge)
        else:
            parent[head_root] = tail_root
            tree_edges.append(edge)
    adjacency = {vertex: [] for vertex in vertices}
    for edge in tree_edges:
        tail, head = graph_endpoints(edge, side)
        adjacency[tail].append((head, edge))
        adjacency[head].append((tail, edge))
    result = []
    for closing_edge in cotree_edges:
        start, target = graph_endpoints(closing_edge, side)
        stack = [(start, None, [])]
        while stack:
            vertex, previous, used = stack.pop()
            if vertex == target:
                result.append(frozenset(used + [closing_edge]))
                break
            for neighbor, edge in sorted(adjacency[vertex], reverse=True):
                if neighbor != previous:
                    stack.append((neighbor, vertex, used + [edge]))
    return result


def graph_basis(chosen, side):
    edge_order = sorted(chosen)
    components = graph_components(chosen, side)
    basis = list(components)
    rows = [vector(GF(2), [edge in item for edge in edge_order]) for item in basis]
    rank = ZZ(matrix(GF(2), rows).rank()) if rows else ZZ(0)
    for cycle in graph_fundamental_cycles(chosen, side):
        row = vector(GF(2), [edge in cycle for edge in edge_order])
        candidate = ZZ(matrix(GF(2), rows + [row]).rank())
        if candidate > rank:
            basis.append(cycle)
            rows.append(row)
            rank = candidate
    return components, basis, rank


def local_left_vertices(phi, single, orientation):
    """置換が直進型頂点で選ぶ二つの局所遷移のうち左折側を返す。"""
    result = []
    for vertex in straight_vertices(single, orientation):
        incoming = [edge for edge in moved_edges(phi)
                    if endpoints(L, edge)[1] == vertex]
        assert len(incoming) == 2
        turns = {(direction(phi[edge]) - direction(edge)) % 4
                 for edge in incoming}
        assert turns in ({1}, {3})
        if turns == {1}:
            result.append(vertex)
    return frozenset(result)


def combination(basis, coefficients):
    result = set()
    for coefficient, item in zip(coefficients, basis):
        if coefficient:
            result.symmetric_difference_update(item)
    return frozenset(result)


checks = ZZ(0)
mismatches = []
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

    components, basis, rank = graph_basis(single, 2)
    degree_four = sorted(
        vertex for vertex in {(row, column) for row in range(2) for column in range(2)}
        if sum(1 for edge in single if vertex in graph_endpoints(edge, 2)) == 4)
    baseline = min(selectors, key=lambda item: tuple(sorted(item)))
    for phi in fiber:
        orientation = induced_orientation(phi, single)
        curved, straight = local_vertex_counts(single, orientation)
        if curved:
            continue
        left = local_left_vertices(phi, single, orientation)
        coefficients = [orientation[min(component)] for component in components]
        coefficients += [1 if vertex in left else 0 for vertex in degree_four]
        assert len(coefficients) == rank == len(basis)
        cycle_item = combination(basis, coefficients)
        selected = frozenset(baseline.symmetric_difference(cycle_item))
        assert selected in selectors
        for a in (0, 1):
            for b in (0, 1):
                phase = contributions[permutation_key(phi)][(a, b)]
                selection = (
                    signed_even_subgraph_weight(a, b, doubled.union(selected))
                    * signed_even_subgraph_weight(
                        a, b, doubled.union(single.difference(selected)))
                )
                checks += 1
                if phase != K8(selection):
                    mismatches.append((doubled, single, a, b, phase, selection))

assert checks == 74496
assert len(mismatches) == 35712
print("PASS: L=2 の生成森座標を生の置換へ持ち上げた符号比較 %d 件中、"
      "%d 件が不一致。置換ごとの符号保存ではなく配向類の局所行列式和が必要" %
      (checks, len(mismatches)))
