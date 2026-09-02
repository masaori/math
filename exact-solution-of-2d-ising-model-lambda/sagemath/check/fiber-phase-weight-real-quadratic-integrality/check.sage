"""ファイバー位相和が Z + Z(zeta8 - zeta8^3) に属することを厳密検査する。

対象: claim_fiber_phase_weight_real_quadratic_integrality と
その補題 claim_phase_contribution_signed_rotation_power。

一辺 L=2 の全非後退置換について、
(1) W^{a,b}(phi) * zeta8^(-Theta(phi)) が {-1, 1} に属すること、
(2) 全ファイバー (D, E) と四つのスピン構造について
    K^{a,b}_L(D,E) = u + v (zeta8 - zeta8^3)（u, v は有理整数）となること
を Q(zeta8) の厳密演算で検査する。浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-phase-conjugation/check.sage")

sqrt2_element = zeta8 - zeta8 ** 3


def fiber_key(phi):
    doubled, single = doubled_and_single_sets(phi)
    return (frozenset(doubled), frozenset(single))


def in_integer_lattice_with_sqrt2(value):
    coefficients = K8(value).list()
    assert len(coefficients) == 4
    a0, a1, a2, a3 = coefficients
    return (
        a0 in ZZ
        and a1 in ZZ
        and a2 == 0
        and a3 == -a1
    )


signed_power_checked = 0
fiber_sums = {}
for phi in nonbacktracking_permutations:
    total_turning = sum(
        (step_turning(edge, phi[edge]) for edge in moved_edges(phi)),
        ZZ(0),
    )
    key = fiber_key(phi)
    for a in (0, 1):
        for b in (0, 1):
            value = phase_contribution(phi, a, b)

            # (1) 符号付き回転位相冪: W * zeta8^(-Theta) は {-1, 1} に属する。
            signed_unit = value * zeta8 ** (-total_turning)
            assert signed_unit in (K8(1), K8(-1))
            signed_power_checked += 1

            fiber_sums[(key, a, b)] = fiber_sums.get((key, a, b), K8(0)) + value

assert signed_power_checked == 4 * len(nonbacktracking_permutations)

# (2) 各ファイバー×スピン構造の位相和は Z + Z(zeta8 - zeta8^3) に属する。
lattice_checked = 0
nonzero_sqrt2_coefficient = 0
for total in fiber_sums.values():
    assert in_integer_lattice_with_sqrt2(total)
    coefficients = K8(total).list()
    if coefficients[1] != 0:
        nonzero_sqrt2_coefficient += 1
    lattice_checked += 1

fiber_count = len({key for (key, a, b) in fiber_sums})
assert lattice_checked == 4 * fiber_count

print("PASS: L=%d の非後退置換 %d 個×四スピン構造 %d 件で符号付き回転位相冪を、"
      "%d ファイバー×四スピン構造 %d 件でファイバー位相和が"
      " Z + Z(zeta8 - zeta8^3) に属することを検査（zeta8 - zeta8^3 の係数が非零の組 %d）"
      % (L, len(nonbacktracking_permutations), signed_power_checked,
         fiber_count, lattice_checked, nonzero_sqrt2_coefficient))
