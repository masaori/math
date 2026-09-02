"""ファイバー位相和の簡約四部分の内訳を偶部分グラフ選択和と厳密比較する。

対象: def_fiber_phase_weight, def_signed_selection_sum。

一辺 L=2 の全非後退置換を (D,E) のファイバーに分け、位相反転部分集合 B_L の
零和で簡約した後に残る四部分（接触の無い置換、回転差 -4、回転差 4、残余 R_L）の
位相和を Q(zeta_8) で計算する。各ファイバーと四つのスピン構造について、
四部分の和が U_L^{a,b}(D,E) に等しいこと、回転差 -4 と 4 の二部分の位相和が
互いに等しいことを検査し、各部分の値が有理整数に落ちるかどうか、
接触の無い部分だけで U に一致するか、残余の位相和が零かを数える。
浮動小数点は使わない。
"""

load("sagemath/check/kac-ward-fiber-signed-selection-equality/check.sage")


def phase_part_sum(part, a, b):
    return sum((contributions[permutation_key(phi)][(a, b)] for phi in part), K8(0))


def selection_sum(doubled, single, a, b):
    selectors = [
        selected for selected in base_edge_subsets
        if selected.issubset(single)
        and is_even_edge_subset(doubled.union(selected))
    ]
    return sum(
        (
            signed_even_subgraph_weight(a, b, doubled.union(selected))
            * signed_even_subgraph_weight(
                a, b, doubled.union(single.difference(selected)))
            for selected in selectors
        ),
        ZZ(0),
    )


decomposition_equalities = 0
turning_pair_equalities = 0
non_integer_parts = 0
contact_free_matches = 0
nonzero_residual_sums = 0
nonzero_turning_sums = 0
combos = 0
for (doubled, single), fiber in all_fibers.items():
    parts = {"contact_free": [], "phase_reversing": [], -4: [], 4: [], "remainder": []}
    for phi in fiber:
        if not contact_pairs(phi):
            parts["contact_free"].append(phi)
        else:
            pair = tuple(ct_min(phi))
            if not is_switchable_contact_pair(phi, pair[0], pair[1]):
                parts["remainder"].append(phi)
            elif in_B(phi):
                parts["phase_reversing"].append(phi)
            else:
                delta = standard_delta(phi)
                assert delta in (-4, 4)
                parts[delta].append(phi)
    assert sum(len(part) for part in parts.values()) == len(fiber)

    for a in (0, 1):
        for b in (0, 1):
            combos += 1
            selection = selection_sum(doubled, single, a, b)
            part_sums = {
                name: phase_part_sum(parts[name], a, b)
                for name in ("contact_free", -4, 4, "remainder")
            }
            assert phase_part_sum(parts["phase_reversing"], a, b) == 0
            assert sum(part_sums.values(), K8(0)) == K8(selection)
            decomposition_equalities += 1
            assert part_sums[-4] == part_sums[4]
            turning_pair_equalities += 1
            for value in part_sums.values():
                if value not in ZZ:
                    non_integer_parts += 1
            if part_sums["contact_free"] == K8(selection):
                contact_free_matches += 1
            if part_sums["remainder"] != 0:
                nonzero_residual_sums += 1
            if part_sums[-4] + part_sums[4] != 0:
                nonzero_turning_sums += 1

assert combos == 2436
print("PASS: L=%d の全 %d ファイバー×四スピン構造 %d 組で、"
      "簡約四部分の和= U の等式 %d 件と回転差二部分の相等 %d 件を検査"
      "（整数に落ちない部分和 %d 個、接触の無い部分だけで U に一致 %d 組、"
      "残余の位相和が非零 %d 組、回転差部分の和が非零 %d 組）"
      % (L, len(all_fibers), combos, decomposition_equalities,
         turning_pair_equalities, non_integer_parts, contact_free_matches,
         nonzero_residual_sums, nonzero_turning_sums))
