"""自明文字ファイバーの共通絶対値を巡回階数で記述し、一辺二で検査する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

選択集合が非空で文字が自明なら、選択和の絶対値は E に含まれる偶部分グラフの
個数である。この個数が、E の非孤立頂点数を |V(E)|、非空連結成分数を c(E) として
2^(|E|-|V(E)|+c(E)) に等しいことを検査する。既存の一辺二のファイバー等式と合わせ、
置換側の位相和も同じ絶対値を持つことを全ファイバー・四ねじれで固定する。
有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/trivial-character-fiber-magnitude/construction.sage")

for (doubled, single), fiber in all_fibers.items():
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    inside = even_subgraphs_inside(single)
    vertex_count, component_count = nonempty_vertex_and_component_counts(single)
    cycle_rank = ZZ(len(single)) - vertex_count + component_count
    assert cycle_rank >= 0
    assert len(inside) == 2 ** cycle_rank

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
            assert abs(signed_selection_sum) == expected_magnitude
            assert fiber_phase_sum == K8(signed_selection_sum)
            comparisons += 1

print("L=2: trivial-character nonempty fibers %d, rank distribution %s, "
      "magnitude distribution %s" %
      (trivial_nonempty_fibers, rank_distribution, magnitude_distribution))
assert trivial_nonempty_fibers == 369
assert comparisons == 1476
assert rank_distribution == {ZZ(0): 32, ZZ(1): 320, ZZ(2): 16, ZZ(5): 1}
assert magnitude_distribution == {ZZ(1): 32, ZZ(2): 320, ZZ(4): 16,
                                  ZZ(32): 1}
print("PASS: K と U の絶対値 2^(|E|-|V(E)|+c(E)) を %d 件検査" % comparisons)
