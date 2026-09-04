"""接触平滑化が位相寄与の符号を反転するための必要十分条件を厳密検査する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""

load("sagemath/check/standard-contact-smoothing-involution/construction.sage")


def permutation_key(phi):
    return tuple(phi[edge] for edge in oriented)


def phase_contribution(phi, a, b):
    value = K8(1)
    for walk in moved_orbits(phi):
        orbit_product = K8(1)
        for edge in walk:
            orbit_product *= K8(transition_entry(L, a, b, edge, phi[edge]))
        value *= -orbit_product
    return value


contributions = {}
for phi in nonbacktracking_permutations:
    key = permutation_key(phi)
    contributions[key] = {
        (a, b): phase_contribution(phi, a, b)
        for a in (0, 1) for b in (0, 1)
    }

delta_counts = {ZZ(-4): 0, ZZ(0): 0, ZZ(4): 0}
checked = 0
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
        delta_counts[delta] += 1
        if frozenset((edge, other)) == standard:
            standard_delta_counts[delta] += 1

        for a in (0, 1):
            for b in (0, 1):
                before = contributions[permutation_key(phi)][(a, b)]
                after = contributions[permutation_key(psi)][(a, b)]
                checked += 1
