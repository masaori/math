# 対象ラベル: def_inversion_pairs / def_orbit_inversion_count /
#             def_cross_orbit_inversion_pairs / claim_orbit_inner_inversion_pairs /
#             claim_inversion_count_orbit_decomposition
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した、
# 転倒数を軌道ごとの転倒数の和とまたぐ転倒対の個数へ分ける主張を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と数え上げであり、浮動小数点は使わない。
#
# 何を確かめるか:
#   0. 定義が実装と合っていること。Inv(phi) が P_L の、Inv^≠(phi) が Inv(phi) の、
#      軌道の中の転倒対が F(O,O) の部分集合であること。
#      **これを別に確かめる理由**: 下の 2・3 は個数の等式なので、集合の取り違えが
#      個数の一致に隠れて検出できない。
#   1. claim_orbit_inner_inversion_pairs。人手証明は**集合の等号**を示し、個数はそこから取る。
#      したがって検証も個数ではなく集合そのものの一致を見る（個数だけを見ると、
#      両辺が違う集合で個数だけ一致する場合を見逃す）。
#   2. claim_inversion_count_orbit_decomposition。
#      inv(phi) = sum_O inv_O(phi|_O) + |Inv^≠(phi)|。
#      人手証明の中間段（Step 1 の Inv = Inv^= ⊔ Inv^≠、Step 2 の Inv^= = ⊔_O A(O)、
#      および A(O) たちが互いに素であること）も**別々に**確かめる。
#      最終の等式だけを見ると、2 つの中間段が両方誤っていて辻褄が合う場合を見逃す。
#   3. 主張が空でないこと。Inv^≠(phi) が空でない例、inv_O(phi|_O) が 0 でない例があること。
#      どちらもつねに 0 なら、等式は 0 = 0 + 0 を見ているだけで何も言っていない。
#   4. 次のセクションへの足場の確認（これは検証であって証明ではない）。
#      Inv^≠(phi) が、前のセクションの J_phi(O,O') を相異なる軌道の非順序対にわたって
#      集めたものと一致すること。次のセクションはこの一致を使って |Inv^≠(phi)| の偶数性を出す。
#
# 走らせる L の範囲について。
#   軌道を保つ置換 S^O_L は S_L の全列挙から絞って作るので（軌道ごとの置換から組み立てると、
#   その組み立てが前のセクションの主張になっており循環する）、(2^L)! が総当たりできる
#   L = 1, 2, 3 に限る。L = 4 では 16! 通りで走らせられない。この打ち切りは overview.md にも書く。

import itertools
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def column_translation(L, y):
    """def_column_translation: gamma(y) = y +_{Z/LZ} 1bar。"""
    return (y + 1) % L


def row_shift(L, tau):
    """def_row_config_shift: (S(tau))(y) = tau(gamma(y))。"""
    return {y: tau[column_translation(L, y)] for y in range(L)}


def row_shift_iterate(L, k, tau):
    """def_row_config_shift_iterate: S^[0] = id、S^[k+1] = S o S^[k]。"""
    if k == 0:
        return dict(tau)
    return row_shift(L, row_shift_iterate(L, k - 1, tau))


def orbit(L, tau):
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。"""
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_of_key(L, key):
    return orbit(L, row_config_from_key(key))


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return sorted(
        {orbit_of_key(L, key) for key in row_matrix_keys(L)}, key=lambda o: sorted(o)
    )


def is_orbit_preserving_map(L, phi_keys):
    """def_orbit_preserving_permutation: 任意の tau で phi(tau) in O(tau) か。"""
    return all(phi_keys[key] in orbit_of_key(L, key) for key in row_matrix_keys(L))


def orbit_preserving_permutations_by_enumeration(L):
    """S^O_L を S_L の全列挙から絞って得る（組み立てを前提にしない）。キーの辞書で返す。"""
    result = []
    for phi in row_permutations(L):
        as_keys = {
            key: row_config_key(L, apply_row_permutation(L, phi, row_config_from_key(key)))
            for key in row_matrix_keys(L)
        }
        if is_orbit_preserving_map(L, as_keys):
            result.append(as_keys)
    return result


def less_keys(L, key_1, key_2):
    """def_row_config_order の tau ≺ tau' を、キー表現のまま判定する。"""
    return row_config_less(L, row_config_from_key(key_1), row_config_from_key(key_2))


def ordered_pair_keys(L):
    """def_inversion_count: P_L をキーの対で持つ。"""
    keys = row_matrix_keys(L)
    return [
        (key_1, key_2) for key_1 in keys for key_2 in keys if less_keys(L, key_1, key_2)
    ]


def inversion_pairs(L, phi, pairs):
    """def_inversion_pairs: Inv(phi) = { (tau,tau') in P_L | phi(tau') ≺ phi(tau) }。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in pairs
        if less_keys(L, phi[key_2], phi[key_1])
    }


def inversion_count(L, phi, pairs):
    """def_inversion_count: inv(phi) = |Inv(phi)|。"""
    return len(inversion_pairs(L, phi, pairs))


def cross_ordered_pairs(L, o_1, o_2):
    """def_cross_orbit_ordered_pairs: F(O,O') = { (tau,tau') in O x O' | tau ≺ tau' }。"""
    return {
        (key_1, key_2)
        for key_1 in sorted(o_1)
        for key_2 in sorted(o_2)
        if less_keys(L, key_1, key_2)
    }


def orbit_inversion_count(L, phi, o):
    """def_orbit_inversion_count: inv_O(psi)。psi は phi の O への制限として与える。

    本文の定義どおり、台は F(O,O) であり、順序は R_L の上の ≺ をそのまま使う。
    """
    return len({
        (key_1, key_2)
        for (key_1, key_2) in cross_ordered_pairs(L, o, o)
        if less_keys(L, phi[key_2], phi[key_1])
    })


def cross_orbit_inversion_pairs(L, phi, pairs):
    """def_cross_orbit_inversion_pairs: Inv^≠(phi)。2 成分の軌道が相異なるもの。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in inversion_pairs(L, phi, pairs)
        if orbit_of_key(L, key_1) != orbit_of_key(L, key_2)
    }


def inner_inversion_pairs(L, phi, o, pairs):
    """人手証明の A(O) = { (tau,tau') in Inv(phi) | tau in O かつ tau' in O }。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in inversion_pairs(L, phi, pairs)
        if key_1 in o and key_2 in o
    }


def same_orbit_inversion_pairs(L, phi, pairs):
    """人手証明の Inv^=(phi)（証明の中だけで使う記号）。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in inversion_pairs(L, phi, pairs)
        if orbit_of_key(L, key_1) == orbit_of_key(L, key_2)
    }


def cross_inversions(L, phi, o_1, o_2, pairs):
    """前のセクションの def_cross_orbit_inversions: J_phi(O,O')。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in pairs
        if ((key_1 in o_1 and key_2 in o_2) or (key_1 in o_2 and key_2 in o_1))
        and less_keys(L, phi[key_2], phi[key_1])
    }


def check_definitions_are_subsets(L, perms, orbits, pairs):
    """0: 3 つの定義が本文の言うとおりの台の部分集合であること。"""
    pair_set = set(pairs)
    for phi in perms:
        inv = inversion_pairs(L, phi, pairs)
        assert inv <= pair_set, (L, 'Inv(phi) が P_L からはみ出した')
        assert cross_orbit_inversion_pairs(L, phi, pairs) <= inv, (
            L, 'Inv^≠(phi) が Inv(phi) からはみ出した')
        for o in orbits:
            product = {(a, b) for a in o for b in o}
            assert cross_ordered_pairs(L, o, o) <= product, (
                L, 'F(O,O) が O x O からはみ出した')
            assert inner_inversion_pairs(L, phi, o, pairs) <= cross_ordered_pairs(L, o, o), (
                L, '軌道の中の転倒対が F(O,O) からはみ出した')
    print(f'OK: L={L} で Inv・Inv^≠・軌道の中の転倒対はいずれも台の部分集合'
          f'（置換 {len(perms)} 個 x 軌道 {len(orbits)} 個）')


def check_inner_is_restriction_inversions(L, perms, orbits, pairs):
    """1: claim_orbit_inner_inversion_pairs。集合の等号として確かめる。"""
    for phi in perms:
        for o in orbits:
            left = inner_inversion_pairs(L, phi, o, pairs)
            right = {
                (key_1, key_2)
                for (key_1, key_2) in cross_ordered_pairs(L, o, o)
                if less_keys(L, phi[key_2], phi[key_1])
            }
            assert left == right, (L, '軌道の中の転倒対が制限の転倒対と一致しない')
            assert len(left) == orbit_inversion_count(L, phi, o), (
                L, '個数が inv_O(phi|_O) と一致しない')
    print(f'OK: L={L} で軌道の中の転倒対の集合 = 制限の転倒対の集合、個数 = inv_O(phi|_O)'
          f'（置換 {len(perms)} 個 x 軌道 {len(orbits)} 個。個数ではなく集合の等号で確認）')


def check_decomposition(L, perms, orbits, pairs):
    """2: claim_inversion_count_orbit_decomposition。中間段も別々に確かめる。"""
    for phi in perms:
        inv = inversion_pairs(L, phi, pairs)
        same = same_orbit_inversion_pairs(L, phi, pairs)
        cross = cross_orbit_inversion_pairs(L, phi, pairs)
        # Step 1: Inv = Inv^= ⊔ Inv^≠。
        assert same | cross == inv, (L, 'Inv^= と Inv^≠ の合併が Inv でない')
        assert not (same & cross), (L, 'Inv^= と Inv^≠ が交わっている')
        # Step 2: Inv^= = ⊔_O A(O)、および A(O) たちが互いに素であること。
        union = set()
        for o in orbits:
            union |= inner_inversion_pairs(L, phi, o, pairs)
        assert union == same, (L, 'A(O) の合併が Inv^= でない')
        for o_1 in orbits:
            for o_2 in orbits:
                if o_1 == o_2:
                    continue
                assert not (inner_inversion_pairs(L, phi, o_1, pairs)
                            & inner_inversion_pairs(L, phi, o_2, pairs)), (
                    L, 'A(O_1) と A(O_2) が交わっている')
        # Step 3: 個数の等式。
        total = sum(orbit_inversion_count(L, phi, o) for o in orbits)
        assert inversion_count(L, phi, pairs) == total + len(cross), (
            L, 'inv(phi) = sum_O inv_O + |Inv^≠| が破れた')
    print(f'OK: L={L} で inv(phi) = sum_O inv_O(phi|_O) + |Inv^≠(phi)|'
          f'（置換 {len(perms)} 個。Step 1・Step 2 の分割と互いに素であることを別々に確認）')


def check_cross_is_union_of_pairwise(L, perms, orbits, pairs):
    """4: Inv^≠(phi) が J_phi(O,O') の（非順序対にわたる）合併であること。

    次のセクションで |Inv^≠(phi)| の偶数性を出すときの足場であり、
    **これは検証であって証明ではない。**
    """
    for phi in perms:
        union = set()
        for i in range(len(orbits)):
            for j in range(i + 1, len(orbits)):
                union |= cross_inversions(L, phi, orbits[i], orbits[j], pairs)
        assert union == cross_orbit_inversion_pairs(L, phi, pairs), (
            L, 'J_phi(O,O\') の合併が Inv^≠(phi) と一致しない')
    print(f'OK: L={L} で Inv^≠(phi) は J_phi(O,O\') の相異なる軌道の対にわたる合併'
          '（次のセクションの足場。検証であって証明ではない）')


def check_not_vacuous(L, perms, orbits, pairs):
    """3: 主張が空でないこと。返すのは (Inv^≠ が空でない例, inv_O が 0 でない例)。"""
    cross_nonempty = False
    inner_nonzero = False
    for phi in perms:
        if cross_orbit_inversion_pairs(L, phi, pairs):
            cross_nonempty = True
        for o in orbits:
            if orbit_inversion_count(L, phi, o) > 0:
                inner_nonzero = True
    return cross_nonempty, inner_nonzero


def main():
    cross_found_anywhere = False
    inner_found_anywhere = False
    for L in [1, 2, 3]:
        perms = orbit_preserving_permutations_by_enumeration(L)
        orbits = orbit_set(L)
        pairs = ordered_pair_keys(L)
        check_definitions_are_subsets(L, perms, orbits, pairs)
        check_inner_is_restriction_inversions(L, perms, orbits, pairs)
        check_decomposition(L, perms, orbits, pairs)
        check_cross_is_union_of_pairwise(L, perms, orbits, pairs)
        cross_nonempty, inner_nonzero = check_not_vacuous(L, perms, orbits, pairs)
        if cross_nonempty:
            cross_found_anywhere = True
        if inner_nonzero:
            inner_found_anywhere = True
        print(f'記録: L={L} で Inv^≠(phi) が空でない例は'
              f'{"ある" if cross_nonempty else "無い"}、'
              f'inv_O(phi|_O) が 0 でない例は{"ある" if inner_nonzero else "無い"}'
              '（どちらも無い L では等式は 0 = 0 + 0 を見ているだけである）')
    assert cross_found_anywhere, 'Inv^≠(phi) がつねに空（またぐ項が空虚）'
    assert inner_found_anywhere, 'inv_O(phi|_O) がつねに 0（軌道ごとの項が空虚）'
    print('（L=4 は S_L の全列挙（16! 通り）ができないので走らせていない）')
    print('すべての検証が通った（転倒数の軌道ごとの分解）')


main()
