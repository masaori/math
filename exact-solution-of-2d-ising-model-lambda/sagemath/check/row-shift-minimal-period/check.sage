# 対象ラベル: def_row_config_shift_minimal_period / claim_row_config_shift_iterate_add /
#             claim_row_config_shift_period_divides / claim_row_config_minimal_period_divides_L
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で定めた
# 行配位の最小周期 e(tau) と、それについての 3 つの主張を、小さい L で総当たりに確かめる。
# すべて ZZ の中の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. def_row_config_shift_minimal_period。K(tau) = { k >= 1 | S^[k](tau) = tau } が
#      L を含むこと（空でないこと）、その最小元 e(tau) が S^[e](tau) = tau を満たすこと、
#      および 1 <= k < e(tau) では S^[k](tau) != tau であること。
#   2. claim_row_config_shift_iterate_add。S^[a+b](tau) = S^[a](S^[b](tau))。
#      左辺は a+b 回の反復を直接作り、右辺は 2 段に分けて作る（作り方が独立）。
#   3. claim_row_config_shift_period_divides。S^[k](tau) = tau <=> e(tau) が k を割り切る。
#      両方向を、k の範囲を総当たりして確かめる（片方向だけでは、e を過大に取る誤りや
#      過小に取る誤りのどちらかが隠れる）。
#   4. claim_row_config_minimal_period_divides_L。e(tau) は L を割り切る。
#      あわせて、e(tau) を「L の約数 d のうち S^[d](tau) = tau となる最小のもの」として
#      独立に作り直し、1 の探索と一致することを見る（作り方が独立）。
#
# 主張が空でないことの確認も行う（下の check_not_vacuous）。
#   - e(tau) は L と一致するとは限らない（L=4 では 1, 2, 4 のすべてが実際に現れる）。
#     すなわち 4 は「e = L」という自明な理由で成り立っているのではない。
#   - 3 の範囲には S^[k](tau) = tau となる k とならない k の両方が現れる
#     （同値が片側だけで自明に成り立っているのではない）。

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


def minimal_period(L, tau):
    """def_row_config_shift_minimal_period: K(tau) の最小元 e(tau)。

    本文の定め方（1 以上の k を小さい順に探し、最初に戻るものを取る）をそのまま実装する。
    K(tau) が L を含むので、探索は L で必ず止まる。
    """
    for k in range(1, L + 1):
        if row_shift_iterate(L, k, tau) == tau:
            return k
    raise AssertionError('K(tau) が空である（L が属していない）')


def minimal_period_via_divisors(L, tau):
    """e(tau) を L の約数の中から作り直したもの（1 の探索とは作り方が独立）。"""
    for d in sorted(ZZ(L).divisors()):
        if row_shift_iterate(L, d, tau) == tau:
            return d
    raise AssertionError('L の約数の中に周期が無い')


def check_minimal_period_definition(L):
    """1: K(tau) が L を含むこと、e(tau) の 2 つの性質。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        assert row_shift_iterate(L, L, tau) == tau, (L, key, 'L が K(tau) に属さない')
        e = minimal_period(L, tau)
        assert e >= 1, (L, key, e)
        assert row_shift_iterate(L, e, tau) == tau, (L, key, e)
        for k in range(1, e):
            assert row_shift_iterate(L, k, tau) != tau, (L, key, e, k, '最小でない')
    print(f'OK: L={L} で K(tau) は L を含み、e(tau) は最小の周期（行配位は全 {2 ** L} 通り）')


def check_iterate_add(L, k_max):
    """2: S^[a+b](tau) = S^[a](S^[b](tau))。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        for a in range(k_max + 1):
            for b in range(k_max + 1):
                left = row_shift_iterate(L, a + b, tau)
                right = row_shift_iterate(L, a, row_shift_iterate(L, b, tau))
                assert left == right, (L, key, a, b)
    print(f'OK: L={L} で S^[a+b](tau) = S^[a](S^[b](tau))（a,b=0..{k_max}、行配位は総当たり）')


def check_period_divides(L, k_max):
    """3: S^[k](tau) = tau <=> e(tau) | k。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        e = minimal_period(L, tau)
        for k in range(k_max + 1):
            returns = (row_shift_iterate(L, k, tau) == tau)
            divides = (k % e == 0)
            assert returns == divides, (L, key, e, k, returns, divides)
    print(f'OK: L={L} で S^[k](tau) = tau と e(tau) | k が同値（k=0..{k_max}、行配位は総当たり）')


def check_period_divides_L(L):
    """4: e(tau) は L を割り切る。約数から作り直した e とも一致する。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        e = minimal_period(L, tau)
        assert L % e == 0, (L, key, e)
        assert e == minimal_period_via_divisors(L, tau), (L, key, e)
    print(f'OK: L={L} で e(tau) は L を割り切る（約数から作り直した e とも一致。全 {2 ** L} 通り）')


def check_not_vacuous():
    """5: 主張が空でないこと。"""
    # e(tau) は L と一致するとは限らない（L=4 では 1, 2, 4 のすべてが現れる）。
    L = 4
    periods = set()
    for key in row_matrix_keys(L):
        periods.add(minimal_period(L, row_config_from_key(key)))
    assert periods == {1, 2, 4}, (L, periods)
    # 同値の両側が実際に起きていること（k の範囲に、戻る k と戻らない k の両方がある）。
    L = 3
    returns_seen, not_returns_seen = False, False
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        for k in range(1, 2 * L + 1):
            if row_shift_iterate(L, k, tau) == tau:
                returns_seen = True
            else:
                not_returns_seen = True
    assert returns_seen and not_returns_seen, (returns_seen, not_returns_seen)
    print('OK: L=4 で最小周期は 1,2,4 のすべてを取り、同値の両側が実際に起きる（主張は空でない）')


def main():
    for L in [1, 2, 3, 4, 5, 6]:
        check_minimal_period_definition(L)
        check_iterate_add(L, 2 * L)
        check_period_divides(L, 3 * L)
        check_period_divides_L(L)
    check_not_vacuous()
    print('すべての検証が通った（行配位の最小周期）')


main()
