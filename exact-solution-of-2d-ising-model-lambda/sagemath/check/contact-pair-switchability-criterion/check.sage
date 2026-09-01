"""接触対の切り替え可能性が四つの不等式で判定されることを厳密検査する。

対象: claim_contact_pair_switchability_criterion。

一辺 L=2 のトーラスの全非後退置換について、接触対の集合 Ct(phi)（切り替え可能に
限らない）を全列挙し、各接触対 {e,f} について、切り替え可能性の三条件
（def_switchable_permutation_contact_pair）と、四つの不等式
phi(f) != iota(e), phi(e) != iota(f), phi(f) != e, phi(e) != f
の連言が一致することを有限集合の等号だけで検査する。あわせて、標準接触対
ct_min(phi) が切り替え可能でない置換について、どの不等式が破れているかの内訳を
数える（次のセクションの分類の一次データ）。浮動小数点は使わない。
"""

load("sagemath/check/standard-contact-smoothing-involution/check.sage")


checked_pairs = 0
switchable_pairs = 0
standard_not_switchable = 0
reversal_only = 0
identity_violation = 0
for phi in nonbacktracking_permutations:
    pairs = contact_pairs(phi)
    if not pairs:
        continue
    for pair in pairs:
        edge, other = tuple(pair)

        # 冒頭の等式: 動く辺の像の始点は元の辺の終点である（非後退性から）。
        assert endpoints(L, phi[edge])[0] == endpoints(L, edge)[1]
        assert endpoints(L, phi[other])[0] == endpoints(L, other)[1]

        # 四つの不等式の連言。
        criterion = (phi[other] != reversal(edge)
                     and phi[edge] != reversal(other)
                     and phi[other] != edge
                     and phi[edge] != other)

        # 三条件の直接判定と一致すること（両方の並べ方で確かめ、対の対称性も見る）。
        direct = is_switchable_contact_pair(phi, edge, other)
        assert direct == is_switchable_contact_pair(phi, other, edge)
        assert direct == criterion

        checked_pairs += 1
        if direct:
            switchable_pairs += 1

    # 標準接触対が切り替え可能でない置換の内訳（分類の一次データ）。
    minimum = tuple(ct_min(phi))
    if not is_switchable_contact_pair(phi, minimum[0], minimum[1]):
        standard_not_switchable += 1
        edge, other = minimum
        reversal_broken = (phi[other] == reversal(edge)
                           or phi[edge] == reversal(other))
        identity_broken = (phi[other] == edge or phi[edge] == other)
        assert reversal_broken or identity_broken
        if identity_broken:
            identity_violation += 1
        else:
            reversal_only += 1

assert checked_pairs > 0
assert switchable_pairs > 0
print("PASS: L=%d 接触対 %d 件で四不等式判定と三条件の一致を検査"
      "（切り替え可能 %d 件。標準対が切り替え不能な置換 %d 個の内訳: "
      "反転像のみ %d、像が他方自身 %d）"
      % (L, checked_pairs, switchable_pairs,
         standard_not_switchable, reversal_only, identity_violation))
