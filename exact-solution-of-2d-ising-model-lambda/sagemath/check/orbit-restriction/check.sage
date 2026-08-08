# 対象ラベル: def_orbit_restriction / claim_orbit_restriction_bijective /
#             claim_orbit_restriction_determines
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「軌道を保つ置換の、軌道への制限」の定義と、その 2 つの性質を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像の比較であり、浮動小数点は使わない（数は ZZ の中の個数だけ）。
#
# 何を確かめるか:
#   1. def_orbit_restriction が写像として定まること。すなわち phi in S^O_L と O in O_L について、
#      任意の tau in O で phi(tau) in O であること（行き先が O に収まること）。
#      これは定義がそもそも意味を持つための条件であり、本文が
#      claim_orbit_preserving_image から出している段にあたる。
#      **これを別に確かめる理由**: 下の 2 の全単射性だけを見ると、行き先が O からはみ出していても
#      「はみ出した先も含めた集合の上の全単射」として成り立ってしまい、定義の破れが隠れる。
#   2. claim_orbit_restriction_bijective。phi|_O が O から O への全単射であること。
#      人手証明が単射性と全射性を別々に示しているので、検証も別々に確かめる。
#      単射性は O の全対、全射性は O の各元について逆像を実際に見つける形で確かめる。
#   3. claim_orbit_restriction_determines。任意の O in O_L で phi|_O = psi|_O ならば phi = psi。
#      S^O_L の全対を総当たりする。**対偶の側も確かめる**。すなわち phi != psi ならば
#      制限が食い違う軌道が実際に存在すること。含意だけを見ると、制限がすべて一致する対が
#      そもそも同じ置換しか無い（＝仮定が空虚）場合を見逃すためである。
#
# 主張が空でないことの確認も行う（下の check_not_vacuous）。
#   - L=3 で S^O_L は恒等置換だけではない（36 個ある）。すなわち 2 と 3 の主張は自明でない。
#   - L=3 で phi|_O が恒等でない軌道が実際にある。すなわち制限が動かす場合が空でない。
#   - L=3 で相異なる 2 つの軌道を保つ置換の対が実際にあり、3 の対偶が空でない。
#
# 走らせる L の範囲について。
#   S_L の個数は (2^L)! なので全列挙できるのは L=1,2,3 まで（L=3 で 40320 個、L=4 では 16!）。
#   S^O_L だけを軌道ごとの置換から組み立てれば L=4 も回せるが、**その組み立てが成り立つこと
#   （軌道ごとの置換の組と S^O_L が 1 対 1 に対応すること）は次のセクションで示す主張であり、
#   ここでそれを前提にすると検証が循環する。** したがって L=1,2,3 に限る。
#   この打ち切りは overview.md にも書いてある。

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


def orbit(L, tau):
    """def_row_config_orbit: O(tau) = { S^[k](tau) | k in N }（キーの凍結集合として持つ）。

    反復は高々 L 回でもとへ戻るので k を 0..L-1 まで走らせれば全体が得られる
    （本文の claim_row_config_shift_period による）。
    """
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return {orbit(L, row_config_from_key(key)) for key in row_matrix_keys(L)}


def is_orbit_preserving(L, phi):
    """def_orbit_preserving_permutation: 任意の tau で phi(tau) in O(tau) か。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        image_key = row_config_key(L, apply_row_permutation(L, phi, tau))
        if image_key not in orbit(L, tau):
            return False
    return True


def orbit_preserving_permutations(L):
    """S^O_L を全列挙する。S_L を全列挙して定義の条件で絞る（組み立てを前提にしない）。"""
    return [phi for phi in row_permutations(L) if is_orbit_preserving(L, phi)]


def orbit_restriction(L, phi, o):
    """def_orbit_restriction: phi|_O。O の元のキーから phi の像のキーへの辞書として持つ。

    行き先が O に収まることは検証の対象なのでここでは仮定しない
    （収まっているかは check_restriction_well_defined が別に見る）。
    """
    return {
        key: row_config_key(L, apply_row_permutation(L, phi, row_config_from_key(key)))
        for key in o
    }


def check_restriction_well_defined(L, orbit_preserving):
    """1: phi|_O の行き先が O に収まること（定義が意味を持つこと）。"""
    orbits = orbit_set(L)
    for phi in orbit_preserving:
        for o in orbits:
            for key in o:
                image_key = row_config_key(
                    L, apply_row_permutation(L, phi, row_config_from_key(key)))
                assert image_key in o, (L, o, key, image_key, 'phi(tau) が O からはみ出した')
    print(f'OK: L={L} で phi|_O の行き先は O に収まる'
          f'（軌道を保つ置換 {len(orbit_preserving)} 個 x 軌道 {len(orbits)} 個の全元）')


def check_restriction_bijective(L, orbit_preserving):
    """2: phi|_O が O から O への全単射であること。単射性と全射性を別々に見る。"""
    orbits = orbit_set(L)
    for phi in orbit_preserving:
        for o in orbits:
            restriction = orbit_restriction(L, phi, o)
            # 単射性。O の全対を走る（人手証明の「phi が単射だから」に対応する結論の側）。
            for key_1 in o:
                for key_2 in o:
                    if restriction[key_1] == restriction[key_2]:
                        assert key_1 == key_2, (L, o, key_1, key_2, '制限が単射でない')
            # 全射性。O の各元について逆像を実際に見つける
            #（人手証明が claim_orbit_preserving_image から tau_3 を取る段に対応する）。
            for key_target in o:
                sources = [key for key in o if restriction[key] == key_target]
                assert len(sources) >= 1, (L, o, key_target, '制限が全射でない')
    print(f'OK: L={L} で phi|_O は O から O への全単射（単射性と全射性を別々に確認）')


def check_restriction_determines(L, orbit_preserving):
    """3: 制限の全体が一致する軌道を保つ置換は一致する。全対を総当たり。対偶も見る。"""
    orbits = sorted(orbit_set(L), key=lambda o: sorted(o))
    restrictions = [
        tuple(tuple(sorted(orbit_restriction(L, phi, o).items())) for o in orbits)
        for phi in orbit_preserving
    ]
    differing_seen = False
    for a in range(len(orbit_preserving)):
        for b in range(len(orbit_preserving)):
            same_restrictions = restrictions[a] == restrictions[b]
            same_permutation = orbit_preserving[a] == orbit_preserving[b]
            if same_restrictions:
                assert same_permutation, (L, a, b, '制限が一致するのに置換が異なる')
            if not same_permutation:
                # 対偶: 相異なる置換なら、制限が食い違う軌道が実際にある。
                assert not same_restrictions, (L, a, b)
                differing_seen = True
    assert differing_seen or len(orbit_preserving) == 1, (L, '相異なる対が 1 つも無い')
    print(f'OK: L={L} で制限の全体が一致する軌道を保つ置換は一致する'
          f'（全 {len(orbit_preserving)} x {len(orbit_preserving)} 対。対偶も確認）')


def check_not_vacuous():
    """4: 主張が空でないこと。"""
    L = 3
    orbit_preserving = orbit_preserving_permutations(L)
    # (a) S^O_L は恒等置換だけではない。
    assert len(orbit_preserving) > 1, (L, len(orbit_preserving))
    # (b) 制限が恒等でない場合が実際にある。
    moving_seen = False
    for phi in orbit_preserving:
        for o in orbit_set(L):
            restriction = orbit_restriction(L, phi, o)
            if any(restriction[key] != key for key in o):
                moving_seen = True
    assert moving_seen, (L, '制限がどれも恒等である')
    # (c) 大きさが 2 以上の軌道が実際にある（1 元集合ばかりなら制限は自明）。
    assert any(len(o) >= 2 for o in orbit_set(L)), (L, '軌道がすべて 1 元集合')
    print(f'OK: L=3 で軌道を保つ置換は {len(orbit_preserving)} 個あり、'
          '恒等でない制限も、大きさ 2 以上の軌道も実際にある（主張は空でない）')


def main():
    for L in [1, 2, 3]:
        orbit_preserving = orbit_preserving_permutations(L)
        check_restriction_well_defined(L, orbit_preserving)
        check_restriction_bijective(L, orbit_preserving)
        check_restriction_determines(L, orbit_preserving)
    check_not_vacuous()
    print('すべての検証が通った（軌道を保つ置換の、軌道への制限）')


main()
