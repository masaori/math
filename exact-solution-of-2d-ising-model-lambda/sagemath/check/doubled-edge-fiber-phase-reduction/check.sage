"""反転対を持つファイバーでも位相反転部分集合が相殺することを厳密検査する。

対象: claim_doubled_edge_fiber_phase_reduction。

一辺 L=2 の全非後退置換を (D,E_1) のファイバーに分け、D が空でない各ファイバーを
接触なし、B_L、A_L^(-4)、A_L^(4)、R_L（接触対を持つが標準対が切り替え不能）の
五集合へ分類する。四つのスピン構造ごとに B_L の位相寄与の総和が零であり、
ファイバー全体の和が残る四集合の和に等しいことを Q(zeta_8) の等号だけで検査する。
浮動小数点は使わない。
"""

load("sagemath/check/doubled-edge-fiber-phase-reduction/construction.sage")

# 構成側でも回している文をここでもう一度回すので、累算器を初期化し直す
# （初期化が構成側にしかないと、構成での実行ぶんへ二重に足し込む）。
cancelled = 0
classified = 0
equalities = 0
remainder_total = 0

for key, fiber in fibers.items():
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
        classified += 1

    assert sum(len(part) for part in parts.values()) == len(fiber)
    remainder_total += len(parts["remainder"])

    for a in (0, 1):
        for b in (0, 1):
            def phase_sum(part):
                return sum((contributions[permutation_key(phi)][(a, b)] for phi in part), K8(0))

            total = phase_sum(fiber)
            cancelling = phase_sum(parts["phase_reversing"])
            remaining = (
                phase_sum(parts["contact_free"])
                + phase_sum(parts[-4])
                + phase_sum(parts[4])
                + phase_sum(parts["remainder"])
            )
            assert cancelling == 0
            assert total == remaining
            cancelled += len(parts["phase_reversing"])
            equalities += 1

assert classified > 0
assert remainder_total > 0
print("PASS: L=%d の反転対を持つ %d ファイバー、置換 %d 個を五集合へ分類し、"
      "四スピン構造で位相反転部分の零和と簡約等式 %d 件を検査"
      "（零和の被加数延べ %d 個、切り替え不能な残余 %d 個）"
      % (L, len(fibers), classified, equalities, cancelled, remainder_total))
