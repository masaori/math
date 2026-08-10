# 対象ラベル: claim_orbit_permutation_sign_mul
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した、
# 軌道の上の全単射の符号 sgn_O が合成について乗法的であること
# （sgn_O(psi_1 o psi_2) = sgn_O(psi_1) * sgn_O(psi_2)）を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像と数え上げ、および整数 -1 の冪であり、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段ごとに別々に見る。最終の等式だけを見ると、複数の段が
# 同時に誤っていて辻褄が合う場合を見逃す）:
#   1. 準備の第一。psi_1 o psi_2 が O から O への全単射であること。
#   2. 準備の第二。srt_{psi_2} が F(O,O) から F(O,O) への写像として定まること
#      （像の 2 成分のどちらが小さいかがちょうど 1 つ決まること）。
#   3. 準備の第三。srt_{psi_2} が全単射であり、srt_{psi_2^{-1}} が逆写像であること。
#   4. |A| = inv_O(psi_1 o psi_2)、|B| = inv_O(psi_2)、|C| = inv_O(psi_1) であること。
#      とくに C については、srt_{psi_2} による逆像として作った集合の個数が inv_O(psi_1) に
#      等しいことを見る（ここで srt の全単射性が効く）。
#   5. 各対について A, B, C のうち属するものの個数が偶数であること。
#      あわせて f_A * f_C * f_B = 1 であることを見る。
#   6. sgn_O(psi_1 o psi_2) * sgn_O(psi_1) * sgn_O(psi_2) = 1 であること。
#   7. 結論 sgn_O(psi_1 o psi_2) = sgn_O(psi_1) * sgn_O(psi_2)。
#   8. 主張が空でないこと。両辺が -1 になる例があるかを L ごとに記録する。
#
# 走らせる範囲について（打ち切りを隠さない）。
#   L = 1,...,5 では各軌道 O について B_O × B_O を全列挙する。
#   L = 6 では |O| = 6 の軌道について |B_O| = 720 であり、対の個数が 518400 になるので、
#   B_O を並べた列の先頭 40 個どうしの対（1600 個）に絞る。絞ったことは overview.md に書く。

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


def less(L, key_1, key_2):
    """def_row_config_order: tau ≺ tau'（キーで受ける）。"""
    return row_config_less(L, row_config_from_key(key_1), row_config_from_key(key_2))


def orbit_bijections(L, o):
    """def_orbit_bijection_set: B_O（O から O への全単射の全体）。辞書で返す。"""
    members = sorted(o)
    for image in itertools.permutations(members):
        yield {key: image[i] for i, key in enumerate(members)}


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


def compose(psi_1, psi_2):
    """psi_1 o psi_2（(psi_1 o psi_2)(tau) = psi_1(psi_2(tau))）。"""
    return {key: psi_1[psi_2[key]] for key in psi_2}


def inverse(psi):
    """psi の逆写像（psi が全単射であることを前提に作る）。"""
    return {value: key for key, value in psi.items()}


def srt(L, psi, pair):
    """準備の第二の srt_{psi}: 像の 2 成分を ≺ について並べ直す。"""
    key_1, key_2 = pair
    image_1, image_2 = psi[key_1], psi[key_2]
    if less(L, image_1, image_2):
        return (image_1, image_2)
    return (image_2, image_1)


def check_pair(L, o, pairs, psi_1, psi_2):
    """人手証明の各段を、1 組の (psi_1, psi_2) について確かめる。"""
    members = set(o)
    composite = compose(psi_1, psi_2)

    # 1. 準備の第一。合成が O から O への全単射であること。
    assert set(composite.keys()) == members, (L, '合成の定義域が O でない')
    assert set(composite.values()) == members, (L, '合成が O の上への全射でない')
    assert len(set(composite.values())) == len(members), (L, '合成が単射でない')

    # 2. 準備の第二。srt が定まること（ちょうど一方が成り立つこと）。
    for (key_1, key_2) in pairs:
        image_1, image_2 = psi_2[key_1], psi_2[key_2]
        assert image_1 != image_2, (L, 'psi_2 の単射性が破れた')
        assert less(L, image_1, image_2) != less(L, image_2, image_1), (
            L, '三分律が破れた（srt が定まらない）')
        assert srt(L, psi_2, (key_1, key_2)) in pairs, (L, 'srt の像が F(O,O) に入らない')

    # 3. 準備の第三。srt_{psi_2^{-1}} が srt_{psi_2} の逆写像であること。
    psi_2_inverse = inverse(psi_2)
    for pair in pairs:
        assert srt(L, psi_2_inverse, srt(L, psi_2, pair)) == pair, (
            L, 'srt_{psi_2^{-1}} o srt_{psi_2} が恒等でない')
        assert srt(L, psi_2, srt(L, psi_2_inverse, pair)) == pair, (
            L, 'srt_{psi_2} o srt_{psi_2^{-1}} が恒等でない')

    # 4. A, B, C の個数が 3 つの転倒数に一致すること。
    set_a = {p for p in pairs if less(L, composite[p[1]], composite[p[0]])}
    set_b = {p for p in pairs if less(L, psi_2[p[1]], psi_2[p[0]])}
    set_c = set()
    for p in pairs:
        image = srt(L, psi_2, p)
        if less(L, psi_1[image[1]], psi_1[image[0]]):
            set_c.add(p)
    assert len(set_a) == orbit_inversion_count(L, composite, pairs), (L, '|A| が破れた')
    assert len(set_b) == orbit_inversion_count(L, psi_2, pairs), (L, '|B| が破れた')
    assert len(set_c) == orbit_inversion_count(L, psi_1, pairs), (L, '|C| が破れた')

    # 5. 各対について属するものの個数が偶数であること（f_A * f_C * f_B = 1）。
    for p in pairs:
        count = (1 if p in set_a else 0) + (1 if p in set_b else 0) + (1 if p in set_c else 0)
        assert count % 2 == 0, (L, 'A, B, C のうち属するものの個数が奇数')
        f_a = -1 if p in set_a else 1
        f_b = -1 if p in set_b else 1
        f_c = -1 if p in set_c else 1
        assert f_a * f_c * f_b == 1, (L, 'f_A * f_C * f_B = 1 が破れた')

    # 6. 3 つの符号の積が 1 であること。
    sign_composite = orbit_permutation_sign(L, composite, pairs)
    sign_1 = orbit_permutation_sign(L, psi_1, pairs)
    sign_2 = orbit_permutation_sign(L, psi_2, pairs)
    assert sign_composite * sign_1 * sign_2 == 1, (L, '3 つの符号の積が 1 でない')

    # 7. 結論。
    assert sign_composite == sign_1 * sign_2, (L, '符号の乗法性が破れた')
    return sign_composite


def bijection_list(L, o, limit):
    """B_O を列として持つ（limit が None でなければ先頭 limit 個に絞る）。"""
    all_of_them = list(orbit_bijections(L, o))
    if limit is None or len(all_of_them) <= limit:
        return all_of_them, False
    return all_of_them[:limit], True


def check_orbit_sign_mul(L, orbits, limit):
    total = 0
    negative = False
    truncated = False
    for o in orbits:
        pairs = cross_ordered_pairs(L, o)
        chosen, cut = bijection_list(L, o, limit)
        truncated = truncated or cut
        for psi_1 in chosen:
            for psi_2 in chosen:
                value = check_pair(L, o, pairs, psi_1, psi_2)
                negative = negative or value == -1
                total += 1
    note = '（B_O を先頭 40 個に絞った軌道がある）' if truncated else '（B_O × B_O を全列挙）'
    print(f'OK: L={L} で sgn_O は合成について乗法的である'
          f'（軌道 {len(orbits)} 個、組 {total} 個）{note}')
    sizes = sorted({len(o) for o in orbits})
    print(f'    記録: L={L} 軌道の大きさ {sizes}、合成の符号が -1 になる例は'
          f'{"ある" if negative else "無い（+1 の場合しか見ていない）"}')


def main():
    for L in range(1, 6):
        check_orbit_sign_mul(L, orbit_set(L), None)
    check_orbit_sign_mul(6, orbit_set(6), 40)
    print('すべて通過: claim_orbit_permutation_sign_mul')


main()
