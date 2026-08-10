# 対象ラベル: def_orbit_permutation_sign / claim_permutation_sign_orbit_product
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した、
# 軌道を保つ置換の符号が軌道ごとの符号の積であることを、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と数え上げ、および整数の積であり、浮動小数点は使わない。
#
# 何を確かめるか:
#   0. 定義が本文どおりであること。sgn_O(psi) = (-1)^{inv_O(psi)} であり、値が +1 か -1 で
#      あること。加えて、sgn_O(phi|_O) が O の中での phi の値だけで決まること
#      （O の外の値を書き換えても変わらないこと）。
#      **これを別に確かめる理由**: 積の等式は符号の積なので、O の外の値が紛れ込んでいても
#      たまたま積が合ってしまう場合がある。
#   1. claim_permutation_sign_orbit_product。sgn(phi) = prod_O sgn_O(phi|_O)。
#   2. 人手証明の式変形の各段を別々に確かめる。最終の等式だけを見ると、複数の段が
#      同時に誤っていて辻褄が合う場合を見逃す。段は次の 3 つである。
#        (a) (-1)^{inv(phi)} = (-1)^{sum_O inv_O + |Inv^≠|}（転倒数の分解）
#        (b) (-1)^{|Inv^≠(phi)|} = 1（またぐ項の偶数性。ここが効いている）
#        (c) (-1)^{sum_O inv_O} = prod_O (-1)^{inv_O}（有限和を指数とする冪は冪の積）
#   3. 主張が空でないこと。走らせた L ごとに、sgn(phi) = -1 となる例、軌道ごとの符号が
#      -1 となる例、|Inv^≠(phi)| > 0 となる例があるかを記録する。
#      **とくに 3 つめが無い L では、(b) の段は 0 が偶数であることしか見ていない。**
#
# 走らせる L の範囲について。
#   軌道を保つ置換 S^O_L は S_L の全列挙から絞って作るので（軌道ごとの置換から組み立てると、
#   その組み立てが前のセクションの主張になっており循環する）、(2^L)! が総当たりできる
#   L = 1, 2, 3 に限る。L = 4 では 16! 通りで走らせられない。この打ち切りは overview.md にも書く。

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


def inversion_count(L, phi, pairs):
    """def_inversion_count: inv(phi) = |Inv(phi)|。"""
    return len(inversion_pairs(L, phi, pairs))


def permutation_sign(L, phi, pairs):
    """def_permutation_sign: sgn(phi) = (-1)^{inv(phi)}。"""
    return (-1) ** inversion_count(L, phi, pairs)


def cross_orbit_inversion_pairs(L, phi, pairs):
    """def_cross_orbit_inversion_pairs: Inv^≠(phi)。2 成分の軌道が相異なるもの。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in inversion_pairs(L, phi, pairs)
        if orbit_of_key(L, key_1) != orbit_of_key(L, key_2)
    }


def cross_ordered_pairs(L, o_1, o_2):
    """def_cross_orbit_ordered_pairs: F(O,O') = { (tau,tau') in O x O' | tau ≺ tau' }。"""
    return {
        (key_1, key_2)
        for key_1 in sorted(o_1)
        for key_2 in sorted(o_2)
        if less(L, key_1, key_2)
    }


def orbit_inversion_count(L, phi, o):
    """def_orbit_inversion_count: inv_O(phi|_O)。台は F(O,O)、順序は R_L の ≺。"""
    return len({
        (key_1, key_2)
        for (key_1, key_2) in cross_ordered_pairs(L, o, o)
        if less(L, phi[key_2], phi[key_1])
    })


def orbit_permutation_sign(L, phi, o):
    """def_orbit_permutation_sign: sgn_O(phi|_O) = (-1)^{inv_O(phi|_O)}。"""
    return (-1) ** orbit_inversion_count(L, phi, o)


def check_orbit_sign_definition(L, perms, orbits):
    """0: sgn_O の定義が本文どおりで、O の外の値に依らないこと。"""
    keys = row_matrix_keys(L)
    for phi in perms:
        for o in orbits:
            value = orbit_permutation_sign(L, phi, o)
            assert value in (1, -1), (L, 'sgn_O(phi|_O) が ±1 でない')
            assert value == (-1) ** orbit_inversion_count(L, phi, o), (
                L, 'sgn_O が (-1)^{inv_O} と一致しない')
            # O の外の値を（O の中の値はそのままに）別の置換のものへ差し替える。
            for other in perms:
                modified = {
                    key: (phi[key] if key in o else other[key]) for key in keys
                }
                assert orbit_permutation_sign(L, modified, o) == value, (
                    L, 'sgn_O が O の外の値に依存した')
    print(f'OK: L={L} で sgn_O は ±1 の値を取り、O の中の値だけで決まる'
          f'（置換 {len(perms)} 個 x 軌道 {len(orbits)} 個 x 差し替え {len(perms)} 通り）')


def check_sign_orbit_product(L, perms, orbits, pairs):
    """1 と 2: 積の等式と、人手証明の各段を別々に確かめる。"""
    for phi in perms:
        total = sum(orbit_inversion_count(L, phi, o) for o in orbits)
        cross = len(cross_orbit_inversion_pairs(L, phi, pairs))
        # (a) 転倒数の分解（前のセクションの主張。ここでは代入の段として見る）。
        assert inversion_count(L, phi, pairs) == total + cross, (
            L, 'inv(phi) = sum_O inv_O + |Inv^≠| が破れた')
        # (b) またぐ項が (-1) の冪に効かないこと。
        assert cross % 2 == 0, (L, '|Inv^≠(phi)| が奇数になった')
        assert (-1) ** cross == 1, (L, '(-1)^{|Inv^≠(phi)|} が 1 でない')
        # (c) 有限和を指数とする冪は冪の積である。
        product = 1
        for o in orbits:
            product *= orbit_permutation_sign(L, phi, o)
        assert (-1) ** total == product, (
            L, '(-1)^{sum_O inv_O} が prod_O (-1)^{inv_O} と一致しない')
        # 1: 主張そのもの。
        assert permutation_sign(L, phi, pairs) == product, (
            L, 'sgn(phi) = prod_O sgn_O(phi|_O) が破れた')
    print(f'OK: L={L} で sgn(phi) = prod_O sgn_O(phi|_O)'
          f'（置換 {len(perms)} 個。式変形の 3 段 (a)(b)(c) を別々に確認）')


def check_not_vacuous(L, perms, orbits, pairs):
    """3: 主張が空でないこと。3 つの記録を返す。"""
    sign_negative = any(permutation_sign(L, phi, pairs) == -1 for phi in perms)
    factor_negative = any(
        orbit_permutation_sign(L, phi, o) == -1 for phi in perms for o in orbits
    )
    cross_nonempty = any(
        cross_orbit_inversion_pairs(L, phi, pairs) for phi in perms
    )
    return sign_negative, factor_negative, cross_nonempty


def main():
    sign_found = False
    factor_found = False
    cross_found = False
    for L in [1, 2, 3]:
        perms = orbit_preserving_permutations_by_enumeration(L)
        orbits = orbit_set(L)
        pairs = ordered_pair_keys(L)
        check_orbit_sign_definition(L, perms, orbits)
        check_sign_orbit_product(L, perms, orbits, pairs)
        neg, factor, cross = check_not_vacuous(L, perms, orbits, pairs)
        sign_found = sign_found or neg
        factor_found = factor_found or factor
        cross_found = cross_found or cross
        print(f'記録: L={L} で sgn(phi) = -1 の例は{"ある" if neg else "無い"}、'
              f'sgn_O(phi|_O) = -1 の例は{"ある" if factor else "無い"}、'
              f'|Inv^≠(phi)| > 0 の例は{"ある" if cross else "無い"}'
              '（最後が無い L では、またぐ項の偶数性は 0 が偶数であることしか見ていない）')
    assert sign_found, 'sgn(phi) がつねに +1（主張が空虚）'
    assert factor_found, 'sgn_O(phi|_O) がつねに +1（積の各因子が空虚）'
    assert cross_found, '|Inv^≠(phi)| がつねに 0（またぐ項の偶数性が空虚）'
    print('（置換を走らせる検証で L=4 以上は S_L の全列挙（16! 通り）ができないので走らせていない）')
    print('すべての検証が通った（軌道を保つ置換の符号は軌道ごとの符号の積である）')


main()
