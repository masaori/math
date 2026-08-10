# 対象ラベル: claim_orbit_transposition_composite_sign
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「互換の反復合成の符号は (-1)^k である」（k < e(tau_0) のとき
# sgn_O(Psi^{O,tau_0}_k) = (-1)^k）を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像・元の相等・数え上げと整数の積だけであり、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備の第一。1 <= j < e(tau_0) ならば tau_0 != S^[j](tau_0) であること。
#   2. 準備の第二。tau_a != tau_b（どちらも O の元）ならば sgn_O(t^O_{tau_a,tau_b}) = -1 であること。
#      あわせて 2 つの互換が写像として一致すること（t_{tau_a,tau_b} = t_{tau_b,tau_a}）も確かめる。
#      人手証明が tau_b ≺ tau_a の場合にこれを使うためである。
#   3. 帰納法の出発点。sgn_O(Psi_0) = sgn_O(id_O) = +1 であること。
#   4. 帰納法の一歩。k+1 < e(tau_0) のとき
#      sgn_O(Psi_{k+1}) = sgn_O(t^O_{tau_0,S^[k+1](tau_0)}) * sgn_O(Psi_k) であること
#      （符号の乗法性をこの場面で当てた形）。
#   5. 主張そのもの。k < e(tau_0) のとき sgn_O(Psi_k) = (-1)^k であること。
#   6. 上界 k < e(tau_0) が外せないこと。k = e(tau_0) では合成する互換が恒等写像になり、
#      sgn_O(Psi_k) = (-1)^k が破れる（破れる最小の k を L ごとに記録する）。
#
# 走らせる範囲について。
#   軌道 O、基点 tau_0 in O をすべて走らせ、k は 0 から 2 e(tau_0) + 1 まで動かす。
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


def less(L, key_1, key_2):
    """def_row_config_order: tau ≺ tau'（キーで受ける）。"""
    return row_config_less(L, row_config_from_key(key_1), row_config_from_key(key_2))


def cross_ordered_pairs(L, o):
    """def_cross_orbit_ordered_pairs で O' = O と取ったもの: F(O,O)。"""
    members = sorted(o)
    return [
        (key_1, key_2)
        for key_1 in members
        for key_2 in members
        if less(L, key_1, key_2)
    ]


def orbit_inversion_count(L, psi, pairs):
    """def_orbit_inversion_count: inv_O(psi) = |{ (tau,tau') in F(O,O) | psi(tau') ≺ psi(tau) }|。"""
    return len([
        (key_1, key_2) for (key_1, key_2) in pairs if less(L, psi[key_2], psi[key_1])
    ])


def orbit_permutation_sign(L, psi, pairs):
    """def_orbit_permutation_sign: sgn_O(psi) = (-1)^{inv_O(psi)}。"""
    return (-1) ** orbit_inversion_count(L, psi, pairs)


def transposition(key_a, key_b, key):
    """def_orbit_transposition: t_{tau_a,tau_b}(tau)。"""
    if key == key_a:
        return key_b
    if key == key_b:
        return key_a
    return key


def transposition_restriction(o, key_a, key_b):
    """t^O_{tau_a,tau_b}（O への制限。辞書で返す）。"""
    return {key: transposition(key_a, key_b, key) for key in o}


def composite(L, o, key0, k):
    """def_orbit_transposition_composite: Psi^{O,tau_0}_k を再帰の定義そのままに作る。"""
    if k == 0:
        return {key: key for key in o}          # Psi_0 = id_O
    prev = composite(L, o, key0, k - 1)
    key_k = shift_iterate_key(L, k, key0)       # S^[k](tau_0)
    return {key: transposition(key0, key_k, prev[key]) for key in o}


def check_preparation_first(L, orbits):
    """1: 1 <= j < e(tau_0) ならば tau_0 != S^[j](tau_0)。"""
    tested = 0
    for o in orbits:
        e = len(o)
        for key0 in sorted(o):
            for j in range(1, e):
                assert key0 != shift_iterate_key(L, j, key0), (
                    L, key0, j, '1 <= j < e なのに S^[j](tau_0) = tau_0 になった')
                tested += 1
    print(f'OK: L={L} で準備の第一（1 <= j < e なら tau_0 != S^[j](tau_0)）が {tested} 件通った')


def check_preparation_second(L, orbits):
    """2: 相異なる 2 点の互換の符号は -1。あわせて 2 つの互換が写像として一致すること。"""
    tested = 0
    for o in orbits:
        pairs = cross_ordered_pairs(L, o)
        for key_a in sorted(o):
            for key_b in sorted(o):
                if key_a == key_b:
                    continue
                t_ab = transposition_restriction(o, key_a, key_b)
                t_ba = transposition_restriction(o, key_b, key_a)
                assert t_ab == t_ba, (L, key_a, key_b, '2 つの互換が写像として一致しない')
                assert orbit_permutation_sign(L, t_ab, pairs) == -1, (
                    L, key_a, key_b, '互換の符号が -1 でない')
                tested += 1
    if tested:
        print(f'    記録: L={L} で準備の第二（互換の符号が -1、および t_ab = t_ba）が'
              f' {tested} 件通った')
    else:
        print(f'    記録: L={L} には相異なる 2 点を持つ軌道が無いので準備の第二の検査は空である')


def check_induction(L, orbits):
    """3 と 4: 帰納法の出発点と一歩（乗法性を当てた形）。"""
    base = 0
    steps = 0
    for o in orbits:
        e = len(o)
        pairs = cross_ordered_pairs(L, o)
        identity = {key: key for key in o}
        for key0 in sorted(o):
            assert composite(L, o, key0, 0) == identity, (L, key0, 'Psi_0 が id_O でない')
            assert orbit_permutation_sign(L, identity, pairs) == 1, (L, 'sgn_O(id_O) != +1')
            base += 1
            for k in range(0, e - 1):
                key_next = shift_iterate_key(L, k + 1, key0)
                t = transposition_restriction(o, key0, key_next)
                lhs = orbit_permutation_sign(L, composite(L, o, key0, k + 1), pairs)
                rhs = (orbit_permutation_sign(L, t, pairs)
                       * orbit_permutation_sign(L, composite(L, o, key0, k), pairs))
                assert lhs == rhs, (L, key0, k, '帰納法の一歩（符号の乗法性）が破れた')
                steps += 1
    print(f'    記録: L={L} で帰納法の出発点 {base} 件、一歩 {steps} 件が通った')


def check_claim(L, orbits):
    """5: 主張そのもの。k < e(tau_0) のとき sgn_O(Psi_k) = (-1)^k。"""
    tested = 0
    for o in orbits:
        e = len(o)
        pairs = cross_ordered_pairs(L, o)
        for key0 in sorted(o):
            for k in range(e):
                sign = orbit_permutation_sign(L, composite(L, o, key0, k), pairs)
                assert sign == (-1) ** k, (L, key0, k, 'sgn_O(Psi_k) = (-1)^k が破れた')
                tested += 1
    print(f'OK: L={L} で sgn_O(Psi^{{O,tau_0}}_k) = (-1)^k である（{tested} 件）')


def check_upper_bound_needed(L, orbits):
    """6: 上界 k < e(tau_0) が外せないこと。破れる最小の k を記録する。"""
    breaks = []
    for o in orbits:
        e = len(o)
        pairs = cross_ordered_pairs(L, o)
        for key0 in sorted(o):
            for k in range(e, 2 * e + 2):
                sign = orbit_permutation_sign(L, composite(L, o, key0, k), pairs)
                if sign != (-1) ** k:
                    breaks.append(k)
                    break
    if breaks:
        print(f'    記録: L={L} で k >= e(tau_0) では等式が破れる（破れる最小の k の全体は'
              f' {sorted(set(breaks))}）。上界は外せない')
    else:
        print(f'    記録: L={L} では k >= e(tau_0) でも等式が破れる例が見つからなかった'
              f'（e = 1 の軌道しか無いため）')


def main():
    for L in range(1, 7):
        orbits = orbit_set(L)
        check_preparation_first(L, orbits)
        check_preparation_second(L, orbits)
        check_induction(L, orbits)
        check_claim(L, orbits)
        check_upper_bound_needed(L, orbits)
    print('すべて通過: claim_orbit_transposition_composite_sign')


main()
