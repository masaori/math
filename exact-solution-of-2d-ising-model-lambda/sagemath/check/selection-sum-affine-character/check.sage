"""選択集合への偶部分グラフの作用と選択符号の文字を厳密検査する。

対象: claim_selection_even_subgraph_action_character
（および def_signed_selection_sum, claim_selection_sum_signed_count）。

一辺 L=2 の全ファイバー (D,E) について、E の偶部分グラフ H を対称差で
選択集合 C_L(D,E) に作用させる。任意の選択 C と任意の偶 H⊆E について
C△H が選択集合に属し、選択符号の指数差が
eps_h(E) eps_v(H) + eps_v(E) eps_h(H) (mod 2) に等しいこと（全対検査）、
この作用が単純推移的であることを調べる。
従ってこの文字が非自明なら選択和は零、自明なら全項が同符号である。
計算は有限集合、F_2 の算術、ZZ だけで行い、浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-selection-complement-orbits/check.sage")


def winding_pairing(first, second):
    first_h, first_v = selection_winding_parities(first)
    second_h, second_v = selection_winding_parities(second)
    return ZZ((first_h * second_v + first_v * second_h) % 2)


checked = 0
empty_selection_sets = 0
zero_sums = 0
constant_sign_sums = 0
for (doubled, single), fiber in sorted(all_fibers.items()):
    selectors = {
        selected for selected in selection_subsets
        if selected.issubset(single)
        and is_even_selection_subset(doubled.union(selected))
    }
    translations = {
        subset for subset in selection_subsets
        if subset.issubset(single)
        and is_even_selection_subset(subset)
    }
    if not selectors:
        empty_selection_sets += 1
        for a in (0, 1):
            for b in (0, 1):
                assert sum((ZZ(-1) ** selection_exponent(a, b, doubled, single, selected)
                            for selected in selectors), ZZ(0)) == 0
                checked += 1
        continue
    base = next(iter(selectors))
    assert {base.symmetric_difference(translation) for translation in translations} == selectors
    assert len(translations) == len(selectors)

    nontrivial_character = any(winding_pairing(single, translation) == 1
                               for translation in translations)
    character = {translation: winding_pairing(single, translation)
                 for translation in translations}
    for a in (0, 1):
        for b in (0, 1):
            exponents = {selected: selection_exponent(a, b, doubled, single, selected)
                         for selected in selectors}
            base_exponent = exponents[base]
            for selected in selectors:
                for translation in translations:
                    shifted = selected.symmetric_difference(translation)
                    assert shifted in selectors
                    exponent_difference = (exponents[shifted] - exponents[selected]) % 2
                    assert exponent_difference == character[translation]

            value = sum((ZZ(-1) ** exponents[selected]
                         for selected in selectors), ZZ(0))
            if nontrivial_character:
                assert value == 0
                zero_sums += 1
            else:
                assert value == ZZ(-1) ** base_exponent * len(selectors)
                constant_sign_sums += 1
            checked += 1

assert checked == 4 * len(all_fibers)
assert 4 * empty_selection_sets + zero_sums + constant_sign_sums == checked
print("PASS: L=%d の全ファイバー×四スピン構造 %d 組で選択集合の単純推移作用と文字和を検査。"
      "空の選択集合 %d ファイバー、非自明文字による零和 %d 組、定符号和 %d 組"
      % (L, checked, empty_selection_sets, zero_sums, constant_sign_sums))
