"""経路反転が切り替え可能対の個数による分類を保つことを厳密検査する。

対象: claim_path_reversal_switchable_classification_preservation,
      def_switchable_contact_count_classification。

一辺 L=2 の全非後退置換 phi について、
(1) Psi_phi の制限が Ct_sw(phi) から Ct_sw(T(phi)) への全単射で、N_sw を保つこと、
(2) 三分類（接触なし / 切り替え可能対あり / 接触対ありだが全対切り替え不能）が
    経路反転で保たれること、
(3) 経路反転がファイバーと位相寄与（{-1,1} の値）を保ち、二回適用が恒等である
    こと（したがって各「ファイバー × 分類 × 位相符号」の集合の上の対合であること）
を有限集合の等号と Q(zeta8) の等号だけで検査する。浮動小数点は使わない。
"""

load("sagemath/check/path-reversal-contact-pair-preservation/check.sage")


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


def switchable_pairs(phi):
    result = set()
    for pair in contact_pairs(phi):
        edge, other = tuple(pair)
        if is_switchable_contact_pair(phi, edge, other):
            result.add(pair)
    return result


def classification(phi):
    n_ct = len(contact_pairs(phi))
    n_sw = len(switchable_pairs(phi))
    assert n_sw <= n_ct
    if n_ct == 0:
        return "contact-free"
    if n_sw >= 1:
        return "has-switchable"
    return "all-unswitchable"


part_counts = {"contact-free": 0, "has-switchable": 0, "all-unswitchable": 0}
checked_sw_pairs = 0
checked_phase = 0
for phi in nonbacktracking_permutations:
    reversed_phi = path_reversal(phi)

    # (3) 対合性とファイバーの保存。
    assert path_reversal(reversed_phi) == phi
    assert doubled_and_single_sets(reversed_phi) == doubled_and_single_sets(phi)

    # (1) Psi_phi の制限が切り替え可能対の集合の全単射で、N_sw を保つ。
    sw = switchable_pairs(phi)
    reversed_sw = switchable_pairs(reversed_phi)
    image = set()
    for pair in sw:
        mapped = psi_map(phi, pair)
        assert mapped in reversed_sw
        assert psi_map(reversed_phi, mapped) == pair
        image.add(mapped)
        checked_sw_pairs += 1
    assert len(image) == len(sw)
    assert image == reversed_sw
    assert len(reversed_sw) == len(sw)

    # (2) 三分類の保存（分類は接触対の順序を用いない）。
    part = classification(phi)
    assert classification(reversed_phi) == part
    part_counts[part] += 1

    # (3) 位相寄与が {-1,1} に属し、経路反転で保たれる。
    for a in (0, 1):
        for b in (0, 1):
            value = phase_contribution(phi, a, b)
            assert value in (K8(1), K8(-1))
            assert phase_contribution(reversed_phi, a, b) == value
            checked_phase += 1

assert sum(part_counts.values()) == len(nonbacktracking_permutations)
assert all(count > 0 for count in part_counts.values())
assert checked_sw_pairs > 0
assert checked_phase == 4 * len(nonbacktracking_permutations)
print("PASS: L=%d の非後退置換 %d 個で、切り替え可能対の全単射（%d 件）と N_sw の保存、"
      "三分類（接触なし %d・切り替え可能対あり %d・全対切り替え不能 %d）の保存、"
      "ファイバー・位相寄与（四スピン構造 %d 件）の保存と対合性を全数検査"
      % (L, len(nonbacktracking_permutations), checked_sw_pairs,
         part_counts["contact-free"], part_counts["has-switchable"],
         part_counts["all-unswitchable"], checked_phase))
