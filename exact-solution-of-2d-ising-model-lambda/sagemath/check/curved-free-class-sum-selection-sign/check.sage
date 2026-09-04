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

load("sagemath/check/curved-free-class-sum-selection-sign/construction.sage")

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
assert len(even_subgraphs_three) == 1024
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
