"""切り替え可能な接触対を持つ残余が符号反転対合で相殺できないことを厳密検査する。

不採用経路の検算。対象: claim_doubled_edge_fiber_phase_reduction（残余の扱いの分類）。

一辺 L=2 の全非後退置換を (D,E_1) のファイバーに分け、標準対が切り替え不能な
残余 R_L のうち、別の切り替え可能な接触対を持つ部分（unlocked）を取り出す。

1. 選択規則の不成立: 切り替え可能な接触対の辞書式最小での平滑化は、
   標準対を切り替え可能へ変えて残余から出す場合と、平滑化後の辞書式最小の
   切り替え可能対が変わる場合の両方を持つことを数える。
2. 相殺の不可能性: unlocked の位相寄与の総和を各ファイバー×スピン構造で
   Q(zeta_8) の厳密和として計算し、非零になる組が存在することを数える。
   ファイバーを保ち位相寄与の符号を反転する不動点の無い対合が unlocked 上に
   存在すれば総和は零になるはずなので、非零の組の存在はそのような対合の
   不在を示す。残余 R_L 全体についても同じ総和を数える。

浮動小数点は使わない。
"""

load("sagemath/check/non-phase-reversing-standard-smoothing-involution/check.sage")


def switchable_pairs_of(phi):
    return [tuple(sorted(p, key=text_edge_key)) for p in contact_pairs(phi)
            if is_switchable_contact_pair(phi, *tuple(p))]


fibers = {}
for phi in nonbacktracking_permutations:
    doubled, single = doubled_and_single_sets(phi)
    key = (frozenset(doubled), frozenset(single))
    fibers.setdefault(key, []).append(phi)

unlocked_total = 0
left_residual = 0
selection_changed = 0
unlocked_nonzero = 0
unlocked_zero_nonempty = 0
residual_nonzero = 0
for key, fiber in fibers.items():
    unlocked = []
    residual = []
    for phi in fiber:
        pairs = contact_pairs(phi)
        if not pairs:
            continue
        standard_edge, standard_other = tuple(ct_min(phi))
        if is_switchable_contact_pair(phi, standard_edge, standard_other):
            continue
        residual.append(phi)
        sw = switchable_pairs_of(phi)
        if not sw:
            continue
        unlocked.append(phi)
        unlocked_total += 1

        # 1. 辞書式最小の切り替え可能対での平滑化と選択の保存を検査する。
        chosen = min(sw, key=pair_key)
        psi = smooth(phi, chosen[0], chosen[1])
        psi_standard_edge, psi_standard_other = tuple(ct_min(psi))
        if is_switchable_contact_pair(psi, psi_standard_edge, psi_standard_other):
            left_residual += 1
        sw_after = switchable_pairs_of(psi)
        chosen_after = min(sw_after, key=pair_key) if sw_after else None
        if chosen_after != chosen:
            selection_changed += 1

    # 2. 位相寄与の総和の非零性を検査する。
    for a in (0, 1):
        for b in (0, 1):
            unlocked_sum = sum(
                (contributions[permutation_key(phi)][(a, b)] for phi in unlocked), K8(0))
            residual_sum = sum(
                (contributions[permutation_key(phi)][(a, b)] for phi in residual), K8(0))
            if unlocked:
                if unlocked_sum != 0:
                    unlocked_nonzero += 1
                else:
                    unlocked_zero_nonempty += 1
            if residual_sum != 0:
                residual_nonzero += 1

assert unlocked_total == 17925
assert left_residual == 4638
assert selection_changed == 7935
assert unlocked_nonzero == 380
assert residual_nonzero == 1028
print("PASS: L=%d の切り替え可能接触を持つ残余 %d 個で、辞書式最小の切り替え可能対での"
      "平滑化が残余から出す %d 個・選択を変える %d 個を数え、位相寄与の総和が非零になる"
      "（ファイバー×スピン構造）の組を unlocked で %d 件（零 %d 件）、残余全体で %d 件確認"
      % (L, unlocked_total, left_residual, selection_changed,
         unlocked_nonzero, unlocked_zero_nonempty, residual_nonzero))
