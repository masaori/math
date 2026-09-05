"""標準接触対が平滑化で不変で、標準対での平滑化が不動点の無い対合であることを厳密検査する。

対象: claim_contact_pair_set_smoothing_invariant と claim_standard_contact_smoothing_involution。

一辺 L=2 のトーラスの全非後退置換について、接触対の集合 Ct(phi)（切り替え可能に限らない）と、
本文の辞書式順序（辺の番号、次に向き、対は最小元・最大元の順）による最小元 ct_min(phi) を計算する。
切り替え可能な接触対での平滑化の前後で Ct・N_ct・ct_min が変わらないこと、
ct_min が切り替え可能な置換の集合 A_L の上で S(phi) = Sm_{ct_min(phi)}(phi) が
A_L に留まり、二回適用で元へ戻り、不動点を持たず、M・D・E_1 を保つことを
有限集合の等号だけで検査する。浮動小数点は使わない。
"""

load("sagemath/check/standard-contact-smoothing-involution/construction.sage")

invariance_checked = 0
in_A = 0
with_contact = 0
for phi in nonbacktracking_permutations:
    ct = contact_pairs(phi)
    if not ct:
        continue
    with_contact += 1
    minimum = ct_min(phi)

    # claim_contact_pair_set_smoothing_invariant: 任意の切り替え可能な接触対での平滑化で
    # Ct・N_ct・ct_min が変わらない。
    for edge, other in switchable_contact_pairs(phi):
        psi = smooth(phi, edge, other)
        ct_after = contact_pairs(psi)
        assert ct_after == ct
        assert len(ct_after) == len(ct)
        assert ct_min(psi) == minimum
        invariance_checked += 1

    # claim_standard_contact_smoothing_involution: A_L の上の S は対合で不動点を持たない。
    pair = tuple(minimum)
    if not is_switchable_contact_pair(phi, pair[0], pair[1]):
        continue
    in_A += 1
    psi = smooth(phi, pair[0], pair[1])

    # S(phi) が A_L に属する: ct_min が同じ対で、psi でも切り替え可能。
    assert ct_min(psi) == minimum
    assert is_switchable_contact_pair(psi, pair[0], pair[1])

    # 対合: S(S(phi)) = phi。標準対が同じなので同じ対で戻る。
    assert smooth(psi, pair[0], pair[1]) == phi

    # 不動点なし: psi(e) = phi(f) != phi(e)。
    assert psi != phi

    # ファイバー保存: M・D・E_1 が変わらない。
    assert moved_edges(psi) == moved_edges(phi)
    assert doubled_and_single_sets(psi) == doubled_and_single_sets(phi)

assert with_contact > 0
assert invariance_checked > 0
assert in_A > 0
print("PASS: L=%d 非後退置換 %d 個中、接触対を持つ置換 %d 個、不変性の検査 %d 件、"
      "標準対が切り替え可能な置換 %d 個で対合を検査"
      % (L, len(nonbacktracking_permutations), with_contact, invariance_checked, in_A))
