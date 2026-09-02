"""偶部分グラフ上の向き反転共役が文字作用になるかを厳密検査する。

対象: claim_selection_even_subgraph_action_character と
      claim_path_reversal_fiber_preserving_involution。

一辺 L=2 の各非後退置換 phi と、その単純通過辺集合 E に含まれる
各偶部分グラフ H について、H の辺だけ二つの向きを交換する対合 rho_H を作り、
rho_H o phi o rho_H が同じ非後退置換ファイバーを保つかを検査する。
計算は有限集合・有限写像と Q(zeta_8) の等号だけで行う。
"""

load("sagemath/check/fiber-phase-character-vanishing/check.sage")


def base_edge(edge):
    kind, i, j, _ = edge
    return (kind, i, j)


def reverse_on_subset(edge, subset):
    return reverse_edge(edge) if base_edge(edge) in subset else edge


def conjugate_by_subset(phi, subset):
    return {
        edge: reverse_on_subset(
            phi[reverse_on_subset(edge, subset)], subset
        )
        for edge in oriented
    }


def is_nonbacktracking_permutation(phi):
    return all(
        phi[edge] == edge or phi[edge] in successors(L, oriented, edge)
        for edge in oriented
    )


checked = 0
fiber_failures = 0
nonbacktracking_failures = 0
phase_character_failures = 0
first_fiber_failure = None
first_nonbacktracking_failure = None
first_phase_character_failure = None

for (doubled, single), fiber in sorted(all_fibers.items()):
    translations = {
        subset for subset in selection_subsets
        if subset.issubset(single)
        and is_even_selection_subset(subset)
    }
    for phi in fiber:
        for translation in translations:
            conjugated = conjugate_by_subset(phi, translation)
            conjugated_fiber = doubled_and_single_sets(conjugated)
            if conjugated_fiber != (doubled, single):
                fiber_failures += 1
                if first_fiber_failure is None:
                    first_fiber_failure = (
                        doubled, single, translation, phi, conjugated,
                        conjugated_fiber,
                    )
            if not is_nonbacktracking_permutation(conjugated):
                nonbacktracking_failures += 1
                if first_nonbacktracking_failure is None:
                    first_nonbacktracking_failure = (
                        doubled, single, translation, phi, conjugated,
                    )
            else:
                character = K8(ZZ(-1) ** winding_pairing(single, translation))
                for a in (0, 1):
                    for b in (0, 1):
                        if phase_contribution(conjugated, a, b) != (
                            character * phase_contribution(phi, a, b)
                        ):
                            phase_character_failures += 1
                            if first_phase_character_failure is None:
                                first_phase_character_failure = (
                                    doubled, single, translation, a, b,
                                    phi, conjugated, character,
                                )
            checked += 1

assert checked == 78752
assert fiber_failures == 0
assert nonbacktracking_failures == 43664
assert phase_character_failures == 7680
print(f"PASS: even-subgraph-oriented-edge-conjugation (triples={checked})")
print(f"fiber failures: {fiber_failures}")
print(f"nonbacktracking failures: {nonbacktracking_failures}")
print(f"phase-character failures among nonbacktracking images: {phase_character_failures}")
if first_nonbacktracking_failure is not None:
    doubled, single, translation, phi, conjugated = first_nonbacktracking_failure
    print("first nonbacktracking failure: "
          f"D={sorted(doubled)}, E={sorted(single)}, H={sorted(translation)}, "
          f"phi={permutation_key(phi)}, conjugated={permutation_key(conjugated)}")
if first_phase_character_failure is not None:
    doubled, single, translation, a, b, phi, conjugated, character = first_phase_character_failure
    print("first phase-character failure: "
          f"D={sorted(doubled)}, E={sorted(single)}, H={sorted(translation)}, "
          f"(a,b)=({a},{b}), chi={character}, phi={permutation_key(phi)}, "
          f"conjugated={permutation_key(conjugated)}")
