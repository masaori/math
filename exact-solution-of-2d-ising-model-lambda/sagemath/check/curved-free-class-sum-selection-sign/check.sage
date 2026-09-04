"""曲がり型なし配向類の局所行列式和の符号を選択和の共通符号へ同定する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

自明文字で選択集合が非空な鍵 (D,E) について、曲がり型なし均衡配向を
置換の列挙に頼らず局所決定性の伝播で構成し、各配向類の位相和を既に
分解済みの局所遷移行列式の積の公式で計算する。検査するのは

  (1) 構成した配向の集合が、成分ごとの向きの選び方 2^c(E) 個をちょうど尽くし、
      一辺二では置換ファイバーが誘導する曲がり型なし配向の集合に一致すること、
  (2) 選択和の各項 w(D∪C)·w(D∪(E\C)) が全て同じ符号を持つこと、
  (3) 全ての曲がり型なし配向類の局所行列式和が、四つのねじれそれぞれで
      共通符号 × 2^{n_4(E)} という同一の値になること（成分反転で不変）、

である。一辺二では全ての置換ファイバー鍵、一辺三では D が空の自明文字鍵の
全数で検査する。一辺三では、非空偶部分グラフで曲がり型なし配向が存在する
ことと文字が自明なことの同値も全数で照合する。有限集合、F_2、整数、
Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/trivial-character-orientation-local-factor/check.sage")


def base_edges_of_side(side):
    return [(kind, i, j) for kind in ("h", "v")
            for i in range(side) for j in range(side)]


def base_endpoints(side, base):
    return endpoints(side, base + (0,))


def base_seam_parities(side, base):
    kind, i, j = base
    return (ZZ(kind == "h" and j == side - 1),
            ZZ(kind == "v" and i == side - 1))


def subset_parities(side, subset):
    return (sum(base_seam_parities(side, base)[0] for base in subset) % 2,
            sum(base_seam_parities(side, base)[1] for base in subset) % 2)


def signed_weight(side, a, b, subset):
    horizontal, vertical = subset_parities(side, subset)
    exponent = ((1 + a) * horizontal + (1 + b) * vertical
                + horizontal * vertical)
    return ZZ(-1) ** exponent


def edge_components(side, chosen):
    remaining = set(chosen)
    result = []
    while remaining:
        stack = [min(remaining)]
        component = set()
        while stack:
            base = stack.pop()
            if base in component:
                continue
            component.add(base)
            ends = set(base_endpoints(side, base))
            for other in remaining:
                if other not in component and ends & set(base_endpoints(side, other)):
                    stack.append(other)
        remaining -= component
        result.append(frozenset(component))
    return sorted(result, key=lambda item: tuple(sorted(item)))


def fundamental_cycles(side, chosen):
    vertices = sorted({vertex for base in chosen
                       for vertex in base_endpoints(side, base)})
    parent = {vertex: vertex for vertex in vertices}

    def root(vertex):
        while parent[vertex] != vertex:
            vertex = parent[vertex]
        return vertex

    tree_edges = []
    cotree_edges = []
    for base in sorted(chosen):
        tail, head = base_endpoints(side, base)
        tail_root, head_root = root(tail), root(head)
        if tail_root == head_root:
            cotree_edges.append(base)
        else:
            parent[head_root] = tail_root
            tree_edges.append(base)
    adjacency = {vertex: [] for vertex in vertices}
    for base in tree_edges:
        tail, head = base_endpoints(side, base)
        adjacency[tail].append((head, base))
        adjacency[head].append((tail, base))
    result = []
    for closing_edge in cotree_edges:
        start, target = base_endpoints(side, closing_edge)
        stack = [(start, None, [])]
        while stack:
            vertex, previous, used = stack.pop()
            if vertex == target:
                result.append(frozenset(used + [closing_edge]))
                break
            for neighbor, base in sorted(adjacency[vertex], reverse=True):
                if neighbor != previous:
                    stack.append((neighbor, vertex, used + [base]))
    return result


def character_is_trivial_general(side, single):
    single_h, single_v = subset_parities(side, single)
    for cycle in fundamental_cycles(side, single):
        cycle_h, cycle_v = subset_parities(side, cycle)
        if (single_h * cycle_v + single_v * cycle_h) % 2 == 1:
            return False
    return True


def vertex_status(side, base, d, vertex):
    tail, head = endpoints(side, base + (d,))
    assert vertex in (tail, head)
    return "in" if head == vertex else "out"


def d_for_status(side, base, vertex, status):
    for d in (0, 1):
        if vertex_status(side, base, d, vertex) == status:
            return d
    raise AssertionError


def component_curved_free_orientations(side, component):
    """局所決定性の伝播で成分の曲がり型なし均衡配向を構成する（0 個か 2 個）。"""
    incident = {}
    for base in component:
        for vertex in base_endpoints(side, base):
            incident.setdefault(vertex, []).append(base)
    for bases in incident.values():
        assert len(bases) in (2, 4)

    results = []
    start = min(component)
    for d0 in (0, 1):
        orientation = {start: d0}
        stack = [start]
        consistent = True
        while stack and consistent:
            base = stack.pop()
            d = orientation[base]
            for vertex in base_endpoints(side, base):
                status = vertex_status(side, base, d, vertex)
                bases = incident[vertex]
                if len(bases) == 2:
                    required = {other: ("out" if status == "in" else "in")
                                for other in bases if other != base}
                else:
                    kind = base[0]
                    required = {}
                    for other in bases:
                        if other == base:
                            continue
                        same_axis = other[0] == kind
                        required[other] = status if same_axis else (
                            "out" if status == "in" else "in")
                for other, needed in required.items():
                    d_other = d_for_status(side, other, vertex, needed)
                    if other in orientation:
                        if orientation[other] != d_other:
                            consistent = False
                            break
                    else:
                        orientation[other] = d_other
                        stack.append(other)
                if not consistent:
                    break
        if consistent:
            assert set(orientation) == set(component)
            results.append(orientation)
    if len(results) == 2:
        assert all(results[0][base] != results[1][base] for base in component)
    return results


def curved_free_orientations(side, single):
    components = edge_components(side, single)
    per_component = [component_curved_free_orientations(side, component)
                     for component in components]
    if any(not choices for choices in per_component):
        return []
    result = [{}]
    for choices in per_component:
        result = [{**partial, **choice}
                  for partial in result for choice in choices]
    assert len(result) == ZZ(2) ** len(components)
    return result


def ordering_sign_general(items, reordered):
    positions = {item: index for index, item in enumerate(items)}
    sequence = [positions[item] for item in reordered]
    inversions = sum(
        ZZ(sequence[left] > sequence[right])
        for left in range(len(sequence))
        for right in range(left + 1, len(sequence))
    )
    return ZZ(-1) ** inversions


def local_determinant_product_general(side, moved, a, b):
    ordered = sorted(moved)
    moved_vertices = sorted({endpoints(side, edge)[0] for edge in ordered})
    row_order = sorted(ordered, key=lambda edge: (endpoints(side, edge)[1], edge))
    column_order = sorted(ordered, key=lambda edge: (endpoints(side, edge)[0], edge))
    row_sign = ordering_sign_general(ordered, row_order)
    column_sign = ordering_sign_general(ordered, column_order)
    product_value = K8(1)
    for vertex in moved_vertices:
        incoming = [edge for edge in row_order
                    if endpoints(side, edge)[1] == vertex]
        outgoing = [edge for edge in column_order
                    if endpoints(side, edge)[0] == vertex]
        assert len(incoming) == len(outgoing)
        local_matrix = matrix(K8, [
            [K8(transition_entry(side, a, b, edge, successor))
             for successor in outgoing]
            for edge in incoming
        ])
        product_value *= local_matrix.det()
    return K8(row_sign * column_sign) * product_value


def class_sum_by_local_formula(side, doubled, single, orientation, a, b):
    moved = frozenset(
        [base + (d,) for base in doubled for d in (0, 1)]
        + [base + (orientation[base],) for base in single])
    return (K8((-1) ** len(moved))
            * local_determinant_product_general(side, moved, a, b))


def degree_four_count(side, single):
    counts = {}
    for base in single:
        for vertex in base_endpoints(side, base):
            counts[vertex] = counts.get(vertex, 0) + 1
    assert all(count in (2, 4) for count in counts.values())
    return ZZ(sum(1 for count in counts.values() if count == 4))


# --- 一辺二: 全ての置換ファイバー鍵で、構成した配向と類和の符号を検査する ---

fiber_keys = ZZ(0)
orientation_value_checks_two = ZZ(0)
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    inside = even_subgraphs_inside(single)
    character_trivial = all(character_value(single, item) == 1
                            for item in inside)
    assert character_trivial == character_is_trivial_general(2, single)
    if not selectors or not character_trivial:
        continue

    constructed = curved_free_orientations(2, single)
    induced_curved_free = set()
    for phi in fiber:
        orientation = induced_orientation(phi, single)
        curved, straight = local_vertex_counts(single, orientation)
        if curved == 0:
            induced_curved_free.add(tuple(sorted(orientation.items())))
    assert {tuple(sorted(item.items())) for item in constructed} \
        == induced_curved_free

    n_four = degree_four_count(2, single) if single else ZZ(0)
    for a in (0, 1):
        for b in (0, 1):
            terms = [
                signed_even_subgraph_weight(a, b, doubled.union(selected))
                * signed_even_subgraph_weight(
                    a, b, doubled.union(single.difference(selected)))
                for selected in selectors
            ]
            common_sign = terms[0]
            assert all(term == common_sign for term in terms)
            for orientation in constructed:
                value = class_sum_by_local_formula(
                    2, doubled, single, orientation, a, b)
                assert value == K8(common_sign * ZZ(2) ** n_four)
                orientation_value_checks_two += 1
    fiber_keys += 1

assert fiber_keys == 369
print("PASS: L=2 の自明文字・選択非空 %d 鍵で、伝播構成した曲がり型なし配向が"
      "ファイバー誘導の配向と一致し、局所行列式和が共通符号×2^n4 になること"
      "を %d 件検査" % (fiber_keys, orientation_value_checks_two))

# --- 一辺三: D が空の全ての自明文字鍵で同じ同定を検査する ---

def is_even_subset_general(side, subset):
    degrees = {}
    for base in subset:
        for vertex in base_endpoints(side, base):
            degrees[vertex] = degrees.get(vertex, 0) + 1
    return all(count % 2 == 0 for count in degrees.values())


three_bases = frozenset(base_edges_of_side(3))
even_subgraphs_three = [
    frozenset(subset) for subset in Subsets(three_bases)
    if is_even_subset_general(3, subset)
]
assert len(even_subgraphs_three) == 1024

trivial_nonempty_three = ZZ(0)
orientation_value_checks_three = ZZ(0)
selector_sign_checks_three = ZZ(0)
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single:
        continue
    trivial = character_is_trivial_general(3, single)
    constructed = curved_free_orientations(3, single)
    assert trivial == bool(constructed)
    if not trivial:
        continue
    trivial_nonempty_three += 1

    components = edge_components(3, single)
    cycles = fundamental_cycles(3, single)
    n_four = degree_four_count(3, single)
    vertex_count = ZZ(len({vertex for base in single
                           for vertex in base_endpoints(3, base)}))
    rank = ZZ(len(single)) - vertex_count + ZZ(len(components))
    assert rank == ZZ(len(components)) + n_four
    assert ZZ(len(cycles)) == rank

    selectors_three = set()
    for coefficients in cartesian_product([(0, 1)] * len(cycles)):
        selected = set()
        for coefficient, cycle in zip(coefficients, cycles):
            if coefficient:
                selected.symmetric_difference_update(cycle)
        selectors_three.add(frozenset(selected))
    assert len(selectors_three) == ZZ(2) ** len(cycles)

    for a in (0, 1):
        for b in (0, 1):
            terms = [
                signed_weight(3, a, b, selected)
                * signed_weight(3, a, b, single.difference(selected))
                for selected in sorted(selectors_three,
                                       key=lambda item: tuple(sorted(item)))
            ]
            common_sign = terms[0]
            assert all(term == common_sign for term in terms)
            selector_sign_checks_three += len(terms)
            for orientation in constructed:
                value = class_sum_by_local_formula(
                    3, frozenset(), single, orientation, a, b)
                assert value == K8(common_sign * ZZ(2) ** n_four)
                orientation_value_checks_three += 1

assert trivial_nonempty_three == 677
print("PASS: L=3 の D=∅・自明文字 %d 鍵で、曲がり型なし配向の存在と文字の自明性"
      "の同値、選択項の符号の一様性（%d 項）、局所行列式和 = 共通符号×2^n4"
      "（%d 件）を検査" % (trivial_nonempty_three, selector_sign_checks_three,
                          orientation_value_checks_three))
