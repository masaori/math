"""完全に切り替え不能な残余の各接触が反転対の辺を指すことを厳密検査する。

対象: claim_fully_unswitchable_contacts_witness_doubled_edges。

一辺 L=2 の全非後退置換から、標準接触対が切り替え不能な残余を取り出す。
そのうち全接触対が切り替え不能な置換を分類し、各接触対について像が他方自身に
なる障害が起こらず、反転像による障害が対応する台の辺を D(phi) に入れることを検査する。
浮動小数点は使わない。
"""

load("sagemath/check/unswitchable-standard-pair-forces-doubled-edge/check.sage")


fully_unswitchable = 0
checked_contacts = 0
residual_with_switchable_contact = 0
for phi in nonbacktracking_permutations:
    pairs = contact_pairs(phi)
    if not pairs:
        continue

    standard_edge, standard_other = tuple(ct_min(phi))
    if is_switchable_contact_pair(phi, standard_edge, standard_other):
        continue

    switchable = [
        (edge, other)
        for edge, other in pairs
        if is_switchable_contact_pair(phi, edge, other)
    ]
    if switchable:
        residual_with_switchable_contact += 1
        continue

    fully_unswitchable += 1
    for edge, other in pairs:
        assert phi[other] != edge
        assert phi[edge] != other
        assert phi[other] == reversal(edge) or phi[edge] == reversal(other)

        doubled = doubled_and_single_sets(phi)[0]
        assert edge[:3] in doubled or other[:3] in doubled
        checked_contacts += 1

assert fully_unswitchable == 830
assert residual_with_switchable_contact == 17925
assert checked_contacts > 0
print("PASS: L=%d の切り替え不能な標準対を持つ残余を、別の切り替え可能な接触対を持つ"
      "置換 %d 個と、全接触対が切り替え不能な置換 %d 個へ分類し、後者の接触対 %d 件が"
      "反転対の辺を指すことを検査"
      % (L, residual_with_switchable_contact, fully_unswitchable, checked_contacts))
