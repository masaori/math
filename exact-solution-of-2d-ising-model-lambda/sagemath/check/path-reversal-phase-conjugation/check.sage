"""経路反転が位相寄与の回転位相指数を反転することを厳密検査する。

対象: claim_path_reversal_phase_conjugation。

一辺 L=2 の全非後退置換と四つのスピン構造について、
W(T(phi)) = zeta8^(-2 Theta(phi)) W(phi)
を Q(zeta8) で検査する。浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-fiber-preserving-involution/check.sage")


def seam_sign(a, b, edge):
    horizontal, vertical = seam_parities(L, edge)
    return K8(ZZ(-1) ** (a * horizontal + b * vertical))


def phase_contribution(phi, a, b):
    value = K8(1)
    for orbit in moved_orbits(phi):
        orbit_value = K8(-1)
        for edge in orbit:
            image = phi[edge]
            orbit_value *= seam_sign(a, b, image) * zeta8 ** step_turning(edge, image)
        value *= orbit_value
    return value


checked = 0
for phi in nonbacktracking_permutations:
    reversed_phi = path_reversal(phi)
    total_turning = sum(
        (step_turning(edge, phi[edge]) for edge in moved_edges(phi)),
        ZZ(0),
    )
    for a in (0, 1):
        for b in (0, 1):
            assert phase_contribution(reversed_phi, a, b) == (
                zeta8 ** (-2 * total_turning) * phase_contribution(phi, a, b)
            )
            checked += 1

assert checked == 4 * len(nonbacktracking_permutations)
print("PASS: L=%d の非後退置換 %d 個×四スピン構造 %d 件で、"
      "経路反転の位相寄与 = zeta8^(-2 Theta) × 元の位相寄与を検査"
      % (L, len(nonbacktracking_permutations), checked))
