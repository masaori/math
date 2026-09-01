"""切り替え不能な標準接触対が反転対の辺を強制することを厳密検査する。

対象: claim_unswitchable_standard_pair_forces_doubled_edge。

一辺 L=2 のトーラスについて、まず全向き付き辺の始点と終点が相異なることを
検査する。次に全非後退置換について、標準接触対 {e,f} が切り替え可能でない
なら、像が他方自身になる等式 phi(f)=e, phi(e)=f がともに起こらず、反転像の
障害だけが残り、対応する台の辺が D(phi) に属して D(phi) が空でないことを
検査する。浮動小数点は使わない。
"""

load("sagemath/check/standard-contact-obstruction-doubled-edge/check.sage")


# 始点と終点の相異（L>=2 の端点相異の主張の直接検査）。
for edge in oriented:
    src, tgt = endpoints(L, edge)
    assert src != tgt

# 切り替え不能な標準接触対の全数検査。
forced = 0
for phi in nonbacktracking_permutations:
    pairs = contact_pairs(phi)
    if not pairs:
        continue

    edge, other = tuple(ct_min(phi))
    if is_switchable_contact_pair(phi, edge, other):
        continue

    # 第三・第四の等式（像が他方自身）は起こらない。
    assert phi[other] != edge
    assert phi[edge] != other

    # 反転像の障害だけが残る。
    assert phi[other] == reversal(edge) or phi[edge] == reversal(other)

    # 反転対の辺が強制される。
    doubled = doubled_and_single_sets(phi)[0]
    assert edge[:3] in doubled or other[:3] in doubled
    assert doubled
    forced += 1

assert forced == 18755
print("PASS: L=%d で全向き付き辺の端点相異と、切り替え不能な標準接触対を持つ"
      "置換 %d 個の全てで反転対の辺の強制を検査"
      % (L, forced))
