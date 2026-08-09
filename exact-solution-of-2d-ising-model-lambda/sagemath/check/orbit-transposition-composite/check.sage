# 対象ラベル: def_orbit_transposition_composite, claim_orbit_transposition_composite_bijective
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で置いた
# 互換の反復合成 Psi^{O,tau_0}_k と、それが O の上の全単射であることを、
# 小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と元の相等だけであり、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. 定義の前提。tau_0 in O のとき、任意の k について S^[k](tau_0) in O であること
#      （本文が O(tau_0) = O から出している段）。これが成り立たないと、
#      互換の制限を作る足場が無い。
#   2. 定義の再帰がそのまま計算できること。Psi_0 = id_O、
#      Psi_{k+1} = t^O_{tau_0, S^[k+1](tau_0)} o Psi_k を定義どおりに実装し、
#      合成の順（添字の小さい互換ほど先に作用する）が本文の注意と一致することを、
#      k >= 1 での明示的な合成列と突き合わせて見る。
#   3. 主張。任意の k について Psi_k が O から O への全単射であること。
#      単射であることと、像が O 全体であることを別々に見る。
#   4. 主張が空でないこと。|O| >= 2 の軌道があるか L ごとに記録する。
#      |O| = 1 の軌道しか無いところでは、互換はすべて恒等写像なので Psi_k も恒等写像である。
#
# 走らせる範囲について。
#   軌道 O、基点 tau_0 in O、k = 0,...,|O| をすべて走らせる。
#   k を |O| までにしているのは、次のセクションで使うのが k = |O| - 1 だからである
#   （そこまでの全域で全単射であることを見ておく）。
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
    """def_orbit_transposition_composite: Psi^{O,tau_0}_k を再帰の定義そのままに作る。

    O の上の写像を dict（キー -> キー）として持つ。
    """
    if k == 0:
        return {key: key for key in o}          # Psi_0 = id_O
    prev = composite(L, o, key0, k - 1)
    key_k = shift_iterate_key(L, k, key0)       # S^[k](tau_0)
    # Psi_{k+1} = t^O_{tau_0, S^[k+1](tau_0)} o Psi_k（先に Psi_k、あとに互換）
    return {key: transposition(key0, key_k, prev[key]) for key in o}


def composite_by_explicit_chain(L, o, key0, k):
    """本文の注意「添字の小さい互換ほど先に作用する」を、明示的な合成列で作る。

    Psi_k = t_{tau_0,S^[k](tau_0)} o ... o t_{tau_0,S^[1](tau_0)} を、
    j = 1,2,...,k の順に作用させることで計算する。
    """
    result = {}
    for key in o:
        value = key
        for j in range(1, k + 1):
            value = transposition(key0, shift_iterate_key(L, j, key0), value)
        result[key] = value
    return result


def check_shift_stays_in_orbit(L, orbits):
    """1: tau_0 in O ならば任意の k について S^[k](tau_0) in O。"""
    for o in orbits:
        for key0 in sorted(o):
            for k in range(len(o) + 1):
                assert shift_iterate_key(L, k, key0) in o, (
                    L, 'S^[k](tau_0) が O に属さない')
    print(f'OK: L={L} で tau_0 in O のとき S^[k](tau_0) in O（軌道 {len(orbits)} 個）')


def check_recursion_matches_chain(L, orbits):
    """2: 再帰の定義と、明示的な合成列が一致すること（合成の順の確認）。"""
    total = 0
    for o in orbits:
        for key0 in sorted(o):
            for k in range(len(o) + 1):
                assert composite(L, o, key0, k) == composite_by_explicit_chain(L, o, key0, k), (
                    L, '再帰の定義と明示的な合成列が一致しない')
                total += 1
    print(f'OK: L={L} で再帰の定義と明示的な合成列が一致する'
          f'（軌道・基点・k の組 {total} 通り）')


def check_bijective(L, orbits):
    """3: 任意の k について Psi_k が O から O への全単射であること。"""
    total = 0
    for o in orbits:
        members = sorted(o)
        for key0 in members:
            for k in range(len(o) + 1):
                psi = composite(L, o, key0, k)
                images = [psi[key] for key in members]
                for image in images:
                    assert image in o, (L, 'Psi_k(tau) が O に属さない')
                # 単射性と、像が O 全体であることを別々に見る。
                assert len(set(images)) == len(members), (L, 'Psi_k が単射でない')
                assert set(images) == set(members), (L, 'Psi_k の像が O 全体でない')
                total += 1
    print(f'OK: L={L} で Psi_k は O の上の全単射である'
          f'（軌道・基点・k の組 {total} 通り）')


def check_not_vacuous(L, orbits):
    """4: 主張が空でないこと（|O| >= 2 の軌道があるか）。"""
    sizes = sorted({len(o) for o in orbits})
    non_trivial = any(len(o) >= 2 for o in orbits)
    print(f'    記録: L={L} 軌道の大きさ {sizes}、|O| >= 2 の軌道は'
          f'{"ある" if non_trivial else "無い（Psi_k はすべて恒等写像である）"}')


def main():
    for L in range(1, 7):
        orbits = orbit_set(L)
        check_shift_stays_in_orbit(L, orbits)
        check_recursion_matches_chain(L, orbits)
        check_bijective(L, orbits)
        check_not_vacuous(L, orbits)
    print('すべて通過: def_orbit_transposition_composite, '
          'claim_orbit_transposition_composite_bijective')


main()
