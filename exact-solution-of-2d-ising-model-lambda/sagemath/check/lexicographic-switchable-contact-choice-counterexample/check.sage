"""辞書式最小の切り替え可能接触対が平滑化で保存されないことを検査する。

対象: claim_contact_smoothing_same_pair_involution に紐づく不採用経路のノート。

一辺 L=2 の全非後退置換について、切り替え可能な接触対を辞書式に並べ、
最小対で平滑化した前後の最小対を比較する。同じ対が平滑化後も切り替え可能で
平滑化が対合であることを再確認したうえで、最小対が変わる反例が存在することを
有限集合の比較だけで検査する。浮動小数点は使わない。
"""

load("sagemath/check/contact-smoothing-same-pair-involution/check.sage")


def ordered_pair(edge, other):
    return tuple(sorted((edge, other)))


permutations_with_pair = 0
changed_choices = 0
for phi in nonbacktracking_permutations:
    pairs = [ordered_pair(edge, other)
             for edge, other in switchable_contact_pairs(phi)]
    if not pairs:
        continue

    permutations_with_pair += 1
    chosen = min(pairs)
    psi = smooth(phi, chosen[0], chosen[1])

    assert is_switchable_contact_pair(psi, chosen[0], chosen[1])
    assert smooth(psi, chosen[0], chosen[1]) == phi

    chosen_after = min(ordered_pair(edge, other)
                       for edge, other in switchable_contact_pairs(psi))
    if chosen_after != chosen:
        changed_choices += 1

assert permutations_with_pair == 29905
assert changed_choices == 7935
print("PASS: L=%d の切り替え可能な接触対を持つ置換 %d 個中 %d 個で辞書式最小対が平滑化後に変化"
      % (L, permutations_with_pair, changed_choices))
