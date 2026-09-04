"""選択項の符号の閉じた式と、共通性が文字の自明性と同値であることを検査する。

対象: claim_selection_sum_character_evaluation,
      claim_winding_parity_symmetric_difference_additivity。

鍵 (D,E) の選択項 w^{a,b}(D∪C)·w^{a,b}(D∪(E\C)) について、A := D∪C と置き、
巻き付き偶奇の F_2 双線形計算だけから従う恒等式

  w^{a,b}(A)·w^{a,b}(A△E)
    = (-1)^{(1+a)ε_h(E)+(1+b)ε_v(E)+ε_h(E)ε_v(E)} · (-1)^{ε_h(A)ε_v(E)+ε_h(E)ε_v(A)}

を検査する。第二因子は巻き付きベクトルの交差対 ⟨A,E⟩ であり、選択集合を
巡回空間の元 z で動かすと ⟨z,E⟩ だけ変わる。従って

  (1) 恒等式そのもの（文字の自明性に依らず全ての鍵・全ての選択集合で成立）、
  (2) 文字が自明な鍵では ⟨z,E⟩=0（z は基本閉路）なので選択項が共通符号
      (-1)^{(1+a)ε_h+(1+b)ε_v+ε_hε_v}·(-1)^{⟨D∪C_0,E⟩} を持つこと、
  (3) 文字が非自明な鍵では ⟨z,E⟩=1 の基本閉路 z があり、C ↦ C△z が
      選択項の符号を反転する不動点なしの対合になって選択和が零になること、

を検査する。一辺二では全ての置換ファイバー鍵、一辺三では D が空の全ての
偶部分グラフで全数検査する。有限集合、F_2、整数の厳密演算だけを使い、
浮動小数点は使わない。
"""

load("sagemath/check/curved-free-class-sum-selection-sign/check.sage")


def intersection_pairing(side, left, right):
    left_h, left_v = subset_parities(side, left)
    right_h, right_v = subset_parities(side, right)
    return (left_h * right_v + left_v * right_h) % 2


def closed_formula(side, a, b, first, single):
    single_h, single_v = subset_parities(side, single)
    exponent = ((1 + a) * single_h + (1 + b) * single_v
                + single_h * single_v
                + intersection_pairing(side, first, single))
    return ZZ(-1) ** exponent


# --- 一辺二: 全ての置換ファイバー鍵で恒等式と共通符号の閉じた式を検査する ---

identity_checks_two = ZZ(0)
selection_keys_two = ZZ(0)
common_sign_keys_two = ZZ(0)
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    if not selectors:
        continue
    selection_keys_two += 1
    character_trivial = character_is_trivial_general(2, single)
    reference = doubled.union(selectors[0])
    for a in (0, 1):
        for b in (0, 1):
            for selected in selectors:
                first = doubled.union(selected)
                second = doubled.union(single.difference(selected))
                term = (signed_even_subgraph_weight(a, b, first)
                        * signed_even_subgraph_weight(a, b, second))
                assert term == closed_formula(2, a, b, first, single)
                identity_checks_two += 1
                if character_trivial:
                    assert term == closed_formula(2, a, b, reference, single)
    if character_trivial:
        for cycle in fundamental_cycles(2, single):
            assert intersection_pairing(2, cycle, single) == 0
        common_sign_keys_two += 1

assert common_sign_keys_two == 369
print("PASS: L=2 の選択非空 %d 鍵で恒等式を %d 件検査し、自明文字の %d 鍵で"
      "共通符号の閉じた式と基本閉路の交差対零を検査"
      % (selection_keys_two, identity_checks_two, common_sign_keys_two))

# --- 一辺三: D が空の全ての偶部分グラフで恒等式・共通符号・対合消滅を検査する ---

identity_checks_three = ZZ(0)
trivial_keys_three = ZZ(0)
nontrivial_keys_three = ZZ(0)
involution_checks_three = ZZ(0)
for single in sorted(even_subgraphs_three, key=lambda item: tuple(sorted(item))):
    if not single:
        continue
    cycles = fundamental_cycles(3, single)
    selectors_three = set()
    for coefficients in cartesian_product([(0, 1)] * len(cycles)):
        selected = set()
        for coefficient, cycle in zip(coefficients, cycles):
            if coefficient:
                selected.symmetric_difference_update(cycle)
        selectors_three.add(frozenset(selected))

    def term_three(a, b, selected):
        return (signed_weight(3, a, b, selected)
                * signed_weight(3, a, b, single.difference(selected)))

    for a in (0, 1):
        for b in (0, 1):
            for selected in selectors_three:
                assert term_three(a, b, selected) \
                    == closed_formula(3, a, b, selected, single)
                identity_checks_three += 1

    trivial = character_is_trivial_general(3, single)
    if trivial:
        reference = min(selectors_three, key=lambda item: tuple(sorted(item)))
        for cycle in cycles:
            assert intersection_pairing(3, cycle, single) == 0
        for a in (0, 1):
            for b in (0, 1):
                common = closed_formula(3, a, b, reference, single)
                assert all(term_three(a, b, selected) == common
                           for selected in selectors_three)
        trivial_keys_three += 1
    else:
        flipping = [cycle for cycle in cycles
                    if intersection_pairing(3, cycle, single) == 1]
        assert flipping
        twist_cycle = flipping[0]
        for a in (0, 1):
            for b in (0, 1):
                total = ZZ(0)
                for selected in selectors_three:
                    partner = frozenset(
                        set(selected).symmetric_difference(twist_cycle))
                    assert partner in selectors_three
                    assert partner != selected
                    assert term_three(a, b, partner) \
                        == -term_three(a, b, selected)
                    total += term_three(a, b, selected)
                    involution_checks_three += 1
                assert total == 0
        nontrivial_keys_three += 1

assert trivial_keys_three == 677
assert nontrivial_keys_three == 346
print("PASS: L=3 の D=∅ の非空偶部分グラフで恒等式を %d 件検査。自明文字 %d 鍵は"
      "共通符号の閉じた式に一致し、非自明文字 %d 鍵は符号反転対合（%d 件）で"
      "選択和が零" % (identity_checks_three, trivial_keys_three,
                      nontrivial_keys_three, involution_checks_three))
