# 対象ラベル: claim_row_shift_iterate_distinct_below_period
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「a < e(tau)、b < e(tau)、S^[a](tau) = S^[b](tau) ならば a = b」を、
# 小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と元の相等だけであり、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. 主張そのもの。各 tau について a, b < e(tau) を総当たりし、
#      S^[a](tau) = S^[b](tau) となるのが a = b のときに限ることを見る。
#   2. 上界 e(tau) が外せないこと。a < e(tau) の制限を外すと主張が偽になること
#      （a = 0 と b = e(tau) は行く先が同じで a != b である）を、
#      e(tau) >= 1 のすべての tau で見る。これを見ないと、主張の仮定が
#      効いているのかどうかが分からない。
#   3. 主張が空でないこと。e(tau) >= 2 の tau があるか L ごとに記録する
#      （e(tau) = 1 の tau しか無ければ a = b = 0 の場合しか見ていない）。
#
# 走らせる範囲について。
#   L = 1,...,6 まで回せる（本文の他の検証と範囲を揃えた）。

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


def shift_iterate_key(L, k, key):
    """キーの上で S^[k] を作用させる。"""
    return row_config_key(L, row_shift_iterate(L, k, row_config_from_key(key)))


def minimal_period(L, key):
    """def_row_config_shift_minimal_period: e(tau) = min { k >= 1 | S^[k](tau) = tau }。"""
    k = 1
    while True:
        if shift_iterate_key(L, k, key) == key:
            return k
        k += 1


def check_distinct(L, keys):
    """1: a, b < e(tau) のとき S^[a](tau) = S^[b](tau) ならば a = b。"""
    total = 0
    for key in keys:
        e = minimal_period(L, key)
        for a in range(e):
            for b in range(e):
                same = shift_iterate_key(L, a, key) == shift_iterate_key(L, b, key)
                assert same == (a == b), (
                    L, key, a, b, 'S^[a](tau) = S^[b](tau) と a = b が食い違う')
                total += 1
    print(f'OK: L={L} で最小周期より小さい反復の回数は行く先で見分けられる'
          f'（tau と (a,b) の組 {total} 通り）')


def check_bound_is_needed(L, keys):
    """2: 上界 e(tau) を外すと主張が偽になること（a = 0、b = e(tau)）。"""
    total = 0
    for key in keys:
        e = minimal_period(L, key)
        assert shift_iterate_key(L, e, key) == shift_iterate_key(L, 0, key), (
            L, key, 'S^[e(tau)](tau) = tau が破れている')
        assert e != 0
        total += 1
    print(f'OK: L={L} で a < e(tau) の制限を外すと主張が偽になる'
          f'（S^[0](tau) = S^[e(tau)](tau) だが 0 != e(tau)。tau {total} 個）')


def check_not_vacuous(L, keys):
    """3: 主張が空でないこと（e(tau) >= 2 の tau があるか）。"""
    periods = sorted({minimal_period(L, key) for key in keys})
    non_trivial = any(minimal_period(L, key) >= 2 for key in keys)
    print(f'    記録: L={L} 最小周期の値 {periods}、e(tau) >= 2 の tau は'
          f'{"ある" if non_trivial else "無い（a = b = 0 の場合しか見ていない）"}')


def main():
    for L in range(1, 7):
        keys = sorted(row_matrix_keys(L))
        check_distinct(L, keys)
        check_bound_is_needed(L, keys)
        check_not_vacuous(L, keys)
    print('すべて通過: claim_row_shift_iterate_distinct_below_period')


main()
