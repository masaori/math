# 対象ラベル: claim_orbit_fixed_iff_card_one
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「軌道の元が巡回シフトで動かないことと、その軌道の元の個数が 1 であることは同値である」
# （O in O_L と tau in O について S(tau) = tau <=> |O| = 1）を、小さい L で総当たりに確かめる。
# すべて有限集合の元の相等と数え上げ、および ZZ の積と大小で行い、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備の第一。tau in O のとき O(tau) = O であり、したがって |O| = |O(tau)| = e(tau)。
#   2. 準備の第二。S^[1](tau) = S(tau)。
#   3. 第一の向き。S(tau) = tau ならば |O| = 1。
#   4. 第二の向き。|O| = 1 ならば S(tau) = tau。
#   5. 主張が空でないこと。S(tau) = tau となる tau と、そうでない tau が両方現れること。
#      **これを見ないと、どちらか一方の場合しか無くても 3・4 が通ってしまう。**
#
# 走らせる範囲（打ち切りを隠さない）。
#   軌道 O をすべて、その元 tau をすべて走らせる。L = 1,...,6 まで回す
#   （本文の他の検証と範囲を揃えた）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def column_translation(L, y):
    """def_column_translation: gamma(y) = y +_{Z/LZ} 1bar。"""
    return (y + 1) % L


def row_shift(L, tau):
    """def_row_config_shift: (S(tau))(y) = tau(gamma(y))。"""
    return {y: tau[column_translation(L, y)] for y in range(L)}


def shift_key(L, key):
    """キーの上で S を作用させる。"""
    return row_config_key(L, row_shift(L, row_config_from_key(key)))


def row_shift_iterate(L, k, tau):
    """def_row_config_shift_iterate: S^[0] = id、S^[k+1] = S o S^[k]。"""
    if k == 0:
        return dict(tau)
    return row_shift(L, row_shift_iterate(L, k - 1, tau))


def iterate_key(L, k, key):
    return row_config_key(L, row_shift_iterate(L, k, row_config_from_key(key)))


def orbit_of_key(L, key):
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。"""
    return frozenset(iterate_key(L, k, key) for k in range(L))


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return sorted(
        {orbit_of_key(L, key) for key in row_matrix_keys(L)}, key=lambda o: sorted(o)
    )


def minimal_period(L, key):
    """def_row_config_shift_minimal_period: e(tau) = min { k >= 1 | S^[k](tau) = tau }。"""
    k = 1
    while True:
        if iterate_key(L, k, key) == key:
            return k
        k += 1


def check_for_L(L):
    orbits = orbit_set(L)

    count_fixed = 0
    count_moved = 0
    for o in orbits:
        for key in sorted(o):
            # 1: 準備の第一。tau in O ならば O(tau) = O、したがって |O| = |O(tau)| = e(tau)。
            assert orbit_of_key(L, key) == o, (L, sorted(o), 'O(tau) = O が破れた')
            assert len(o) == len(orbit_of_key(L, key)), (L, '|O| = |O(tau)| が破れた')
            assert len(o) == minimal_period(L, key), (L, '|O| = e(tau) が破れた')

            # 2: 準備の第二。S^[1](tau) = S(tau)。
            assert iterate_key(L, 1, key) == shift_key(L, key), (
                L, 'S^[1](tau) = S(tau) が破れた')

            fixed = (shift_key(L, key) == key)

            # 3: 第一の向き。S(tau) = tau ならば |O| = 1。
            if fixed:
                assert minimal_period(L, key) == 1, (L, 'e(tau) = 1 が破れた')
                assert len(o) == 1, (L, sorted(o), '|O| = 1 が破れた')
                count_fixed += 1

            # 4: 第二の向き。|O| = 1 ならば S(tau) = tau。
            if len(o) == 1:
                assert shift_key(L, key) == key, (L, sorted(o), 'S(tau) = tau が破れた')
            else:
                count_moved += 1

            # 同値そのもの（3・4 を合わせた形でも確かめる）。
            assert fixed == (len(o) == 1), (L, sorted(o), '同値が破れた')

    # 5: 主張が空でないこと。
    assert count_fixed >= 1, (L, 'S(tau) = tau となる tau が 1 つも無い')
    if L >= 2:
        assert count_moved >= 1, (L, 'S(tau) != tau となる tau が 1 つも無い')

    print(f'OK: L={L}（軌道 {len(orbits)} 個、'
          f'S(tau) = tau となる tau {count_fixed} 件はすべて |O| = 1、'
          f'そうでない tau {count_moved} 件はすべて |O| >= 2）')
    return len(orbits), count_fixed, count_moved


def main():
    rows = []
    for L in range(1, 7):
        rows.append((L,) + check_for_L(L))
    print()
    print('| L | 軌道の個数 | S(tau) = tau となる tau | そうでない tau |')
    print('|---|---|---|---|')
    for (L, n_orbits, n_fixed, n_moved) in rows:
        print(f'| {L} | {n_orbits} | {n_fixed} | {n_moved} |')


main()
