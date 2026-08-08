# 対象ラベル: def_orbit_permutation_family / def_orbit_gluing /
#             claim_orbit_gluing_bijective / claim_orbit_gluing_orbit_preserving /
#             claim_orbit_gluing_restriction
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「軌道ごとの置換の組」とその貼り合わせ gl(alpha) の 3 つの性質を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像の比較であり、浮動小数点は使わない（数として現れるのは個数だけ）。
#
# 何を確かめるか:
#   0. def_orbit_gluing が写像として定まること。すなわち tau in O(tau) であり、
#      O(tau) in O_L であり、alpha(O(tau)) の値が O(tau)（したがって R_L）に収まること。
#      **これを別に確かめる理由**: 下の 1 の全単射性だけを見ると、値が O(tau) からはみ出していても
#      R_L の上の全単射としては成り立ちうるので、定義の破れが隠れる。
#      あわせて、定義が O(tau) を選んでいることが正当である根拠——tau を含む O_L の元は
#      O(tau) だけであること（claim_row_config_orbit_mem_eq）——も確かめる。
#   1. claim_orbit_gluing_bijective。gl(alpha) が R_L の上の全単射であること。
#      人手証明が単射性と全射性を別々に示しているので、検証も別々に確かめる。
#   2. claim_orbit_gluing_orbit_preserving。任意の tau で gl(alpha)(tau) in O(tau)。
#   3. claim_orbit_gluing_restriction。任意の O in O_L で gl(alpha)|_O = alpha(O)。
#   4. 1 対 1 対応。alpha |-> gl(alpha) が単射であり、その像が S^O_L に一致すること。
#      **像の一致は、S_L を全列挙して定義の条件で絞った S^O_L と突き合わせて確かめる。**
#      軌道ごとの置換から組み立てたものを S^O_L の定義に据えると循環するので、そうしない
#      （前のセクションの検証 orbit-restriction でも同じ理由で全列挙から絞っている）。
#
# 走らせる L の範囲について。
#   0〜3 は組 alpha を全列挙すればよいので L=1,2,3,4 まで走らせる
#   （L=4 では軌道の大きさが 1,1,2,4,4,4 で、組は 1*1*2*24*24*24 = 27648 個）。
#   4 は S_L の全列挙（(2^L)! 個）が要るので L=1,2,3 に限る（L=4 では 16! 通りで総当たりできない）。
#   この打ち切りは overview.md にも書いてある。

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


def orbit(L, tau):
    """def_row_config_orbit: O(tau) = { S^[k](tau) | k in N }（キーの凍結集合として持つ）。"""
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_of_key(L, key):
    return orbit(L, row_config_from_key(key))


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return {orbit_of_key(L, key) for key in row_matrix_keys(L)}


def orbit_permutation_families(L):
    """def_orbit_permutation_family: A_L を全列挙する。

    組 alpha は「軌道（キーの凍結集合）-> その上の全単射（キーからキーへの辞書）」の辞書として持つ。
    """
    orbits = sorted(orbit_set(L), key=lambda o: sorted(o))
    per_orbit = []
    for o in orbits:
        keys = sorted(o)
        per_orbit.append([
            dict(zip(keys, images)) for images in itertools.permutations(keys)
        ])
    for choice in itertools.product(*per_orbit):
        yield {orbits[i]: choice[i] for i in range(len(orbits))}


def glue(L, alpha):
    """def_orbit_gluing: gl(alpha)(tau) = (alpha(O(tau)))(tau)。キーからキーへの辞書として持つ。"""
    return {
        key: alpha[orbit_of_key(L, key)][key] for key in row_matrix_keys(L)
    }


def is_orbit_preserving_map(L, phi):
    """def_orbit_preserving_permutation: 任意の tau で phi(tau) in O(tau) か（phi は辞書）。"""
    return all(phi[key] in orbit_of_key(L, key) for key in row_matrix_keys(L))


def orbit_preserving_permutations_by_enumeration(L):
    """S^O_L を S_L の全列挙から絞って得る（組み立てを前提にしない）。辞書のキー表現で返す。"""
    result = []
    for phi in row_permutations(L):
        as_keys = {
            key: row_config_key(L, apply_row_permutation(L, phi, row_config_from_key(key)))
            for key in row_matrix_keys(L)
        }
        if is_orbit_preserving_map(L, as_keys):
            result.append(as_keys)
    return result


def check_orbit_is_unique(L):
    """0 の後半: tau を含む O_L の元は O(tau) だけであること（定義の選び方が正当であること）。"""
    orbits = orbit_set(L)
    for key in row_matrix_keys(L):
        containing = [o for o in orbits if key in o]
        assert containing == [orbit_of_key(L, key)] or (
            len(containing) == 1 and containing[0] == orbit_of_key(L, key)
        ), (L, key, containing, 'tau を含む軌道が O(tau) 以外にもある')
    print(f'OK: L={L} で各行配位を含む軌道は O(tau) ただ 1 つ'
          f'（行配位 {2 ** L} 個 x 軌道 {len(orbits)} 個）')


def check_gluing_well_defined(L, families):
    """0 の前半: gl(alpha) が写像として定まること（値が O(tau) に収まること）。"""
    for alpha in families:
        for key in row_matrix_keys(L):
            o = orbit_of_key(L, key)
            assert key in o, (L, key, 'tau が O(tau) に属していない')
            assert key in alpha[o], (L, key, 'alpha(O(tau)) が tau で定まっていない')
            assert alpha[o][key] in o, (L, key, '(alpha(O(tau)))(tau) が O(tau) からはみ出した')
    print(f'OK: L={L} で gl(alpha) の値は O(tau) に収まる（組 {len(families)} 個の全行配位）')


def check_gluing_bijective(L, families):
    """1: gl(alpha) が R_L の上の全単射であること。単射性と全射性を別々に見る。"""
    keys = row_matrix_keys(L)
    for alpha in families:
        g = glue(L, alpha)
        # 単射性。全対を走る。
        for key_1 in keys:
            for key_2 in keys:
                if g[key_1] == g[key_2]:
                    assert key_1 == key_2, (L, key_1, key_2, 'gl(alpha) が単射でない')
        # 全射性。各行配位について逆像を実際に見つける（人手証明が tau_4 を取る段）。
        for key_target in keys:
            sources = [key for key in keys if g[key] == key_target]
            assert len(sources) >= 1, (L, key_target, 'gl(alpha) が全射でない')
    print(f'OK: L={L} で gl(alpha) は R_L の上の全単射（組 {len(families)} 個。'
          '単射性と全射性を別々に確認）')


def check_gluing_orbit_preserving(L, families):
    """2: gl(alpha) が軌道を保つこと。"""
    for alpha in families:
        g = glue(L, alpha)
        assert is_orbit_preserving_map(L, g), (L, '貼り合わせが軌道を保たない')
    print(f'OK: L={L} で gl(alpha) は軌道を保つ（組 {len(families)} 個）')


def check_gluing_restriction(L, families):
    """3: gl(alpha)|_O = alpha(O)。"""
    orbits = orbit_set(L)
    for alpha in families:
        g = glue(L, alpha)
        for o in orbits:
            restriction = {key: g[key] for key in o}
            assert restriction == alpha[o], (L, o, '制限がもとの組と食い違う')
    print(f'OK: L={L} で gl(alpha)|_O = alpha(O)（組 {len(families)} 個 x 軌道 {len(orbits)} 個）')


def check_correspondence(L, families):
    """4: alpha |-> gl(alpha) が単射で、その像が S^O_L（全列挙から絞ったもの）に一致すること。"""
    glued = [glue(L, alpha) for alpha in families]
    as_tuples = [tuple(sorted(g.items())) for g in glued]
    assert len(set(as_tuples)) == len(as_tuples), (L, '相異なる組が同じ置換へ移った')
    enumerated = orbit_preserving_permutations_by_enumeration(L)
    enumerated_tuples = {tuple(sorted(phi.items())) for phi in enumerated}
    assert set(as_tuples) == enumerated_tuples, (L, '像が S^O_L と一致しない')
    print(f'OK: L={L} で組 {len(families)} 個と S^O_L の {len(enumerated)} 個が'
          '1 対 1 に対応する（S^O_L は S_L の全列挙から絞って作った）')


def check_not_vacuous():
    """5: 主張が空でないこと。"""
    L = 3
    families = list(orbit_permutation_families(L))
    # (a) 組は恒等の組だけではない。
    assert len(families) > 1, (L, len(families))
    # (b) 大きさが 2 以上の軌道が実際にある（1 元集合ばかりなら組は 1 つしかない）。
    assert any(len(o) >= 2 for o in orbit_set(L)), (L, '軌道がすべて 1 元集合')
    # (c) 恒等でない貼り合わせが実際にある。
    moving = [
        alpha for alpha in families
        if any(glue(L, alpha)[key] != key for key in row_matrix_keys(L))
    ]
    assert len(moving) >= 1, (L, '貼り合わせがどれも恒等である')
    # (d) 貼り合わせが軌道をまたいで動かすことはない（軌道を保つ置換の全体が S_L より真に小さい）。
    assert len(families) < factorial(2 ** L), (L, 'S^O_L が S_L と一致してしまう')
    print(f'OK: L=3 で組は {len(families)} 個あり、恒等でない貼り合わせも'
          f'大きさ 2 以上の軌道も実際にある（S_L の {factorial(2 ** 3)} 個より真に少ない）')


def main():
    for L in [1, 2, 3, 4]:
        families = list(orbit_permutation_families(L))
        check_orbit_is_unique(L)
        check_gluing_well_defined(L, families)
        check_gluing_bijective(L, families)
        check_gluing_orbit_preserving(L, families)
        check_gluing_restriction(L, families)
        if L <= 3:
            check_correspondence(L, families)
        else:
            print(f'（L={L} は S_L の全列挙（16! 通り）ができないので 1 対 1 対応の突き合わせは行わない）')
    check_not_vacuous()
    print('すべての検証が通った（軌道ごとの置換の組の貼り合わせ）')


main()
