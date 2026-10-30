"""経路反転が位相寄与を保つことを厳密検査する。

対象: claim_path_reversal_phase_preservation。

一辺 L=2 の全非後退置換と四つのスピン構造について、
zeta8^(-Theta(phi)) が {-1,1} に属すること、および
W(T(phi)) = W(phi)
を Q(zeta8) で検査する。浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-phase-conjugation/check.sage")


checked_membership = 0
checked_preservation = 0
for phi in nonbacktracking_permutations:
    reversed_phi = path_reversal(phi)
    total_turning = sum(
        (step_turning(edge, phi[edge]) for edge in moved_edges(phi)),
        ZZ(0),
    )
    assert zeta8 ** (-total_turning) in (K8(1), K8(-1))
    checked_membership += 1
    for a in (0, 1):
        for b in (0, 1):
            assert phase_contribution(reversed_phi, a, b) == phase_contribution(phi, a, b)
            checked_preservation += 1

assert checked_membership == len(nonbacktracking_permutations)
assert checked_preservation == 4 * len(nonbacktracking_permutations)
print("PASS: L=%d の非後退置換 %d 個で zeta8^(-Theta) が {-1,1} に属し、"
      "四スピン構造 %d 件で経路反転が位相寄与を保つことを検査"
      % (L, checked_membership, checked_preservation))
