"""経路反転軌道と選択補集合軌道の符号保存対応が存在しない有限反例を検査する。

対象: claim_path_reversal_fixed_point_no_single_traversal と
claim_weighted_path_reversal_selection_orbit_sums。

一辺 L=2 の単純通過辺集合が非空な全ファイバーについて、四つの
スピン構造と二つの符号ごとに、経路反転軌道側と選択補集合軌道側の
元数を比較する。両側の軌道は全て二元なので、符号と重みを保つ全単射が
存在するなら、この元数は符号ごとに一致しなければならない。
浮動小数点は使わない。
"""

load("sagemath/check/weighted-path-reversal-selection-orbit-sums/check.sage")

mismatches = []
for (doubled, single), fiber in all_fibers.items():
    if not single:
        continue
    selectors = {
        selected for selected in selection_subsets
        if selected.issubset(single)
        and is_even_selection_subset(doubled.union(selected))
    }
    for a in (0, 1):
        for b in (0, 1):
            for sign in (K8(1), K8(-1)):
                permutation_count = sum(
                    ZZ(1) for phi in fiber
                    if phase_contribution(phi, a, b) == sign
                )
                selection_count = sum(
                    ZZ(1) for selected in selectors
                    if ZZ(-1) ** selection_exponent(
                        a, b, doubled, single, selected
                    ) == ZZ(sign)
                )
                if permutation_count != selection_count:
                    mismatches.append((
                        doubled, single, a, b, ZZ(sign),
                        permutation_count, selection_count,
                    ))

assert len(mismatches) == 2744
assert any(
    permutation_count == 2 and selection_count == 0
    for _, _, _, _, _, permutation_count, selection_count in mismatches
)

first = mismatches[0]
print("PASS: L=%d の E 非空ファイバーで符号別元数の不一致 %d 件を確認。"
      "最初の不一致は D=%s, E=%s, (a,b)=(%d,%d), 符号=%d, "
      "置換側=%d, 選択側=%d"
      % (L, len(mismatches), sorted(first[0]), sorted(first[1]),
         first[2], first[3], first[4], first[5], first[6]))
