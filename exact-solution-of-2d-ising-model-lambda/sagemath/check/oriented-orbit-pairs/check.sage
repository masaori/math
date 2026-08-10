# 対象ラベル: def_oriented_orbit_pairs / claim_oriented_orbit_pairs_cross_disjoint /
#             claim_cross_orbit_inversion_pairs_union / claim_cross_orbit_inversion_pairs_even
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した、
# またぐ転倒対の全体 Inv^≠(phi) の個数が偶数であることを、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と数え上げであり、浮動小数点は使わない。
#
# 何を確かめるか:
#   0. 定義が実装と合っていること。D_L の元が O_L x O_L の元であり、第 1 成分と第 2 成分が
#      相異なること。また、相異なる軌道の順序対 (O,O') と (O',O) のうちちょうど一方が
#      D_L に属すること（半分に分ける道具として使えること）。
#      **これを別に確かめる理由**: 下の 3 は個数の等式なので、D_L の取り違え（多すぎる／
#      少なすぎる）が 2 倍という形に紛れて検出できない場合がある。
#   1. claim_oriented_orbit_pairs_cross_disjoint。D_L の相異なる 2 元が与える J_phi が交わらないこと。
#   2. claim_cross_orbit_inversion_pairs_union。Inv^≠(phi) が D_L にわたる J_phi の合併であること。
#      人手証明は集合の等号を示しているので、検証も個数ではなく集合の等号で見る。
#   3. claim_cross_orbit_inversion_pairs_even。
#      |Inv^≠(phi)| = 2 * sum_{(O,O') in D_L} |F(O,O') \ F_phi(O,O')|。
#      中間の和 sum |J_phi(O,O')| も別に確かめる（最終の等式だけを見ると、合併の段と
#      対ごとの偶数性の段が両方誤っていて辻褄が合う場合を見逃す）。
#   4. 主張が空でないこと。走らせた L ごとに、Inv^≠(phi) が空でない例があるか、
#      D_L が空でないかを記録する。どちらも無い L では等式は 0 = 2*0 を見ているだけである。
#
# 走らせる L の範囲について。
#   軌道を保つ置換 S^O_L は S_L の全列挙から絞って作るので（軌道ごとの置換から組み立てると、
#   その組み立てが前のセクションの主張になっており循環する）、(2^L)! が総当たりできる
#   L = 1, 2, 3 に限る。L = 4 では 16! 通りで走らせられない。この打ち切りは overview.md にも書く。
#   D_L の性質（上の 0）は置換を走らせないので L = 1, ..., 5 まで走らせる。

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


def less(L, key_1, key_2):
    """def_row_config_order: tau ≺ tau'（キーで受ける）。"""
    return row_config_less(L, row_config_from_key(key_1), row_config_from_key(key_2))


def is_min(L, subset, key_0):
    """claim_row_config_min_unique の条件そのもの。"""
    if key_0 not in subset:
        return False
    return all(key == key_0 or less(L, key_0, key) for key in subset)


def row_config_min(L, subset):
    """def_row_config_min: mu(X)。条件を満たす元がちょうど 1 つであることを使う。"""
    found = [key for key in subset if is_min(L, subset, key)]
    assert len(found) == 1, 'mu(X) が定まらない（最小元がちょうど 1 つでない）'
    return found[0]


def oriented_orbit_pairs(L, orbits):
    """def_oriented_orbit_pairs: D_L = { (O,O') in O_L x O_L | mu(O) ≺ mu(O') }。"""
    return [
        (o_1, o_2)
        for o_1 in orbits
        for o_2 in orbits
        if less(L, row_config_min(L, o_1), row_config_min(L, o_2))
    ]


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


def ordered_pair_keys(L):
    """def_inversion_count: P_L をキーの対で持つ。"""
    keys = row_matrix_keys(L)
    return [
        (key_1, key_2) for key_1 in keys for key_2 in keys if less(L, key_1, key_2)
    ]


def inversion_pairs(L, phi, pairs):
    """def_inversion_pairs: Inv(phi) = { (tau,tau') in P_L | phi(tau') ≺ phi(tau) }。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in pairs
        if less(L, phi[key_2], phi[key_1])
    }


def cross_orbit_inversion_pairs(L, phi, pairs):
    """def_cross_orbit_inversion_pairs: Inv^≠(phi)。2 成分の軌道が相異なるもの。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in inversion_pairs(L, phi, pairs)
        if orbit_of_key(L, key_1) != orbit_of_key(L, key_2)
    }


def cross_inversions(L, phi, o_1, o_2, pairs):
    """def_cross_orbit_inversions: J_phi(O,O')。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in pairs
        if ((key_1 in o_1 and key_2 in o_2) or (key_1 in o_2 and key_2 in o_1))
        and less(L, phi[key_2], phi[key_1])
    }


def cross_ordered_pairs(L, o_1, o_2):
    """def_cross_orbit_ordered_pairs: F(O,O') = { (tau,tau') in O x O' | tau ≺ tau' }。"""
    return {
        (key_1, key_2)
        for key_1 in sorted(o_1)
        for key_2 in sorted(o_2)
        if less(L, key_1, key_2)
    }


def cross_ordered_pairs_image(L, phi, o_1, o_2):
    """def_cross_orbit_ordered_pairs_image: F_phi(O,O')。"""
    return {
        (key_1, key_2)
        for key_1 in sorted(o_1)
        for key_2 in sorted(o_2)
        if less(L, phi[key_1], phi[key_2])
    }


def check_oriented_pairs_definition(L, orbits):
    """0: D_L の定義が本文の言うとおりであること（置換を走らせない）。"""
    d_l = oriented_orbit_pairs(L, orbits)
    orbit_pairs = {(o_1, o_2) for o_1 in orbits for o_2 in orbits}
    for (o_1, o_2) in d_l:
        assert (o_1, o_2) in orbit_pairs, (L, 'D_L の元が O_L x O_L からはみ出した')
        assert o_1 != o_2, (L, 'D_L の元の 2 成分が一致した')
    # 相異なる軌道の順序対はちょうど一方が D_L に属する（半分に分ける道具になっている）。
    for o_1 in orbits:
        for o_2 in orbits:
            if o_1 == o_2:
                assert (o_1, o_2) not in d_l, (L, '(O,O) が D_L に入った')
                continue
            forward = (o_1, o_2) in d_l
            backward = (o_2, o_1) in d_l
            assert forward != backward, (L, '相異なる軌道の順序対の一方だけが D_L に入っていない')
    print(f'OK: L={L} で D_L は O_L x O_L の部分集合で 2 成分が相異なり、'
          f'相異なる軌道の順序対のちょうど一方を含む（軌道 {len(orbits)} 個、D_L の元 {len(d_l)} 個）')


def check_cross_inversions_disjoint(L, perms, orbits, pairs):
    """1: claim_oriented_orbit_pairs_cross_disjoint。"""
    d_l = oriented_orbit_pairs(L, orbits)
    for phi in perms:
        for i in range(len(d_l)):
            for j in range(len(d_l)):
                if i == j:
                    continue
                left = cross_inversions(L, phi, d_l[i][0], d_l[i][1], pairs)
                right = cross_inversions(L, phi, d_l[j][0], d_l[j][1], pairs)
                assert not (left & right), (L, 'D_L の相異なる 2 元の J_phi が交わった')
    print(f'OK: L={L} で D_L の相異なる 2 元が与える J_phi は交わらない'
          f'（置換 {len(perms)} 個 x D_L の対 {len(d_l)}^2 通り）')


def check_cross_inversions_union(L, perms, orbits, pairs):
    """2: claim_cross_orbit_inversion_pairs_union。集合の等号として確かめる。"""
    d_l = oriented_orbit_pairs(L, orbits)
    for phi in perms:
        union = set()
        for (o_1, o_2) in d_l:
            union |= cross_inversions(L, phi, o_1, o_2, pairs)
        assert union == cross_orbit_inversion_pairs(L, phi, pairs), (
            L, 'D_L にわたる J_phi の合併が Inv^≠(phi) と一致しない')
    print(f'OK: L={L} で Inv^≠(phi) = ∪_{{(O,O\') in D_L}} J_phi(O,O\')'
          f'（置換 {len(perms)} 個。個数ではなく集合の等号で確認）')


def check_cross_inversions_even(L, perms, orbits, pairs):
    """3: claim_cross_orbit_inversion_pairs_even。中間の和も別に確かめる。"""
    d_l = oriented_orbit_pairs(L, orbits)
    for phi in perms:
        cross = cross_orbit_inversion_pairs(L, phi, pairs)
        sum_j = sum(
            len(cross_inversions(L, phi, o_1, o_2, pairs)) for (o_1, o_2) in d_l
        )
        assert len(cross) == sum_j, (L, '|Inv^≠(phi)| が J_phi の個数の和と一致しない')
        sum_sdiff = sum(
            len(cross_ordered_pairs(L, o_1, o_2) - cross_ordered_pairs_image(L, phi, o_1, o_2))
            for (o_1, o_2) in d_l
        )
        assert len(cross) == 2 * sum_sdiff, (
            L, '|Inv^≠(phi)| = 2 * sum |F \\ F_phi| が破れた')
        assert len(cross) % 2 == 0, (L, '|Inv^≠(phi)| が奇数になった')
    print(f'OK: L={L} で |Inv^≠(phi)| = sum |J_phi| = 2 * sum |F \\ F_phi|'
          f'（置換 {len(perms)} 個。中間の和を別に確認）')


def check_not_vacuous(L, perms, orbits, pairs):
    """4: 主張が空でないこと。D_L が空でないか、Inv^≠ が空でない例があるかを返す。"""
    d_l = oriented_orbit_pairs(L, orbits)
    cross_nonempty = any(
        cross_orbit_inversion_pairs(L, phi, pairs) for phi in perms
    )
    return len(d_l) > 0, cross_nonempty


def main():
    for L in [1, 2, 3, 4, 5]:
        check_oriented_pairs_definition(L, orbit_set(L))

    cross_found_anywhere = False
    for L in [1, 2, 3]:
        perms = orbit_preserving_permutations_by_enumeration(L)
        orbits = orbit_set(L)
        pairs = ordered_pair_keys(L)
        check_cross_inversions_disjoint(L, perms, orbits, pairs)
        check_cross_inversions_union(L, perms, orbits, pairs)
        check_cross_inversions_even(L, perms, orbits, pairs)
        d_nonempty, cross_nonempty = check_not_vacuous(L, perms, orbits, pairs)
        if cross_nonempty:
            cross_found_anywhere = True
        print(f'記録: L={L} で D_L は{"空でない" if d_nonempty else "空"}、'
              f'Inv^≠(phi) が空でない例は{"ある" if cross_nonempty else "無い"}'
              '（後者が無い L では等式は 0 = 2*0 を見ているだけである）')
    assert cross_found_anywhere, 'Inv^≠(phi) がつねに空（主張が空虚）'
    print('（置換を走らせる検証で L=4 以上は S_L の全列挙（16! 通り）ができないので走らせていない）')
    print('すべての検証が通った（またぐ転倒対の全体の個数の偶数性）')


main()
