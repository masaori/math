"""経路反転が接触対の全単射を誘導し切り替え可能性を保つことを厳密検査する。

対象: claim_path_reversal_contact_pair_preservation。

一辺 L=2 のトーラスの全非後退置換 phi について、経路反転 T(phi) を構成し、
接触対 P = {e, f} in Ct(phi) に対する Psi_phi(P) = {iota(phi(e)), iota(phi(f))} が
(1) Ct(T(phi)) への写像であり、その像が Ct(T(phi)) 全体に一致すること（全単射）、
(2) Psi_{T(phi)} . Psi_phi が Ct(phi) の恒等写像であること、
(3) N_ct(T(phi)) = N_ct(phi)、
(4) P の切り替え可能性と Psi_phi(P) の切り替え可能性が一致すること
を有限集合の等号だけで検査する。浮動小数点は使わない。
"""

load("sagemath/check/standard-contact-smoothing-involution/check.sage")


def path_reversal(phi):
    inverse = {image: edge for edge, image in phi.items()}
    return {edge: reversal(inverse[reversal(edge)]) for edge in oriented}


def psi_map(phi, pair):
    return frozenset(reversal(phi[edge]) for edge in pair)


checked = 0
checked_pairs = 0
switchable_preserved = 0
for phi in nonbacktracking_permutations:
    reversed_phi = path_reversal(phi)
    pairs = contact_pairs(phi)
    reversed_pairs = contact_pairs(reversed_phi)

    # (3) 接触対の個数の保存。
    assert len(pairs) == len(reversed_pairs)

    image = set()
    for pair in pairs:
        mapped = psi_map(phi, pair)

        # (1) Psi_phi(P) は T(phi) の接触対である。
        assert mapped in reversed_pairs
        image.add(mapped)

        # (2) Psi_{T(phi)} . Psi_phi = id。
        assert psi_map(reversed_phi, mapped) == pair

        # (4) 切り替え可能性の保存。
        edge, other = tuple(pair)
        mapped_edge, mapped_other = tuple(mapped)
        direct = is_switchable_contact_pair(phi, edge, other)
        mapped_direct = is_switchable_contact_pair(
            reversed_phi, mapped_edge, mapped_other)
        assert direct == mapped_direct
        if direct:
            switchable_preserved += 1
        checked_pairs += 1

    # (1) 単射性（個数一致と像の包含から全射も従う）。
    assert len(image) == len(pairs)
    assert image == reversed_pairs

    checked += 1

assert checked == len(nonbacktracking_permutations)
assert checked > 0
assert checked_pairs > 0
print("PASS: L=%d 非後退置換 %d 個・接触対 %d 件の全数で、経路反転による接触対の"
      "全単射・恒等合成・個数保存・切り替え可能性の保存を検査（切り替え可能 %d 件）"
      % (L, checked, checked_pairs, switchable_preserved))
