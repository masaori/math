"""選択補集合が符号を保つ対合であることを厳密検査する。

対象: claim_selection_complement_sign_preserving_involution。

一辺 L=2 の全ファイバーについて、各選択 C の補集合 E\C が同じ選択集合に属し、
補集合を二回取ると C に戻り、符号指数と符号を保つことを四つのスピン構造で検査する。
E が空でなければ不動点が無いことも検査する。浮動小数点は使わない。
"""

load("sagemath/check/selection-sum-signed-count/check.sage")


def selection_exponent(a, b, doubled, single, selected):
    first = doubled.union(selected)
    second = doubled.union(single.difference(selected))
    first_h, first_v = winding_parities(first)
    second_h, second_v = winding_parities(second)
    return ZZ((1 + a) * first_h + (1 + b) * first_v + first_h * first_v
              + (1 + a) * second_h + (1 + b) * second_v + second_h * second_v)


checked = 0
for single in even_subsets:
    for doubled in subsets:
        if doubled.intersection(single):
            continue
        selectors = {
            selected for selected in subsets
            if selected.issubset(single)
            and is_even_edge_subset(doubled.union(selected))
        }
        for selected in selectors:
            complement = single.difference(selected)
            assert complement in selectors
            assert single.difference(complement) == selected
            if single:
                assert complement != selected
            for a in (0, 1):
                for b in (0, 1):
                    exponent = selection_exponent(a, b, doubled, single, selected)
                    complement_exponent = selection_exponent(a, b, doubled, single, complement)
                    assert complement_exponent == exponent
                    assert ZZ(-1) ** complement_exponent == ZZ(-1) ** exponent
                    checked += 1

assert checked == 4096
print("PASS: L=%d の全選択×四スピン構造 %d 件で、選択補集合の対合性・符号保存性と非空 E での不動点なしを検査"
      % (L, checked))
