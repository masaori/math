"""偶奇恒等式を標準形配向での評価へ帰着できることを検査する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

各辺連結成分の最小辺の向きを 0 に固定した曲がり型なし均衡配向を
標準形と呼ぶ。全反転対の定理から標準形は各鍵で一意に存在する。
任意の曲がり型なし均衡配向は、標準形と不一致な辺集合が成分の合併で
あり、その成分を一つずつ全反転する列で標準形へ到達する。成分反転は
偶奇恒等式の左辺を変えない（相殺の検算で固定済み）ので、恒等式の
成立は標準形での評価

  動辺数 + 内部辺対 + 切断線辺対 + 局所位相
  = ε_h(E) + ε_v(E) + ε_h(E)ε_v(E) + <D∪C_0, E>  (mod 2)

へ帰着する。本検算は一辺二の全対象と一辺三の D=empty の自明文字対象
について、標準形の一意存在・差集合の成分合併性・反転列の到達・
標準形での恒等式の成立を検査する。有限集合、F_2、整数、Q(zeta_8) の
厳密演算だけを使い、浮動小数点は使わない。
"""

load("sagemath/check/parity-identity-standard-orientation-reduction/construction.sage")


def check_standard_reduction(side, doubled, single, selector):
    orientations = curved_free_orientations(side, single)
    standard, components = standard_orientation(side, single, orientations)

    _, standard_total = pair_and_seam_decomposition(
        side, doubled, single, standard)
    assert standard_total == target_exponent(side, doubled, single, selector)

    reductions = ZZ(0)
    for orientation in orientations:
        difference = frozenset(
            edge for edge in single if orientation[edge] != standard[edge])
        touched = [
            component for component in components
            if difference.intersection(component)
        ]
        assert all(component.issubset(difference) for component in touched)
        assert frozenset().union(*touched) == difference if touched \
            else difference == frozenset()

        current = orientation
        for component in touched:
            current = reverse_component(current, component)
            assert current in orientations
        assert current == standard
        reductions += 1
    return reductions


checks_two = ZZ(0)
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    if not selectors or not character_is_trivial_general(2, single):
        continue
    selector = min(selectors, key=lambda item: tuple(sorted(item)))
    checks_two += check_standard_reduction(2, doubled, single, selector)

checks_three = ZZ(0)
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    if not curved_free_orientations(3, single):
        continue
    checks_three += check_standard_reduction(3, frozenset(), single, frozenset())

assert checks_two > 0 and checks_three > 0
print("PASS: 偶奇恒等式を標準形配向での評価へ帰着"
      "（一辺二 %d 配向、一辺三 %d 配向を標準形へ還元）"
      % (checks_two, checks_three))
