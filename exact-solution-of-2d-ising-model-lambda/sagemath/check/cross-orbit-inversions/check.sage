# 対象ラベル: def_cross_orbit_ordered_pairs / def_cross_orbit_ordered_pairs_image /
#             def_cross_orbit_inversions / claim_cross_orbit_ordered_card /
#             claim_cross_orbit_inversions_even
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した、
# 2 つの軌道にまたがる転倒対についての 2 主張を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と数え上げであり、浮動小数点は使わない。
#
# 何を確かめるか:
#   0. 定義が実装と合っていること。F(O,O') と F_phi(O,O') が O x O' の部分集合であること、
#      J_phi(O,O') が P_L の部分集合であること。
#      **これを別に確かめる理由**: 下の 1・2 は個数の等式なので、集合の取り違え
#      （たとえば第 1 成分と第 2 成分の入れ替え）が個数の一致に隠れて検出できない。
#   1. claim_cross_orbit_ordered_card。|F_phi(O,O')| = |F(O,O')|。
#      人手証明は写像 Upsilon(tau,tau') = (phi(tau), phi(tau')) が F_phi から F への
#      全単射であることで示すので、**個数だけでなく Upsilon が実際にその対応を与えることも**
#      確かめる（個数の一致だけでは、対応の作り方の誤りが隠れる）。
#   2. claim_cross_orbit_inversions_even。O != O' のとき
#      |J_phi(O,O')| = 2 * |F(O,O') \ F_phi(O,O')| であり、とくに偶数であること。
#      人手証明の中間段（J_1 = F \ F_phi、J_2 が sw で F_phi \ F と 1 対 1、
#      |F \ F_phi| = |F_phi \ F|）も別々に確かめる。最終の等式だけを見ると、
#      2 つの中間段が両方誤っていて辻褄が合う場合を見逃す。
#   3. O = O' のときは主張が成り立つとは限らないこと（本文が述べている限定の裏取り）。
#      J_phi(O,O) が奇数になる例が実際にあることを見る。
#   4. 主張が空でないこと。J_phi(O,O') が 0 でない例、F \ F_phi が空でない例があること。
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
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。

    反復は高々 L 回でもとへ戻る（claim_row_config_shift_period）ので k を 0..L-1 で足りる。
    """
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


def cross_ordered_pairs(L, o_1, o_2):
    """def_cross_orbit_ordered_pairs: F(O,O') = { (tau,tau') in O x O' | tau ≺ tau' }。"""
    return {
        (key_1, key_2)
        for key_1 in sorted(o_1)
        for key_2 in sorted(o_2)
        if less_keys(L, key_1, key_2)
    }


def cross_ordered_pairs_image(L, phi, o_1, o_2):
    """def_cross_orbit_ordered_pairs_image: F_phi(O,O') = { (tau,tau') | phi(tau) ≺ phi(tau') }。"""
    return {
        (key_1, key_2)
        for key_1 in sorted(o_1)
        for key_2 in sorted(o_2)
        if less_keys(L, phi[key_1], phi[key_2])
    }


def cross_inversions(L, phi, o_1, o_2, pairs=None):
    """def_cross_orbit_inversions: J_phi(O,O')。P_L の側から定義どおりに絞る。"""
    if pairs is None:
        pairs = ordered_pair_keys(L)
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
        for o_1 in orbits:
            for o_2 in orbits:
                f = cross_ordered_pairs(L, o_1, o_2)
                f_phi = cross_ordered_pairs_image(L, phi, o_1, o_2)
                product = {(a, b) for a in o_1 for b in o_2}
                assert f <= product, (L, 'F(O,O\') が O x O\' からはみ出した')
                assert f_phi <= product, (L, 'F_phi(O,O\') が O x O\' からはみ出した')
                j = cross_inversions(L, phi, o_1, o_2, pairs)
                assert j <= pair_set, (L, 'J_phi(O,O\') が P_L からはみ出した')
                # F(O,O') は P_L の部分集合でもある（本文が述べている包含）。
                assert f <= pair_set, (L, 'F(O,O\') が P_L からはみ出した')
    print(f'OK: L={L} で F・F_phi は O x O\' の、J_phi と F は P_L の部分集合'
          f'（置換 {len(perms)} 個 x 軌道の対 {len(orbits) ** 2} 通り）')


def check_ordered_card(L, perms, orbits):
    """1: claim_cross_orbit_ordered_card。Upsilon が与える対応も別に見る。"""
    for phi in perms:
        for o_1 in orbits:
            for o_2 in orbits:
                f = cross_ordered_pairs(L, o_1, o_2)
                f_phi = cross_ordered_pairs_image(L, phi, o_1, o_2)
                # 人手証明の Upsilon(tau,tau') = (phi(tau), phi(tau'))。
                upsilon = {(a, b): (phi[a], phi[b]) for a in o_1 for b in o_2}
                # Upsilon が O x O' の中へ入ること（claim_orbit_preserving_image による）。
                for (a, b), image in upsilon.items():
                    assert image[0] in o_1 and image[1] in o_2, (
                        L, 'Upsilon の値が O x O\' からはみ出した')
                # Upsilon が単射（したがって有限集合の上で全単射）であること。
                assert len(set(upsilon.values())) == len(upsilon), (L, 'Upsilon が単射でない')
                # Upsilon が F_phi を F の上へ写すこと（両向き）。
                assert {upsilon[p] for p in f_phi} == f, (
                    L, 'Upsilon が F_phi を F の上へ写していない')
                assert len(f_phi) == len(f), (L, '|F_phi| != |F|')
    print(f'OK: L={L} で |F_phi(O,O\')| = |F(O,O\')|'
          f'（置換 {len(perms)} 個 x 軌道の対 {len(orbits) ** 2} 通り。Upsilon の対応も確認）')


def check_inversions_even(L, perms, orbits, pairs):
    """2: claim_cross_orbit_inversions_even。中間段も別々に見る。"""
    for phi in perms:
        for o_1 in orbits:
            for o_2 in orbits:
                if o_1 == o_2:
                    continue
                assert not (o_1 & o_2), (L, '相異なる軌道が交わった')
                f = cross_ordered_pairs(L, o_1, o_2)
                f_phi = cross_ordered_pairs_image(L, phi, o_1, o_2)
                j = cross_inversions(L, phi, o_1, o_2, pairs)
                # 人手証明の J_1 と J_2。
                j_1 = {(a, b) for (a, b) in j if a in o_1 and b in o_2}
                j_2 = {(a, b) for (a, b) in j if a in o_2 and b in o_1}
                assert j_1 | j_2 == j and not (j_1 & j_2), (L, 'J_1 と J_2 が J の分割でない')
                assert j_1 == f - f_phi, (L, 'J_1 != F \\ F_phi')
                # sw による 1 対 1 対応。
                assert {(b, a) for (a, b) in j_2} == f_phi - f, (
                    L, 'sw が J_2 を F_phi \\ F の上へ写していない')
                assert len(f - f_phi) == len(f_phi - f), (L, '|F \\ F_phi| != |F_phi \\ F|')
                assert len(j) == 2 * len(f - f_phi), (L, '|J| != 2|F \\ F_phi|')
                assert len(j) % 2 == 0, (L, '|J| が奇数')
    print(f'OK: L={L} で O != O\' のとき |J_phi(O,O\')| = 2|F \\ F_phi| で偶数'
          f'（置換 {len(perms)} 個。J_1・J_2・sw の対応・2 つの差の個数を別々に確認）')


def check_same_orbit_can_be_odd(L, perms, orbits, pairs):
    """3: O = O' では偶数とは限らないこと（本文の限定の裏取り）。"""
    found = False
    for phi in perms:
        for o in orbits:
            j = cross_inversions(L, phi, o, o, pairs)
            if len(j) % 2 == 1:
                found = True
    return found


def check_not_vacuous(L, perms, orbits, pairs):
    """4: 主張が空でないこと。"""
    nonzero = False
    for phi in perms:
        for o_1 in orbits:
            for o_2 in orbits:
                if o_1 == o_2:
                    continue
                j = cross_inversions(L, phi, o_1, o_2, pairs)
                if len(j) > 0:
                    nonzero = True
    return nonzero


def check_vacuity_profile(L, perms, orbits):
    """5: どの L で偶数性の検証に中身があるかを記録する。

    偶数性の等式は |J| = 2|F \\ F_phi| なので、両辺が 0 の場合は 0 = 2*0 を見ているだけで
    何も確かめていない。どの L がその「空虚な場合しか見ていない」側なのかを、
    overview.md の散文ではなく実行で確定させる（走らせた範囲の打ち切りを隠さないため）。

    返すのは (偶数性が空虚でない例があるか, |F_phi| = |F| が空虚でない例があるか)。
    """
    even_has_content = False
    ordered_has_content = False
    for phi in perms:
        for o_1 in orbits:
            for o_2 in orbits:
                if cross_ordered_pairs(L, o_1, o_2):
                    ordered_has_content = True
                if o_1 == o_2:
                    continue
                if cross_inversions(L, phi, o_1, o_2):
                    even_has_content = True
    return even_has_content, ordered_has_content


def main():
    odd_found_anywhere = False
    nonzero_found_anywhere = False
    for L in [1, 2, 3]:
        perms = orbit_preserving_permutations_by_enumeration(L)
        orbits = orbit_set(L)
        pairs = ordered_pair_keys(L)
        check_definitions_are_subsets(L, perms, orbits, pairs)
        check_ordered_card(L, perms, orbits)
        check_inversions_even(L, perms, orbits, pairs)
        if check_same_orbit_can_be_odd(L, perms, orbits, pairs):
            odd_found_anywhere = True
            print(f'OK: L={L} で O = O\' のときは |J_phi(O,O)| が奇数になる例がある'
                  '（相異なることの仮定が効いている）')
        if check_not_vacuous(L, perms, orbits, pairs):
            nonzero_found_anywhere = True
            print(f'OK: L={L} で |J_phi(O,O\')| > 0 となる例がある（主張が空でない）')
        even_has_content, ordered_has_content = check_vacuity_profile(L, perms, orbits)
        assert ordered_has_content, (L, '|F_phi| = |F| の検証まで空虚になっている')
        if even_has_content:
            print(f'記録: L={L} の偶数性の検証には中身がある（|J| > 0 の場合を見ている）')
        else:
            print(f'記録: L={L} の偶数性の検証は空虚な場合しか見ていない'
                  '（相異なる軌道にまたがる転倒対がつねに空で、0 = 2*0 を確かめている）。'
                  'ただし |F_phi| = |F| の検証は空虚ではない')
    assert odd_found_anywhere, 'O = O\' で奇数になる例が 1 つも無い（限定の裏取りができていない）'
    assert nonzero_found_anywhere, 'J_phi(O,O\') がつねに空（主張が空虚）'
    print('（L=4 は S_L の全列挙（16! 通り）ができないので走らせていない）')
    print('すべての検証が通った（2 つの軌道にまたがる転倒対）')


main()
