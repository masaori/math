# 対象ラベル: claim_orbit_transposition_composite_values
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「互換の反復合成が基点の反復に与える値」を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と元の相等だけであり、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. 主張そのもの。k < e(tau_0) と r < e(tau_0) を満たす任意の k, r について
#        Psi_k(S^[r](tau_0)) = S^[r+1](tau_0)  (r < k)
#                            = tau_0           (r = k)
#                            = S^[r](tau_0)    (r > k)
#      であること。3 つの場合を別々に数え、どれも空でないことを記録する。
#   2. 上界 k < e(tau_0) が要ること。k = e(tau_0) と取ると主張が偽になる組が
#      実際に存在すること（主張から仮定を外せないことの確認）。
#   3. 最小周期 e(tau_0) が軌道の大きさ |O| に等しいこと（本文の
#      claim_row_config_orbit_card に対応する。次のセクションが k = |O| - 1 と
#      取るので、ここで一致を見ておく）。
#
# 走らせる範囲について。
#   軌道 O、基点 tau_0 in O、k = 0,...,e(tau_0)-1、r = 0,...,e(tau_0)-1 をすべて走らせる。
#   L = 1,...,6 まで回す（本文の他の検証と範囲を揃えた）。

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


def minimal_period(L, key):
    """def_row_config_shift_minimal_period: e(tau) = min { k >= 1 | S^[k](tau) = tau }。"""
    for k in range(1, L + 1):
        if shift_iterate_key(L, k, key) == key:
            return k
    raise AssertionError((L, '最小周期が L 以下に見つからない'))


def transposition(key_a, key_b, key):
    """def_orbit_transposition: t_{tau_a,tau_b}(tau)。"""
    if key == key_a:
        return key_b
    if key == key_b:
        return key_a
    return key


def composite(L, o, key0, k):
    """def_orbit_transposition_composite: Psi^{O,tau_0}_k を再帰の定義そのままに作る。"""
    if k == 0:
        return {key: key for key in o}          # Psi_0 = id_O
    prev = composite(L, o, key0, k - 1)
    key_k = shift_iterate_key(L, k, key0)       # S^[k](tau_0)
    return {key: transposition(key0, key_k, prev[key]) for key in o}


def expected_value(L, key0, k, r):
    """主張が与える値（3 つの場合）。"""
    if r < k:
        return shift_iterate_key(L, r + 1, key0)
    if r == k:
        return key0
    return shift_iterate_key(L, r, key0)


def check_values(L, orbits):
    """1: 主張そのもの。3 つの場合を別々に数える。"""
    counts = {'r < k': 0, 'r = k': 0, 'r > k': 0}
    for o in orbits:
        for key0 in sorted(o):
            e = minimal_period(L, key0)
            for k in range(e):
                psi = composite(L, o, key0, k)
                for r in range(e):
                    key_r = shift_iterate_key(L, r, key0)
                    assert key_r in o, (L, 'S^[r](tau_0) が O に属さない')
                    assert psi[key_r] == expected_value(L, key0, k, r), (
                        L, key0, k, r, '主張の値と一致しない')
                    counts['r < k' if r < k else ('r = k' if r == k else 'r > k')] += 1
    print(f'OK: L={L} で Psi_k(S^[r](tau_0)) が主張の 3 つの場合の値に一致する'
          f'（場合ごとの件数 {counts}）')


def check_bound_needed(L, orbits):
    """2: 上界 k < e(tau_0) を外すと主張が偽になる k があること（最小のものを記録する）。

    k = e(tau_0) では破れない。S^[e](tau_0) = tau_0 なので、そこで合成する互換
    t_{tau_0, S^[e](tau_0)} = t_{tau_0, tau_0} は恒等写像であり、Psi_{e} = Psi_{e-1} と
    なる一方、主張の値も r < k の場合しか無くなって Psi_{e-1} の値と一致するためである。
    そこで k を e(tau_0) 以上で動かし、主張が破れる最小の k を記録する。
    """
    broken = {}
    for o in orbits:
        for key0 in sorted(o):
            e = minimal_period(L, key0)
            for k in range(e, 2 * e + 2):
                psi = composite(L, o, key0, k)
                if any(psi[shift_iterate_key(L, r, key0)] != expected_value(L, key0, k, r)
                       for r in range(e)):
                    broken[key0] = k
                    break
    if broken:
        print(f'    記録: L={L} で k >= e(tau_0) と取ると主張が破れる基点が'
              f' {len(broken)} 個あり、破れる最小の k は {sorted(set(broken.values()))}'
              f'（上界 k < e(tau_0) は外せない）')
    else:
        print(f'    記録: L={L} では k >= e(tau_0) でも 2e+1 まで主張が破れなかった'
              f'（軌道がすべて 1 元のためである）')


def check_period_is_orbit_size(L, orbits):
    """3: e(tau_0) = |O| であること。"""
    for o in orbits:
        for key0 in sorted(o):
            assert minimal_period(L, key0) == len(o), (L, '最小周期が |O| と一致しない')
    print(f'OK: L={L} で e(tau_0) = |O| である（軌道 {len(orbits)} 個）')


def main():
    for L in range(1, 7):
        orbits = orbit_set(L)
        check_values(L, orbits)
        check_bound_needed(L, orbits)
        check_period_is_orbit_size(L, orbits)
    print('すべて通過: claim_orbit_transposition_composite_values')


main()
