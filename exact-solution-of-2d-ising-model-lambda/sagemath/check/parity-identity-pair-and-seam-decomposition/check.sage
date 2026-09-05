"""偶奇恒等式の二つの並べ替え符号を辺対と切断線の寄与へ分解する。

対象: claim_kac_ward_determinant_fiber_stratified_phase_sum。

動辺の固定順序を e_1<...<e_m とする。終点別の行順序の反転数は
各対 e_i<e_j について終点別の鍵の順序が逆転する指示値の和であり、
始点別の列順序も同様である。各対を、少なくとも一方が基本領域の
水平または垂直の切断線を通る「切断線対」と、それ以外の「内部対」へ
分ける。局所位相 q は全頂点の局所行列式の積から従来どおり求める。

これにより左辺は、動辺数、内部の辺対、切断線の辺対、局所位相の
四つの F_2 寄与へ正確に分解される。本検算は一辺二の全対象、一辺三の
D=empty の自明文字対象、および二重辺を持つ一辺三の交差対検査対象で、
分解前後と標的の巻き付き・交差対の式が一致することを確かめる。
有限集合、F_2、整数、Q(zeta_8) の厳密演算だけを使う。
"""

load("sagemath/check/parity-identity-pair-and-seam-decomposition/construction.sage")

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
    target = target_exponent(2, doubled, single, selector)
    for orientation in curved_free_orientations(2, single):
        pieces, decomposed = pair_and_seam_decomposition(
            2, doubled, single, orientation)
        assert decomposed == untwisted_sign_exponent(
            2, doubled, single, orientation)
        assert decomposed == target
        checks_two += 1


checks_three = ZZ(0)
checks_three_doubled = ZZ(0)
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    orientations = curved_free_orientations(3, single)
    if not orientations:
        continue
    selector = frozenset()
    target = target_exponent(3, frozenset(), single, selector)
    for orientation in orientations:
        pieces, decomposed = pair_and_seam_decomposition(
            3, frozenset(), single, orientation)
        assert decomposed == untwisted_sign_exponent(
            3, frozenset(), single, orientation)
        assert decomposed == target
        checks_three += 1

    single_h, single_v = subset_parities(3, single)
    if (single_h, single_v) == (0, 0):
        continue
    orientation = orientations[0]
    found_pairings = set()
    for base in sorted(base_edges_of_side(3)):
        if base in single:
            continue
        doubled = frozenset([base])
        selector = solve_selector(3, doubled, single)
        if selector is None:
            continue
        union_h, union_v = subset_parities(3, doubled.union(selector))
        pairing = (union_h * single_v + single_h * union_v) % 2
        if pairing in found_pairings:
            continue
        pieces, decomposed = pair_and_seam_decomposition(
            3, doubled, single, orientation)
        assert decomposed == untwisted_sign_exponent(
            3, doubled, single, orientation)
        assert decomposed == target_exponent(3, doubled, single, selector)
        checks_three_doubled += 1
        found_pairings.add(pairing)
        if found_pairings == {0, 1}:
            break


assert checks_three_doubled > 0
print("PASS: 偶奇恒等式の左辺を動辺数・内部辺対・切断線辺対・局所位相へ分解"
      "（一辺二 %d 配向、一辺三 %d 配向、二重辺つき一辺三 %d 鍵）"
      % (checks_two, checks_three, checks_three_doubled))
