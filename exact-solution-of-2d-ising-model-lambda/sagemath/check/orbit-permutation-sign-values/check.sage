# 対象ラベル: claim_orbit_permutation_sign_values
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した、
# 軌道の上の全単射の符号 sgn_O が ±1 の値を取り、2 乗が 1 であり、恒等写像で +1 になることを、
# 小さい L で総当たりに確かめる。すべて有限集合の上の写像と数え上げ、および整数 -1 の冪であり、
# 浮動小数点は使わない。
#
# 何を確かめるか:
#   1. sgn_O(psi) が +1 か -1 であること（第一の主張）。
#   2. sgn_O(psi) * sgn_O(psi) = 1 であること（第二の主張）。
#      指数法則の段を別に見る: (-1)^{inv_O} * (-1)^{inv_O} = ((-1)^2)^{inv_O} = 1^{inv_O} = 1。
#   3. sgn_O(id_O) = +1 であること（第三の主張）。あわせて inv_O(id_O) = 0、すなわち転倒数の
#      定義に現れる集合が空であることを別に確かめる（符号だけを見ると、inv_O が 0 でない
#      偶数であっても +1 になって通ってしまう）。
#   4. 主張が空でないこと。sgn_O(psi) = -1 となる psi があるかを L ごとに記録する。
#      |O| = 1 の軌道しか無い L では、第一・第二の主張は +1 の場合しか見ていない。
#
# 走らせる L の範囲について。
#   ここで総当たりするのは軌道 O の上の全単射の全体 B_O であり、|O| は L の約数なので
#   |B_O| <= L! である。R_L の上の置換（(2^L)! 通り）を列挙しないので L = 1,...,6 まで回せる。

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


def orbit_of_key(L, key):
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。"""
    tau = row_config_from_key(key)
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return sorted(
        {orbit_of_key(L, key) for key in row_matrix_keys(L)}, key=lambda o: sorted(o)
    )


def less(L, key_1, key_2):
    """def_row_config_order: tau ≺ tau'（キーで受ける）。"""
    return row_config_less(L, row_config_from_key(key_1), row_config_from_key(key_2))


def orbit_bijections(L, o):
    """def_orbit_bijection_set: B_O（O から O への全単射の全体）。辞書で返す。"""
    members = sorted(o)
    for image in itertools.permutations(members):
        yield {key: image[i] for i, key in enumerate(members)}


def cross_ordered_pairs(L, o):
    """def_cross_orbit_ordered_pairs で O' = O と取ったもの: F(O,O)。"""
    members = sorted(o)
    return [
        (key_1, key_2)
        for key_1 in members
        for key_2 in members
        if less(L, key_1, key_2)
    ]


def orbit_inversion_set(L, psi, pairs):
    """def_orbit_inversion_count の転倒数の定義に現れる集合。"""
    return {
        (key_1, key_2)
        for (key_1, key_2) in pairs
        if less(L, psi[key_2], psi[key_1])
    }


def orbit_inversion_count(L, psi, pairs):
    """def_orbit_inversion_count: inv_O(psi) = |{ (tau,tau') in F(O,O) | psi(tau') ≺ psi(tau) }|。"""
    return len(orbit_inversion_set(L, psi, pairs))


def orbit_permutation_sign(L, psi, pairs):
    """def_orbit_permutation_sign: sgn_O(psi) = (-1)^{inv_O(psi)}。"""
    return (-1) ** orbit_inversion_count(L, psi, pairs)


def check_values(L, orbits):
    """1 と 2: sgn_O が ±1 の値を取り、2 乗が 1 であること。"""
    total = 0
    for o in orbits:
        pairs = cross_ordered_pairs(L, o)
        for psi in orbit_bijections(L, o):
            n = orbit_inversion_count(L, psi, pairs)
            value = orbit_permutation_sign(L, psi, pairs)
            # 第一の主張。n が偶数なら +1、奇数なら -1 である。
            assert value in (1, -1), (L, 'sgn_O(psi) が ±1 でない')
            assert value == (1 if n % 2 == 0 else -1), (
                L, 'sgn_O(psi) の符号が inv_O の偶奇と一致しない')
            # 第二の主張。指数法則の段を別々に見る。
            assert value * value == ((-1) ** 2) ** n, (
                L, '(-1)^{inv_O} * (-1)^{inv_O} = ((-1)^2)^{inv_O} が破れた')
            assert ((-1) ** 2) ** n == 1 ** n, (L, '((-1)^2)^{inv_O} = 1^{inv_O} が破れた')
            assert 1 ** n == 1, (L, '1 の冪が 1 でない')
            assert value * value == 1, (L, 'sgn_O(psi)^2 が 1 でない')
            total += 1
    print(f'OK: L={L} で sgn_O は ±1 の値を取り 2 乗が 1 である'
          f'（軌道 {len(orbits)} 個、全単射 {total} 個）')


def check_identity(L, orbits):
    """3: inv_O(id_O) = 0 と sgn_O(id_O) = +1。"""
    for o in orbits:
        pairs = cross_ordered_pairs(L, o)
        identity = {key: key for key in sorted(o)}
        # 転倒数の定義に現れる集合が空であること（三分律が効いている段）。
        assert orbit_inversion_set(L, identity, pairs) == set(), (
            L, 'inv_O(id_O) の定義に現れる集合が空でない')
        assert orbit_inversion_count(L, identity, pairs) == 0, (L, 'inv_O(id_O) が 0 でない')
        assert orbit_permutation_sign(L, identity, pairs) == (-1) ** 0, (
            L, 'sgn_O(id_O) = (-1)^0 が破れた')
        assert orbit_permutation_sign(L, identity, pairs) == 1, (L, 'sgn_O(id_O) が +1 でない')
    print(f'OK: L={L} で inv_O(id_O) = 0 かつ sgn_O(id_O) = +1（軌道 {len(orbits)} 個）')


def check_not_vacuous(L, orbits):
    """4: 主張が空でないこと（sgn_O = -1 となる例があるか）。"""
    negative = any(
        orbit_permutation_sign(L, psi, cross_ordered_pairs(L, o)) == -1
        for o in orbits
        for psi in orbit_bijections(L, o)
    )
    sizes = sorted({len(o) for o in orbits})
    print(f'    記録: L={L} 軌道の大きさ {sizes}、sgn_O = -1 の例は'
          f'{"ある" if negative else "無い（+1 の場合しか見ていない）"}')


def main():
    for L in range(1, 7):
        orbits = orbit_set(L)
        check_values(L, orbits)
        check_identity(L, orbits)
        check_not_vacuous(L, orbits)
    print('すべて通過: claim_orbit_permutation_sign_values')


main()
