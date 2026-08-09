# 対象ラベル: def_orbit_transposition, claim_orbit_transposition_bijective
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で置いた互換
# t_{tau_a,tau_b} と、それについての 3 主張を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と元の相等だけであり、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. 定義が写像として定まること。3 つの場合が互いに排反で、R_L のどの元も
#      ちょうど 1 つの場合に入ること（本文が「写像として定まる」と述べている段）。
#   2. 第一の主張。任意の tau in R_L について t(t(tau)) = tau であること。
#      軌道の元だけでなく R_L 全体で見る（本文の主張が R_L の上で述べられているため）。
#   3. 第二の主張。tau_a, tau_b in O かつ tau in O ならば t(tau) in O であること。
#   4. 第三の主張。t の O への制限が O から O への全単射であること
#      （像が O 全体に一致すること、および単射であることを別々に見る）。
#   5. tau_a = tau_b の場合に t が R_L の恒等写像であること（本文が場合を除いていない段）。
#   6. 主張が空でないこと。tau_a != tau_b が取れる軌道（|O| >= 2）があるか L ごとに記録する。
#      |O| = 1 の軌道しか無い L では、互換はすべて恒等写像である。
#
# 走らせる L の範囲について。
#   総当たりするのは軌道 O の 2 点の組（|O|^2 通り）であり、R_L の上の置換は列挙しない。
#   L = 1,...,6 まで回せる（本文の他の検証と範囲を揃えた）。

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


def transposition_case(key_a, key_b, key):
    """def_orbit_transposition の 3 つの場合のうち、key がどれに入るかを返す。"""
    if key == key_a:
        return 1
    if key == key_b:
        return 2
    return 3


def transposition(key_a, key_b, key):
    """def_orbit_transposition: t_{tau_a,tau_b}(tau)。"""
    case = transposition_case(key_a, key_b, key)
    if case == 1:
        return key_b
    if case == 2:
        return key_a
    return key


def check_well_defined(L, keys):
    """1: 3 つの場合が互いに排反で、どの元もちょうど 1 つの場合に入ること。"""
    for key_a in keys:
        for key_b in keys:
            for key in keys:
                # 場合の条件をそのまま書き下し、真になるものがちょうど 1 つであることを見る。
                conditions = [
                    key == key_a,
                    key != key_a and key == key_b,
                    key != key_a and key != key_b,
                ]
                assert sum(1 for c in conditions if c) == 1, (
                    L, '3 つの場合がちょうど 1 つにならない')
    print(f'OK: L={L} で互換の定義の 3 つの場合は互いに排反で網羅している'
          f'（行配位 {len(keys)} 個）')


def check_involutive(L, keys):
    """2: 任意の tau in R_L について t(t(tau)) = tau。"""
    for key_a in keys:
        for key_b in keys:
            for key in keys:
                assert transposition(key_a, key_b, transposition(key_a, key_b, key)) == key, (
                    L, 't(t(tau)) = tau が破れた')
    print(f'OK: L={L} で t(t(tau)) = tau（行配位 {len(keys)} 個、組 {len(keys) ** 2} 通り）')


def check_identity_when_equal(L, keys):
    """5: tau_a = tau_b のとき t は R_L の恒等写像である。"""
    for key_a in keys:
        for key in keys:
            assert transposition(key_a, key_a, key) == key, (
                L, 'tau_a = tau_b のとき恒等写像でない')
    print(f'OK: L={L} で tau_a = tau_b のとき互換は恒等写像である')


def check_maps_orbit(L, orbits):
    """3 と 4: O へ閉じること、および制限が O の上の全単射であること。"""
    total = 0
    for o in orbits:
        members = sorted(o)
        for key_a in members:
            for key_b in members:
                images = []
                for key in members:
                    image = transposition(key_a, key_b, key)
                    assert image in o, (L, 't(tau) が O に属さない')
                    images.append(image)
                # 全単射であること。単射性と、像が O 全体であることを別々に見る。
                assert len(set(images)) == len(members), (L, '制限が単射でない')
                assert set(images) == set(members), (L, '制限の像が O 全体でない')
                total += 1
    print(f'OK: L={L} で互換は O へ閉じ、その制限は O の上の全単射である'
          f'（軌道 {len(orbits)} 個、2 点の組 {total} 通り）')


def check_not_vacuous(L, orbits):
    """6: 主張が空でないこと（tau_a != tau_b が取れる軌道があるか）。"""
    sizes = sorted({len(o) for o in orbits})
    non_trivial = any(len(o) >= 2 for o in orbits)
    print(f'    記録: L={L} 軌道の大きさ {sizes}、tau_a != tau_b が取れる軌道は'
          f'{"ある" if non_trivial else "無い（互換はすべて恒等写像である）"}')


def main():
    for L in range(1, 7):
        keys = sorted(row_matrix_keys(L))
        orbits = orbit_set(L)
        check_well_defined(L, keys)
        check_involutive(L, keys)
        check_identity_when_equal(L, keys)
        check_maps_orbit(L, orbits)
        check_not_vacuous(L, orbits)
    print('すべて通過: def_orbit_transposition, claim_orbit_transposition_bijective')


main()
