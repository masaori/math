"""標準対の回転差が正負四である部分集合上の位相保存対合を厳密検査する。

対象: claim_non_phase_reversing_standard_smoothing_involution。

一辺 L=2 の全非後退置換から A_L^(-4) と A_L^(4) を作り、標準対平滑化が
両集合を交換し、二回適用で元へ戻り、不動点を持たず、M・D・E_1 と四つの
スピン構造の位相寄与 W を保つことを Q(zeta_8) と整数の等号だけで検査する。
浮動小数点は使わない。
"""

load("sagemath/check/non-phase-reversing-standard-smoothing-involution/construction.sage")

members = {delta: [] for delta in (ZZ(-4), ZZ(4))}
for phi in nonbacktracking_permutations:
    if not contact_pairs(phi):
        continue
    pair = tuple(ct_min(phi))
    if not is_switchable_contact_pair(phi, pair[0], pair[1]):
        continue
    delta = standard_delta(phi)
    if delta in members:
        members[delta].append(phi)

checked = 0
for delta in (ZZ(-4), ZZ(4)):
    for phi in members[delta]:
        pair = tuple(ct_min(phi))
        psi = smooth(phi, pair[0], pair[1])

        assert ct_min(psi) == frozenset(pair)
        assert standard_delta(psi) == -delta
        assert smooth(psi, pair[0], pair[1]) == phi
        assert psi != phi
        assert moved_edges(psi) == moved_edges(phi)
        assert doubled_and_single_sets(psi) == doubled_and_single_sets(phi)
        doubled, single = doubled_and_single_sets(phi)
        fiber = (frozenset(doubled), frozenset(single))
        fiber_members[delta].setdefault(fiber, []).append(phi)

        for a in (0, 1):
            for b in (0, 1):
                before = contributions[permutation_key(phi)][(a, b)]
                after = contributions[permutation_key(psi)][(a, b)]
                assert before != 0
                assert after == before
                checked += 1

fiber_sum_equalities = 0
for fiber in all_fibers:
    for a in (0, 1):
        for b in (0, 1):
            negative_sum = sum(
                (contributions[permutation_key(phi)][(a, b)]
                 for phi in fiber_members[-4].get(fiber, [])),
                K8(0),
            )
            positive_sum = sum(
                (contributions[permutation_key(phi)][(a, b)]
                 for phi in fiber_members[4].get(fiber, [])),
                K8(0),
            )
            assert negative_sum == positive_sum
            fiber_sum_equalities += 1

assert len(members[-4]) > 0
assert len(members[-4]) == len(members[4])
assert checked == 4 * (len(members[-4]) + len(members[4]))
print("PASS: L=%d で A_L^(-4) は %d 個、A_L^(4) は %d 個。"
      "標準対平滑化による両集合の交換・対合・不動点なし・ファイバー保存・位相寄与保存を検査（%d 件）。"
      "さらに %d ファイバー×四スピン構造で回転差二部分の位相和の相等を検査（%d 件）"
      % (L, len(members[-4]), len(members[4]), checked,
         len(all_fibers), fiber_sum_equalities))
