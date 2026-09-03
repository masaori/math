"""配向差と直進頂点の選択ビットを分けた一辺二の全単射を検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

前のトレイル台写像は、全辺ファイバーで四つの局所選択ビットの奇偶を
失った。この検査では、直進型頂点を持たない 368 ファイバーでは前の
トレイル台写像をそのまま使い、唯一の全辺ファイバーでは次の情報を
別々の座標として保つ。

  - 辞書式順序で二つある曲がり型なし均衡配向のどちらかを表す 1 ビット。
  - 四つの直進型頂点が局所選択集合に属するかを表す 4 ビット。

E の F_2 巡回空間では、辞書式順序で最初に階数を増やす元を順に取って
決定的な基底を作る。この五つのビットを基底係数とし、得た巡回空間の
元を辞書式最小の選択集合へ対称差で足して選択集合へ写す。

これは一辺二の全 369 ファイバーで定義された全単射を与える。ただし、
全辺ファイバーでの座標化は有限列挙の辞書式順序に依存する。一般の辺長
では、配向差と局所選択ビットから基底係数を列挙に頼らず取り出す規則が
まだ必要である。有限集合、F_2、整数の厳密演算だけを使い、浮動小数点は
使わない。
"""

load("sagemath/check/curved-free-selection-trail-map-counterexample/check.sage")


def edge_indicator(edge_subset):
    return vector(GF(2), [1 if edge in edge_subset else 0
                          for edge in base_edge_set])


def deterministic_cycle_basis(cycle_space):
    basis_subsets = []
    basis_vectors = []
    current_rank = ZZ(0)
    for item in sorted(cycle_space, key=lambda subset: tuple(sorted(subset))):
        item_vector = edge_indicator(item)
        candidate_rank = matrix(GF(2), basis_vectors + [item_vector]).rank()
        if candidate_rank > current_rank:
            basis_subsets.append(item)
            basis_vectors.append(item_vector)
            current_rank = ZZ(candidate_rank)
    assert current_rank == ZZ(len(cycle_space)).valuation(2)
    return basis_subsets


def basis_linear_combination(basis, coefficients):
    result = set()
    for coefficient, item in zip(coefficients, basis):
        if coefficient == 1:
            result.symmetric_difference_update(item)
    return frozenset(result)


fiber_checks = ZZ(0)
pair_checks = ZZ(0)
ordinary_fibers = ZZ(0)
separated_bit_fibers = ZZ(0)

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

    cycle_space = frozenset(frozenset(item) for item in inside)
    basis = deterministic_cycle_basis(cycle_space)
    baseline_selector = min(selectors, key=lambda item: tuple(sorted(item)))

    classes = {}
    for phi in fiber:
        orientation_key = tuple(sorted(induced_orientation(phi, single).items()))
        classes.setdefault(orientation_key, []).append(phi)

    curved_free_data = []
    for orientation_key in sorted(classes):
        orientation = dict(orientation_key)
        curved, straight = local_vertex_counts(single, orientation)
        if curved == 0:
            straight_list = straight_vertices(single, orientation)
            assert ZZ(len(straight_list)) == straight
            curved_free_data.append((orientation_key, orientation, straight_list))

    images = {}
    if all(len(straight_list) == 0
           for _, _, straight_list in curved_free_data):
        for orientation_key, orientation, _ in curved_free_data:
            cycle_item, _ = selected_union(single, orientation, set())
            image = frozenset(baseline_selector.symmetric_difference(cycle_item))
            assert image in selectors
            images.setdefault(image, []).append((orientation_key, frozenset()))
            pair_checks += 1
        ordinary_fibers += 1
    else:
        assert doubled == frozenset()
        assert single == frozenset(base_edge_set)
        assert len(curved_free_data) == 2
        assert len(basis) == 5
        common_vertices = curved_free_data[0][2]
        assert len(common_vertices) == 4
        assert all(straight_list == common_vertices
                   for _, _, straight_list in curved_free_data)
        for orientation_bit, (orientation_key, _, straight_list) in enumerate(
                curved_free_data):
            for size in range(len(straight_list) + 1):
                for chosen in Subsets(straight_list, size):
                    chosen_set = frozenset(chosen)
                    coefficients = [GF(2)(orientation_bit)] + [
                        GF(2)(1 if vertex in chosen_set else 0)
                        for vertex in common_vertices
                    ]
                    cycle_item = basis_linear_combination(basis, coefficients)
                    image = frozenset(
                        baseline_selector.symmetric_difference(cycle_item))
                    assert image in selectors
                    images.setdefault(image, []).append(
                        (orientation_key, chosen_set))
                    pair_checks += 1
        separated_bit_fibers += 1

    assert frozenset(images) == frozenset(selectors)
    assert all(len(preimages) == 1 for preimages in images.values())
    fiber_checks += 1

assert ordinary_fibers == 368
assert separated_bit_fibers == 1
assert fiber_checks == 369
assert pair_checks == 768
print("PASS: L=%d の自明文字・選択非空 %d ファイバーで、配向と局所選択を"
      "分けた対応が選択集合への全単射（通常 %d、全辺の分離ビット %d、対 %d 件）" %
      (L, fiber_checks, ordinary_fibers, separated_bit_fibers, pair_checks))
