# 対象ラベル: claim_orbit_shift_restriction_sign
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「軌道の上の巡回シフトの制限の符号は (-1)^{|O|-1} である」
# （sgn_O(S↾_O) = (-1)^{|O|-1}）を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像・元の相等・数え上げと整数の積だけであり、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備。どの軌道 O も空でないこと（基点 tau_0 in O が取れること）。
#   2. 準備。|O| = e(tau_0) であること（軌道の元の個数は最小周期に等しい）。
#      あわせて e(tau_0) >= 1 と |O| - 1 < e(tau_0) を確かめる。
#   3. 第 1 の等号。Psi^{O,tau_0}_{|O|-1} = S↾_O であること（前のセクションの主張を、
#      ここで使う形で確かめ直す）。
#   4. 主張そのもの。sgn_O(S↾_O) = (-1)^{|O|-1} であること。
#   5. 右辺が基点によらないこと（左辺に tau_0 が現れないことの裏取り）。
#      すなわち、どの基点から作った Psi_{|O|-1} も同じ符号を与えること。
#
# 走らせる範囲について。
#   軌道 O をすべて、基点 tau_0 in O をすべて走らせる。
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


def shift_key(L, key):
    """キーの上で S を作用させる。"""
    return row_config_key(L, row_shift(L, row_config_from_key(key)))


def shift_iterate_key(L, k, key):
    """キーの上で S^[k] を作用させる。"""
    return row_config_key(L, row_shift_iterate(L, k, row_config_from_key(key)))


def minimal_period(L, key):
    """def_row_config_shift_minimal_period: e(tau) = min{ k >= 1 | S^[k](tau) = tau }。"""
    k = 1
    while shift_iterate_key(L, k, key) != key:
        k += 1
    return k


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


def composite(L, o, key0, k):
    """def_orbit_transposition_composite: Psi^{O,tau_0}_k を再帰の定義そのままに作る。"""
    if k == 0:
        return {key: key for key in o}          # Psi_0 = id_O
    prev = composite(L, o, key0, k - 1)
    key_k = shift_iterate_key(L, k, key0)       # S^[k](tau_0)
    return {key: transposition(key0, key_k, prev[key]) for key in o}


def shift_restriction(L, o):
    """S↾_O（軌道への制限。辞書で返す）。"""
    return {key: shift_key(L, key) for key in o}


def check_preparation(L, orbits):
    """1 と 2: 軌道が空でないこと、|O| = e(tau_0) >= 1 と |O| - 1 < e(tau_0)。"""
    tested = 0
    for o in orbits:
        assert len(o) >= 1, (L, '軌道が空である')
        for key0 in sorted(o):
            e = minimal_period(L, key0)
            assert len(o) == e, (L, key0, '|O| = e(tau_0) が破れた')
            assert e >= 1, (L, key0, 'e(tau_0) >= 1 が破れた')
            assert len(o) - 1 < e, (L, key0, '|O| - 1 < e(tau_0) が破れた')
            tested += 1
    print(f'    記録: L={L} で準備（|O| = e(tau_0) >= 1 と |O| - 1 < e(tau_0)）が {tested} 件通った')


def check_composite_is_shift(L, orbits):
    """3: 第 1 の等号。Psi^{O,tau_0}_{|O|-1} = S↾_O であること。"""
    tested = 0
    for o in orbits:
        target = shift_restriction(L, o)
        for key0 in sorted(o):
            assert composite(L, o, key0, len(o) - 1) == target, (
                L, key0, 'Psi_{|O|-1} = S↾_O が破れた')
            tested += 1
    print(f'    記録: L={L} で第 1 の等号（Psi_{{|O|-1}} = S↾_O）が {tested} 件通った')


def check_claim(L, orbits):
    """4: 主張そのもの。sgn_O(S↾_O) = (-1)^{|O|-1}。"""
    tested = 0
    for o in orbits:
        pairs = cross_ordered_pairs(L, o)
        sign = orbit_permutation_sign(L, shift_restriction(L, o), pairs)
        assert sign == (-1) ** (len(o) - 1), (
            L, sorted(o), 'sgn_O(S↾_O) = (-1)^{|O|-1} が破れた')
        tested += 1
    print(f'OK: L={L} で sgn_O(S↾_O) = (-1)^{{|O|-1}} である（軌道 {tested} 件）')


def check_base_point_independent(L, orbits):
    """5: 右辺が基点によらないこと。どの基点から作った Psi_{|O|-1} も同じ符号を与える。"""
    tested = 0
    for o in orbits:
        pairs = cross_ordered_pairs(L, o)
        signs = {
            orbit_permutation_sign(L, composite(L, o, key0, len(o) - 1), pairs)
            for key0 in sorted(o)
        }
        assert len(signs) == 1, (L, sorted(o), '基点によって符号が変わった')
        assert signs == {(-1) ** (len(o) - 1)}, (L, sorted(o), '符号が (-1)^{|O|-1} でない')
        tested += 1
    print(f'    記録: L={L} で符号が基点によらないことが軌道 {tested} 件で通った')


def main():
    for L in range(1, 7):
        orbits = orbit_set(L)
        check_preparation(L, orbits)
        check_composite_is_shift(L, orbits)
        check_claim(L, orbits)
        check_base_point_independent(L, orbits)
    print('すべて通過: claim_orbit_shift_restriction_sign')


main()
