"""未ねじれの配向類の符号同定を一つの F_2 偶奇恒等式へ還元する。

対象: claim_selection_sum_character_evaluation,
      claim_kac_ward_determinant_fiber_stratified_phase_sum。

曲がり型のない均衡配向 o について、局所行列式の積から絶対値
2^n4(E) を除いた符号を (-1)^q と書く。配向類の局所行列式和の符号は

  (-1)^( |2D sqcup o(E)| + r + c + q )

である。r,c は、動辺の固定順序から終点別・始点別の順序へ移す二つの
置換の反転数の偶奇である。従って未ねじれの符号同定は、この指数が

  eh(E)+ev(E)+eh(E)ev(E)+<D union C0,E>  (mod 2)

に等しいことだけへ還元される。本検査は各因子を別々に計算し、一辺二の
全対象と一辺三の D=empty の自明文字対象で、この還元と標的の偶奇式を
厳密に照合する。有限集合、F_2、整数、Q(zeta_8) だけを使う。
"""

load("sagemath/check/curved-free-class-sign-parity-reduction/construction.sage")

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
        assert untwisted_sign_exponent(2, doubled, single, orientation) == target
        checks_two += 1


checks_three = ZZ(0)
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single or not character_is_trivial_general(3, single):
        continue
    selector = frozenset()
    target = target_exponent(3, frozenset(), single, selector)
    for orientation in curved_free_orientations(3, single):
        assert untwisted_sign_exponent(
            3, frozenset(), single, orientation) == target
        checks_three += 1


print("PASS: 未ねじれの配向類の符号を動辺数・二つの並べ替え・局所位相の"
      "F_2 偶奇式へ還元し、標的の閉じた式との一致を一辺二 %d 配向、"
      "一辺三 %d 配向で検査" % (checks_two, checks_three))
