"""標準形の四寄与が巻き付き偶奇と交差対だけでは決まらないことを検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

各辺連結成分の最小辺の向きを 0 に固定した標準形について、偶奇恒等式の
左辺を動辺数・内部辺対・切断線辺対・局所位相へ分ける。巻き付き偶奇と
交差対の三つ組が同じ二つの鍵でも、四寄与の組が異なる反例を探す。
一方、四寄与の総和は三つ組から定まる標的と常に一致することも検査する。

有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使い、浮動小数点は
使わない。
"""

load("sagemath/check/parity-identity-standard-contributions-not-topological/construction.sage")

patterns_by_side = {2: {}, 3: {}}

for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    if not selectors or not character_is_trivial_general(2, single):
        continue
    selector = min(selectors, key=lambda item: tuple(sorted(item)))
    topology, pieces = standard_pattern(2, doubled, single, selector)
    patterns_by_side[2].setdefault(topology, set()).add(pieces)

for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    if not curved_free_orientations(3, single):
        continue
    topology, pieces = standard_pattern(
        3, frozenset(), single, frozenset())
    patterns_by_side[3].setdefault(topology, set()).add(pieces)

colliding_classes = {
    side: sum(ZZ(len(patterns) > 1)
              for patterns in patterns_by_side[side].values())
    for side in (2, 3)
}
distinct_patterns = {
    side: len(set().union(*patterns_by_side[side].values()))
    for side in (2, 3)
}

assert colliding_classes[2] == 7
assert colliding_classes[3] == 4
assert distinct_patterns[2] == 8
assert distinct_patterns[3] == 12

print("PASS: 標準形の四寄与は巻き付き偶奇と交差対だけでは個別に決まらない"
      "（同じ三つ組で複数の四寄与を持つ類: 一辺二 %d 類、一辺三 %d 類。"
      "四寄与の異なる組: 一辺二 %d 種類、一辺三 %d 種類）"
      % (colliding_classes[2], colliding_classes[3],
         distinct_patterns[2], distinct_patterns[3]))
