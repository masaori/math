# 対象ラベル: def_orbit_restriction_family / claim_gluing_restriction_family /
#             claim_restriction_family_gluing / claim_shift_char_sum_family
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「制限の組を貼り合わせるともとの置換に戻る」「貼り合わせの制限の組はもとの組に戻る」
# 「シフト行列の特性多項式は、軌道ごとの置換の組にわたる和である」を、
# 小さい L で総当たりに確かめる。
# すべて ZZ / ZZ[x] / ZZ[x][t] の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. def_orbit_restriction_family。phi in S^O_L について res(phi) が実際に A_L の元で
#      あること（各軌道 O で O から O への全単射になっていること）。定義が定まることを
#      主張とは別に見る。値が O からはみ出していても、あとの等式だけは成り立ちうるからである。
#   2. claim_gluing_restriction_family。gl(res(phi)) = phi。
#      本文の証明が経由する段（各軌道での制限が一致すること）も別に確かめる。
#      最終の等式だけを見ると、制限が一致していないのに置換としては一致している
#      （＝本文の道筋が使えない）場合を見逃す。
#   3. claim_restriction_family_gluing。res(gl(alpha)) = alpha。
#      こちらも軌道ごとの一致を別に確かめる。
#   4. claim_shift_char_sum_family。本文の式変形の 3 段を**別々に**確かめる。
#      最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す。
#        (a) chi_U = sum_{phi in S^O_L} prod_O W_O(ch(U), phi|_O)（前セクションの主張）
#        (b) 和の添字を res と gl で A_L へ取り替えても値が変わらないこと
#        (c) gl(alpha)|_O を alpha(O) へ置き換えても値が変わらないこと
#
#   **和が空虚でないことを記録する。** 零元でない項が 1 つも無ければ「0 = 0」を
#   見ているだけになる。L ごとに A_L の元の個数と零元でない項の個数を記録し、
#   零元でない項があることを assert する。
#
# 走らせる範囲（打ち切りを隠さない）。
#   S^O_L を作るのに S_L の全列挙から絞る（軌道ごとの置換から組み立てると、その組み立てが
#   まさにここで確かめようとしている対応になっており循環する）ので、S^O_L が要る 2・4 は
#   L = 1, 2, 3 に限る。L = 3 で S_L は 8! = 40320 通り、L = 4 では 16! 通りで走らせられない。
#   A_L だけで閉じる 1・3 は L = 4 まで走らせる（L = 4 で A_L は 27648 個）。

import os
import itertools

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


# def_second_polynomial_ring: ZZ[x] を係数環とする、もう 1 つの不定元 t の多項式環。
SecondPolynomialRing = PolynomialRing(PolynomialRingZx, 't')
t = SecondPolynomialRing.gen()


def iota(a):
    """def_second_constant_embedding: ZZ[x] の元を t について定数な元へ送る。"""
    return SecondPolynomialRing(PolynomialRingZx(a))


def iota_kappa(n):
    """整数を ZZ[x][t] の元として使う唯一の経路 iota o kappa。"""
    return iota(const_poly(n))


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
    """S をキーの上の写像として持つ。"""
    return row_config_key(L, row_shift(L, row_config_from_key(key)))


def orbit(L, tau):
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。"""
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_of_key(L, key):
    return orbit(L, row_config_from_key(key))


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return sorted(
        {orbit_of_key(L, key) for key in row_matrix_keys(L)}, key=lambda o: sorted(o)
    )


def less(L, key_1, key_2):
    """def_row_config_order: tau ≺ tau'（キーで受ける）。"""
    return row_config_less(L, row_config_from_key(key_1), row_config_from_key(key_2))


def all_permutations_as_keys(L):
    """S_L を全列挙し、キーの辞書として返す。"""
    result = []
    for phi in row_permutations(L):
        result.append({
            key: row_config_key(L, apply_row_permutation(L, phi, row_config_from_key(key)))
            for key in row_matrix_keys(L)
        })
    return result


def is_orbit_preserving_map(L, phi_keys):
    """def_orbit_preserving_permutation: 任意の tau で phi(tau) in O(tau) か。"""
    return all(phi_keys[key] in orbit_of_key(L, key) for key in row_matrix_keys(L))


def ordered_pair_keys(L):
    """def_inversion_count: P_L をキーの対で持つ。"""
    keys = row_matrix_keys(L)
    return [
        (key_1, key_2) for key_1 in keys for key_2 in keys if less(L, key_1, key_2)
    ]


def inversion_count(L, phi, pairs):
    """def_inversion_count: inv(phi) = |Inv(phi)|。"""
    return len([
        (key_1, key_2) for (key_1, key_2) in pairs if less(L, phi[key_2], phi[key_1])
    ])


def permutation_sign(L, phi, pairs):
    """def_permutation_sign: sgn(phi) = (-1)^{inv(phi)}。"""
    return (-1) ** inversion_count(L, phi, pairs)


def orbit_inversion_count(L, psi, o):
    """def_orbit_inversion_count: inv_O(psi)。台は F(O,O)。"""
    return len([
        (key_1, key_2)
        for key_1 in sorted(o)
        for key_2 in sorted(o)
        if less(L, key_1, key_2) and less(L, psi[key_2], psi[key_1])
    ])


def orbit_permutation_sign(L, psi, o):
    """def_orbit_permutation_sign: sgn_O(psi) = (-1)^{inv_O(psi)}。"""
    return (-1) ** orbit_inversion_count(L, psi, o)


def orbit_factor(L, B, o, psi):
    """def_orbit_term_factor: W_O(B,psi) = iota(kappa(sgn_O(psi))) * prod_{tau in O} B_{tau,psi(tau)}。"""
    product = SecondPolynomialRing(1)
    for key in sorted(o):
        product *= B[(key, psi[key])]
    return iota_kappa(orbit_permutation_sign(L, psi, o)) * product


def permutation_term(L, B, phi, sgn):
    """def_second_determinant の和の phi の項。"""
    product = SecondPolynomialRing(1)
    for key in row_matrix_keys(L):
        product *= B[(key, phi[key])]
    return iota_kappa(sgn) * product


def shift_matrix(L):
    """def_shift_matrix: U_{tau,tau'} は tau' = S(tau) なら kappa(1)、そうでなければ kappa(0)。"""
    keys = row_matrix_keys(L)
    entries = {}
    for key in keys:
        shifted_key = shift_key(L, key)
        for key_other in keys:
            entries[(key, key_other)] = (
                const_poly(1) if key_other == shifted_key else const_poly(0)
            )
    return entries


def characteristic_matrix(L, A):
    """def_characteristic_matrix: 対角は t + iota(-A_{tau,tau})、他は iota(-A_{tau,tau'})。"""
    keys = row_matrix_keys(L)
    entries = {}
    for a in keys:
        for b in keys:
            entries[(a, b)] = (t if a == b else SecondPolynomialRing(0)) + iota(-A[(a, b)])
    return entries


def restriction_family(L, phi, orbits):
    """def_orbit_restriction_family: res(phi)（各軌道 O へ phi|_O を対応させる組）。"""
    return {o: {key: phi[key] for key in sorted(o)} for o in orbits}


def glue(L, alpha, orbits):
    """def_orbit_gluing: (gl(alpha))(tau) = (alpha(O(tau)))(tau)。"""
    return {
        key: alpha[orbit_of_key(L, key)][key] for key in row_matrix_keys(L)
    }


def orbit_families(L, orbits):
    """def_orbit_permutation_family: A_L を全列挙する（各軌道の上の全単射の組）。"""
    per_orbit = []
    for o in orbits:
        members = sorted(o)
        maps = []
        for image in itertools.permutations(members):
            maps.append(dict(zip(members, image)))
        per_orbit.append(maps)
    result = []
    for combination in itertools.product(*per_orbit):
        result.append({o: psi for (o, psi) in zip(orbits, combination)})
    return result


def check_restriction_family_is_family(L, orbit_perms, orbits):
    """1: res(phi) が A_L の元であること（各軌道の上の全単射になっていること）。"""
    for phi in orbit_perms:
        alpha = restriction_family(L, phi, orbits)
        assert set(alpha.keys()) == set(orbits), (L, 'res(phi) の定義域が O_L でない')
        for o in orbits:
            psi = alpha[o]
            assert set(psi.keys()) == set(o), (L, 'res(phi)(O) の定義域が O でない')
            values = [psi[key] for key in sorted(o)]
            assert set(values) <= set(o), (L, 'res(phi)(O) の値が O からはみ出した')
            assert len(set(values)) == len(o), (L, 'res(phi)(O) が全単射でない')
    print(f'OK: L={L} で res(phi) はいずれも A_L の元である'
          f'（S^O_L の {len(orbit_perms)} 個で確認）')


def check_glue_restriction(L, orbit_perms, orbits):
    """2: gl(res(phi)) = phi。経由する段（軌道ごとの制限の一致）も別に見る。"""
    for phi in orbit_perms:
        alpha = restriction_family(L, phi, orbits)
        glued = glue(L, alpha, orbits)
        # 本文の証明が経由する段: 各軌道への制限が一致すること。
        for o in orbits:
            for key in sorted(o):
                assert glued[key] == phi[key], (L, 'gl(res(phi)) の軌道への制限が phi と違う')
        # 主張そのもの。
        assert glued == phi, (L, 'gl(res(phi)) = phi が成り立たない')
    print(f'OK: L={L} で gl(res(phi)) = phi（S^O_L の {len(orbit_perms)} 個で確認。'
          f'各軌道への制限の一致も別に確認）')


def check_restriction_glue(L, families, orbits):
    """3: res(gl(alpha)) = alpha。軌道ごとの一致も別に見る。"""
    for alpha in families:
        glued = glue(L, alpha, orbits)
        back = restriction_family(L, glued, orbits)
        for o in orbits:
            assert back[o] == alpha[o], (L, 'res(gl(alpha))(O) が alpha(O) と違う')
        assert back == alpha, (L, 'res(gl(alpha)) = alpha が成り立たない')
    print(f'OK: L={L} で res(gl(alpha)) = alpha（A_L の {len(families)} 個で確認。'
          f'軌道ごとの一致も別に確認）')


def check_correspondence_is_bijection(L, orbit_perms, families, orbits):
    """2 と 3 を合わせて、S^O_L と A_L が 1 対 1 に対応すること。"""
    glued = [glue(L, alpha, orbits) for alpha in families]
    assert len(orbit_perms) == len(families), (L, 'S^O_L と A_L の個数が合わない')
    keys = row_matrix_keys(L)
    as_tuples = {tuple(phi[key] for key in keys) for phi in glued}
    expected = {tuple(phi[key] for key in keys) for phi in orbit_perms}
    assert as_tuples == expected, (L, 'A_L の貼り合わせの全体が S^O_L と一致しない')
    print(f'OK: L={L} で S^O_L と A_L は 1 対 1 に対応する（どちらも {len(families)} 個）')


def check_char_poly_family_sum(L, orbit_perms, families, B, pairs, orbits):
    """4: chi_U = sum_{alpha in A_L} prod_O W_O(ch(U), alpha(O))。式変形の 3 段を別々に見る。"""
    zero = SecondPolynomialRing(0)
    # (a) 前セクションの主張。chi_U = sum_{phi in S^O_L} prod_O W_O(ch(U), phi|_O)。
    chi = zero
    for phi in row_permutations_as_maps(L):
        chi += permutation_term(L, B, phi, permutation_sign(L, phi, pairs))
    restricted = zero
    for phi in orbit_perms:
        product = SecondPolynomialRing(1)
        for o in orbits:
            product *= orbit_factor(L, B, o, restriction_family(L, phi, orbits)[o])
        restricted += product
    assert chi == restricted, (L, '前セクションの主張が成り立たない')
    # (b) 和の添字を A_L へ取り替える（phi = gl(alpha) を代入する）。
    reindexed = zero
    for alpha in families:
        glued = glue(L, alpha, orbits)
        product = SecondPolynomialRing(1)
        for o in orbits:
            product *= orbit_factor(L, B, o, restriction_family(L, glued, orbits)[o])
        reindexed += product
    assert restricted == reindexed, (L, '和の添字を A_L へ取り替えた段で値が変わった')
    # (c) gl(alpha)|_O を alpha(O) へ置き換える。
    final = zero
    nonzero_terms = 0
    for alpha in families:
        product = SecondPolynomialRing(1)
        for o in orbits:
            product *= orbit_factor(L, B, o, alpha[o])
        final += product
        if product != zero:
            nonzero_terms += 1
    assert reindexed == final, (L, 'gl(alpha)|_O を alpha(O) へ置き換えた段で値が変わった')
    # 主張そのもの。
    assert chi == final, (L, 'chi_U が A_L にわたる和と一致しない')
    assert nonzero_terms > 0, (L, '零元でない項が 1 つも無い（主張が空虚）')
    print(f'OK: L={L} で chi_U = sum_{{alpha in A_L}} prod_O W_O(ch(U), alpha(O))'
          f'（式変形の 3 段 (a)(b)(c) を別々に確認。A_L は {len(families)} 個、'
          f'零元でない項は {nonzero_terms} 個）')
    return chi


def row_permutations_as_maps(L):
    """S_L をキーの辞書として全列挙する（chi_U を定義から作るために要る）。"""
    return all_permutations_as_keys(L)


def main():
    # A_L だけで閉じる 1・3 は L = 4 まで走らせる。
    for L in [1, 2, 3, 4]:
        orbits = orbit_set(L)
        families = orbit_families(L, orbits)
        check_restriction_glue(L, families, orbits)
    # S^O_L を S_L の全列挙から絞る 1・2・4 は L = 3 までに限る。
    for L in [1, 2, 3]:
        orbits = orbit_set(L)
        pairs = ordered_pair_keys(L)
        families = orbit_families(L, orbits)
        orbit_perms = [
            phi for phi in all_permutations_as_keys(L) if is_orbit_preserving_map(L, phi)
        ]
        B = characteristic_matrix(L, shift_matrix(L))
        check_restriction_family_is_family(L, orbit_perms, orbits)
        check_glue_restriction(L, orbit_perms, orbits)
        check_correspondence_is_bijection(L, orbit_perms, families, orbits)
        check_char_poly_family_sum(L, orbit_perms, families, B, pairs, orbits)
    print('（L=4 以上で S^O_L を要する部分は、S_L の全列挙（16! 通り）ができないので'
          '走らせていない）')
    print('すべての検証が通った'
          '（chi_U は軌道ごとの置換の組にわたる和である）')


main()
