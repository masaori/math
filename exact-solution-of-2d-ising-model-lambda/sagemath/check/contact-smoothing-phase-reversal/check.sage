"""接触平滑化が位相寄与の符号を反転するための必要十分条件を厳密検査する。

対象: claim_contact_smoothing_phase_reversal_iff。

一辺 L=2 の全非後退置換と全切り替え可能接触対について、平滑化前後の
置換一つの位相寄与 W を四つのスピン構造で計算する。二接続の回転数和の差が 0
であることと W が符号反転することが同値であり、差が ±4 なら W が不変であることを
Q(zeta_8) で検査する。浮動小数点は使わない。
"""

load("sagemath/check/contact-smoothing-phase-reversal/construction.sage")

# 構成側でも回している文をここでもう一度回すので、累算器を初期化し直す
# （初期化が構成側にしかないと、構成での実行ぶんへ二重に足し込む）。
checked = 0
delta_counts = {ZZ(-4): 0, ZZ(0): 0, ZZ(4): 0}
standard_delta_counts = {ZZ(-4): 0, ZZ(0): 0, ZZ(4): 0}

for phi in nonbacktracking_permutations:
    pairs = switchable_contact_pairs(phi)
    standard = ct_min(phi) if contact_pairs(phi) else None
    for edge, other in pairs:
        psi = smooth(phi, edge, other)
        delta = (
            step_turning(edge, phi[edge]) + step_turning(other, phi[other])
            - step_turning(edge, phi[other]) - step_turning(other, phi[edge])
        )
        assert delta in delta_counts
        delta_counts[delta] += 1
        if frozenset((edge, other)) == standard:
            standard_delta_counts[delta] += 1

        for a in (0, 1):
            for b in (0, 1):
                before = contributions[permutation_key(phi)][(a, b)]
                after = contributions[permutation_key(psi)][(a, b)]
                assert before != 0
                if delta == 0:
                    assert after == -before
                else:
                    assert after == before
                checked += 1

assert sum(delta_counts.values()) > 0
assert delta_counts[0] > 0
assert delta_counts[-4] > 0 and delta_counts[4] > 0
assert checked == 4 * sum(delta_counts.values())
print("PASS: L=%d 切り替え可能接触対 %d 件×四スピン構造を検査。"
      "回転差 -4: %d 件、0: %d 件、4: %d 件。"
      "標準対では -4: %d 件、0: %d 件、4: %d 件"
      % (L, sum(delta_counts.values()), delta_counts[-4], delta_counts[0], delta_counts[4],
         standard_delta_counts[-4], standard_delta_counts[0], standard_delta_counts[4]))
