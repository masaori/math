"""全候補列挙を使わない巡回空間座標を一辺二・一辺三で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

各連結成分の辺指示元を先頭に置き、辞書式 Kruskal 森から得る基本閉路を
順に加えて基底を延長する。残った n4 本へ、辞書式順の次数 4 頂点の
局所選択ビットを一対一に割り当てる。この規則は巡回空間の元の列挙を
使わない。有限集合、F_2、整数の厳密演算だけを使う。
"""

load("sagemath/check/curved-free-orientation-component-structure/check.sage")


def endpoints(edge, side):
    i, j, direction = edge
    if direction == 0:
        return (i, j), (i, (j + 1) % side)
    return (i, j), ((i + 1) % side, j)


def indicator(edge_subset, edge_order):
    return vector(GF(2), [edge in edge_subset for edge in edge_order])


def fundamental_cycles(chosen, side):
    """辞書式 Kruskal 森の非森辺が定める基本閉路を返す。"""
    vertices = sorted({vertex for edge in chosen for vertex in endpoints(edge, side)})
    parent = {vertex: vertex for vertex in vertices}

    def root(vertex):
        while parent[vertex] != vertex:
            vertex = parent[vertex]
        return vertex

    tree_edges = []
    cotree_edges = []
    for edge in sorted(chosen):
        tail, head = endpoints(edge, side)
        tail_root = root(tail)
        head_root = root(head)
        if tail_root == head_root:
            cotree_edges.append(edge)
        else:
            parent[head_root] = tail_root
            tree_edges.append(edge)

    adjacency = {vertex: [] for vertex in vertices}
    for edge in tree_edges:
        tail, head = endpoints(edge, side)
        adjacency[tail].append((head, edge))
        adjacency[head].append((tail, edge))

    cycles = []
    for closing_edge in cotree_edges:
        start, target = endpoints(closing_edge, side)
        stack = [(start, None, [])]
        path = None
        while stack:
            vertex, previous, used_edges = stack.pop()
            if vertex == target:
                path = used_edges
                break
            for neighbor, edge in sorted(adjacency[vertex], reverse=True):
                if neighbor != previous:
                    stack.append((neighbor, vertex, used_edges + [edge]))
        assert path is not None
        cycles.append(frozenset(path + [closing_edge]))
    return cycles


def component_first_basis(chosen, incidence, side):
    """成分指示元を保ったまま、基本閉路で決定的に基底を延長する。"""
    edge_order = sorted(chosen)
    components = sorted(edge_components(chosen, incidence),
                        key=lambda item: tuple(sorted(item)))
    basis = [frozenset(component) for component in components]
    rows = [indicator(item, edge_order) for item in basis]
    rank = ZZ(matrix(GF(2), rows).rank()) if rows else ZZ(0)
    for cycle in fundamental_cycles(chosen, side):
        vector_cycle = indicator(cycle, edge_order)
        candidate_rank = ZZ(matrix(GF(2), rows + [vector_cycle]).rank())
        if candidate_rank > rank:
            basis.append(cycle)
            rows.append(vector_cycle)
            rank = candidate_rank
    return edge_order, components, basis, rank


for L_side in (2, 3):
    edge_list, incidence = build_torus(L_side)
    all_even = even_subgraphs(edge_list, incidence)
    checked = ZZ(0)
    coordinate_pairs = ZZ(0)
    for chosen in all_even:
        if not chosen:
            continue
        edge_order, components, basis, rank = component_first_basis(
            chosen, incidence, L_side)
        touched = [vertex for vertex, slots in incidence.items()
                   if any(edge in chosen for edge, _, _ in slots)]
        degree_four = sorted(
            vertex for vertex in touched
            if sum(1 for edge, _, _ in incidence[vertex] if edge in chosen) == 4)
        n4 = ZZ(len(degree_four))
        c_count = ZZ(len(components))

        # 基本閉路は巡回空間の基底であり、成分指示元を先頭に保った延長も全階数を持つ。
        expected_rank = ZZ(len(chosen)) - ZZ(len(touched)) + c_count
        assert rank == expected_rank == c_count + n4
        assert len(basis) == expected_rank
        for item in basis:
            assert all(sum(1 for edge, _, _ in incidence[vertex] if edge in item) % 2 == 0
                       for vertex in incidence)

        # 各成分の二配向は最小辺の向きで 0/1 を直接取り出せる。
        all_components_have_pair = True
        for component in components:
            component_edges, found = curved_free_orientations(component, incidence)
            if len(found) != 2:
                all_components_have_pair = False
                break
            least_edge_index = component_edges.index(min(component_edges))
            extracted_bits = {(mask >> least_edge_index) & 1 for mask in found}
            assert extracted_bits == {0, 1}

        if all_components_have_pair:
            # 前半 c 座標は成分反転、後半 n4 座標は局所選択で、全係数列を一度ずつ尽くす。
            images = set()
            for mask in range(2 ** (c_count + n4)):
                coefficients = [(mask >> index) & 1 for index in range(c_count + n4)]
                image = vector(GF(2), len(edge_order))
                for coefficient, item in zip(coefficients, basis):
                    if coefficient:
                        image += indicator(item, edge_order)
                images.add(tuple(image))
            assert len(images) == 2 ** expected_rank
            coordinate_pairs += 2 ** expected_rank
            checked += 1

    if L_side == 2:
        assert checked == 23 and coordinate_pairs == 80
    else:
        assert checked == 677 and coordinate_pairs == 3136
    print("PASS: L=%d の曲がり型なし配向を持つ非空偶部分グラフ %d 個で、"
          "成分指示元を先頭に固定した Kruskal 基本閉路基底と c+n4 座標を検査"
          "（係数列 %d 件）" % (L_side, checked, coordinate_pairs))
