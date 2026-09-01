"""標準接触対の反転像による障害が反転対の辺を与えることを厳密検査する。

対象: claim_standard_contact_obstruction_witnesses_doubled_edge。

一辺 L=2 の全非後退置換について、標準接触対 {e,f} が
phi(f)=iota(e) または phi(e)=iota(f) を満たすなら、対応する台の辺が
D(phi) に属することを検査する。あわせて、標準接触対が切り替え不能な
18,755 個が全てこの反転像の障害に覆われることを再検査する。
浮動小数点は使わない。
"""

load("sagemath/check/contact-pair-switchability-criterion/check.sage")


checked_obstructions = 0
covered_standard_failures = 0
for phi in nonbacktracking_permutations:
    pairs = contact_pairs(phi)
    if not pairs:
        continue

    edge, other = tuple(ct_min(phi))
    obstruction_from_edge = phi[other] == reversal(edge)
    obstruction_from_other = phi[edge] == reversal(other)
    if obstruction_from_edge:
        assert edge in moved_edges(phi)
        assert reversal(edge) in moved_edges(phi)
        assert edge[:3] in doubled_and_single_sets(phi)[0]
        checked_obstructions += 1
    if obstruction_from_other:
        assert other in moved_edges(phi)
        assert reversal(other) in moved_edges(phi)
        assert other[:3] in doubled_and_single_sets(phi)[0]
        checked_obstructions += 1

    if not is_switchable_contact_pair(phi, edge, other):
        assert obstruction_from_edge or obstruction_from_other
        assert doubled_and_single_sets(phi)[0]
        covered_standard_failures += 1

assert checked_obstructions > 0
assert covered_standard_failures == 18755
print("PASS: L=%d で標準接触対の反転像の障害 %d 件が反転対の辺を与え、"
      "切り替え不能な置換 %d 個を全て覆うことを検査"
      % (L, checked_obstructions, covered_standard_failures))
