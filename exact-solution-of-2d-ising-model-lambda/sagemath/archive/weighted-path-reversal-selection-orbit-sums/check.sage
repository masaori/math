"""二つの符号付き数え上げの重み付き軌道和表示を厳密検査する。

対象: claim_weighted_path_reversal_selection_orbit_sums。

一辺 L=2 の全ファイバーと四つのスピン構造について、三分類で細分した
経路反転軌道と選択補集合軌道の元数を重みとして足した値が、それぞれ
ファイバー位相和と選択和に一致することを ZZ と Q(zeta8) で検査する。
浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-selection-complement-orbits/check.sage")


def switchable_pairs(phi):
    return {
        pair for pair in contact_pairs(phi)
        if is_switchable_contact_pair(phi, *tuple(pair))
    }


def invariant_class(phi):
    if not contact_pairs(phi):
        return "contact-free"
    if switchable_pairs(phi):
        return "has-switchable"
    return "all-unswitchable"


checked = 0
for (doubled, single), fiber in all_fibers.items():
    selectors = {
        selected for selected in selection_subsets
        if selected.issubset(single)
        and is_even_selection_subset(doubled.union(selected))
    }
    for a in (0, 1):
        for b in (0, 1):
            weighted_permutation_sum = ZZ(0)
            for part in ("contact-free", "has-switchable", "all-unswitchable"):
                for sign in (K8(1), K8(-1)):
                    elements = {
                        permutation_key(phi): phi for phi in fiber
                        if invariant_class(phi) == part
                        and phase_contribution(phi, a, b) == sign
                    }
                    orbits = involution_orbits(
                        elements,
                        lambda key: permutation_key(path_reversal(elements[key])),
                    )
                    weighted_permutation_sum += ZZ(sign) * sum(ZZ(len(orbit)) for orbit in orbits)

            direct_permutation_sum = sum(
                (phase_contribution(phi, a, b) for phi in fiber), K8(0)
            )
            assert K8(weighted_permutation_sum) == direct_permutation_sum

            weighted_selection_sum = ZZ(0)
            for sign in (ZZ(1), ZZ(-1)):
                elements = {
                    selected for selected in selectors
                    if ZZ(-1) ** selection_exponent(a, b, doubled, single, selected) == sign
                }
                orbits = involution_orbits(
                    elements,
                    lambda selected: single.difference(selected),
                )
                weighted_selection_sum += sign * sum(ZZ(len(orbit)) for orbit in orbits)

            direct_selection_sum = sum(
                (ZZ(-1) ** selection_exponent(a, b, doubled, single, selected)
                 for selected in selectors),
                ZZ(0),
            )
            assert weighted_selection_sum == direct_selection_sum
            checked += 1

assert checked == 4 * len(all_fibers)
print("PASS: L=%d の全 %d ファイバー×四スピン構造 %d 組で、"
      "経路反転軌道と選択補集合軌道の重み付き和表示を検査"
      % (L, len(all_fibers), checked))
