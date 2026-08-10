# 対象ラベル: claim_orbit_transposition_composite_is_shift
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「巡回シフトの制限は軌道の元の個数より 1 つ少ない個数の互換の合成である」
# （Psi^{O,tau_0}_{|O|-1} = S↾O）を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と元の相等だけであり、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. 主張そのもの。各軌道 O と各基点 tau_0 in O について、O のすべての点で
#      Psi^{O,tau_0}_{|O|-1}(tau) = S(tau) であること。
#   2. 本文の証明が使う 2 つの場合（tau = S^[r](tau_0) と書いたときの r < e-1 と r = e-1）が
#      どちらも実際に走っていること。数えて記録する（一方しか走っていないと
#      場合分けを確かめたことにならない）。
#   3. 添字を 1 つ減らすと主張が破れること。|O| >= 2 の軌道では
#      Psi^{O,tau_0}_{|O|-2} != S↾O であること（合成する互換の個数 |O|-1 が
#      これ以上減らせないことの確認）。
#   4. 基点への依存。Psi^{O,tau_0}_{k} は基点 tau_0 ごとに違う写像でありうるが、
#      k = |O|-1 と取ったものはどの基点でも S↾O に等しい。k = |O|-1 以外では
#      基点によって写像が変わる例があることも記録する。
#
# 走らせる範囲について。
#   軌道 O、基点 tau_0 in O をすべて走らせる。L = 1,...,6 まで回す
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
    """def_orbit_restriction: S↾O（S を O へ制限したもの）。"""
    restricted = {}
    for key in o:
        image = shift_key(L, key)
        assert image in o, (L, 'S(tau) が O に属さない（S は軌道を保つはず）')
        restricted[key] = image
    return restricted


def check_composite_is_shift(L, orbits):
    """1 と 2: Psi_{|O|-1} = S↾O であること。証明の 2 つの場合を別々に数える。"""
    counts = {'r < e-1': 0, 'r = e-1': 0}
    for o in orbits:
        e = len(o)
        restricted = shift_restriction(L, o)
        for key0 in sorted(o):
            psi = composite(L, o, key0, e - 1)
            assert psi == restricted, (L, key0, 'Psi_{|O|-1} が S↾O と一致しない')
            for r in range(e):
                counts['r < e-1' if r < e - 1 else 'r = e-1'] += 1
    print(f'OK: L={L} で Psi^{{O,tau_0}}_{{|O|-1}} = S↾O である'
          f'（証明の場合ごとの点の件数 {counts}）')


def check_index_cannot_shrink(L, orbits):
    """3: 添字を 1 つ減らすと主張が破れること（|O| >= 2 の軌道について）。"""
    tested = 0
    for o in orbits:
        e = len(o)
        if e < 2:
            continue
        restricted = shift_restriction(L, o)
        for key0 in sorted(o):
            psi = composite(L, o, key0, e - 2)
            assert psi != restricted, (
                L, key0, 'Psi_{|O|-2} が S↾O と一致してしまう（互換の個数が減らせることになる）')
            tested += 1
    if tested:
        print(f'    記録: L={L} で |O| >= 2 の軌道 {tested} 通りの基点すべてについて'
              f' Psi_{{|O|-2}} != S↾O である（互換の個数 |O|-1 は減らせない）')
    else:
        print(f'    記録: L={L} には |O| >= 2 の軌道が無いので添字を減らす検査は空である')


def check_base_point_dependence(L, orbits):
    """4: k = |O|-1 では基点によらず同じ写像だが、他の k では基点で変わる例があること。"""
    varying = 0
    for o in orbits:
        e = len(o)
        for k in range(e):
            maps = {tuple(sorted(composite(L, o, key0, k).items())) for key0 in sorted(o)}
            if k == e - 1:
                assert len(maps) == 1, (L, k, 'k = |O|-1 なのに基点で写像が変わる')
            elif len(maps) > 1:
                varying += 1
    print(f'    記録: L={L} で k = |O|-1 のときは基点によらず同じ写像であり、'
          f'それ以外の k で基点によって写像が変わる (O, k) は {varying} 通りある')


def main():
    for L in range(1, 7):
        orbits = orbit_set(L)
        check_composite_is_shift(L, orbits)
        check_index_cannot_shrink(L, orbits)
        check_base_point_dependence(L, orbits)
    print('すべて通過: claim_orbit_transposition_composite_is_shift')


main()
