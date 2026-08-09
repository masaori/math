# 対象ラベル: claim_non_orbit_preserving_term_zero / claim_shift_char_sum_orbit_preserving
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「軌道を保たない置換の項は零元である」と
# 「シフト行列の特性多項式は、軌道を保つ置換にわたる軌道ごとの因子の積の和である」を、
# 小さい L で総当たりに確かめる。
# すべて ZZ / ZZ[x] / ZZ[x][t] の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. claim_non_orbit_preserving_term_zero。phi が S^O_L に属さないならば、
#      chi_U の和における phi の項が零元であること。**S_L の全ての元について**
#      「S^O_L に属さない ⟹ 項が零元」を確かめる。あわせて、その証明が経由する
#      「phi(tau_1) が tau_1 でも S(tau_1) でもない tau_1 が実際に取れること」
#      （前の主張の対偶）も別に確かめる。対偶の段を飛ばして最終の含意だけを見ると、
#      対偶が実は成り立っていない（=証明の道筋が違う）場合を見逃す。
#   2. claim_shift_char_sum_orbit_preserving。本文の式変形の 3 つの段を**別々に**確かめる。
#      最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す。
#        (a) chi_U = det_t(ch(U)) = sum_{phi in S_L} iota(kappa(sgn phi)) prod_tau ch(U)_{tau,phi(tau)}
#            （定義そのもの。ここは和を S_L の全体で取る）
#        (b) sum_{phi in S_L} = sum_{phi in S^O_L}（零元である項を落としても値が変わらないこと）
#        (c) sum_{phi in S^O_L} 項 = sum_{phi in S^O_L} prod_O W_O(ch(U), phi|_O)
#            （前セクションの項の分解を和の各項へ当てたもの）
#      そのうえで主張そのもの chi_U = sum_{phi in S^O_L} prod_O W_O(ch(U), phi|_O) を確かめる。
#
#   **和が空虚でないことを記録する。** 零元でない項が 1 つも無ければ、この主張は
#   「0 = 0」を見ているだけになる。L ごとに、S_L の元の個数・S^O_L の元の個数・
#   零元でない項の個数を記録し、零元でない項があることを assert する。
#
#   あわせて chi_U を独立な経路（軌道の大きさから作った t^{|O|} - 1 の積）とも突き合わせる。
#   **これは検証であって証明ではない**（その等式は次のセクション以降で示す）。
#   ここで見ておくのは、上の和が「たまたま形が合っているだけ」でないことの裏取りである。
#
# 走らせる範囲（打ち切りを隠さない）。
#   S_L を全列挙して S^O_L を絞るので（軌道ごとの置換から組み立てると、その組み立てが
#   前のセクションの主張になっており循環する）L = 1, 2, 3 に限る。
#   L = 3 で S_L は 8! = 40320 通り、L = 4 では 16! 通りで走らせられない。

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


def orbit_inversion_count(L, phi, o):
    """def_orbit_inversion_count: inv_O(phi|_O)。台は F(O,O)。"""
    return len([
        (key_1, key_2)
        for key_1 in sorted(o)
        for key_2 in sorted(o)
        if less(L, key_1, key_2) and less(L, phi[key_2], phi[key_1])
    ])


def orbit_permutation_sign(L, phi, o):
    """def_orbit_permutation_sign: sgn_O(phi|_O) = (-1)^{inv_O(phi|_O)}。"""
    return (-1) ** orbit_inversion_count(L, phi, o)


def orbit_factor(L, B, o, phi):
    """def_orbit_term_factor: W_O(B,psi) = iota(kappa(sgn_O(psi))) * prod_{tau in O} B_{tau,psi(tau)}。"""
    product = SecondPolynomialRing(1)
    for key in sorted(o):
        product *= B[(key, phi[key])]
    return iota_kappa(orbit_permutation_sign(L, phi, o)) * product


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


def check_non_orbit_preserving_term_zero(L, all_perms, orbit_perms, B, pairs):
    """1: 軌道を保たない置換の項は零元である（S_L の全ての元で確かめる）。"""
    keys = row_matrix_keys(L)
    zero = SecondPolynomialRing(0)
    outside = 0
    witnessed = 0
    for phi in all_perms:
        if is_orbit_preserving_map(L, phi):
            continue
        outside += 1
        # 本文の証明が経由する段: phi(tau_1) が tau_1 でも S(tau_1) でもない tau_1 が取れること
        # （claim_fixed_or_shift_preserves_orbit の対偶）。
        witnesses = [
            key for key in keys
            if phi[key] != key and phi[key] != shift_key(L, key)
        ]
        assert witnesses, (L, '軌道を保たない置換に、対偶が与える tau_1 が無い')
        witnessed += 1
        # 主張そのもの。
        term = permutation_term(L, B, phi, permutation_sign(L, phi, pairs))
        assert term == zero, (L, '軌道を保たない置換の項が零元でない')
    assert outside == len(all_perms) - len(orbit_perms), (L, 'S_L 外の個数が合わない')
    print(f'OK: L={L} で軌道を保たない置換 {outside} 個の項はいずれも零元'
          f'（うち {witnessed} 個で対偶が与える tau_1 を実際に取った）')
    return outside


def check_char_poly_sum(L, all_perms, orbit_perms, B, pairs, orbits):
    """2: chi_U = sum_{phi in S^O_L} prod_O W_O(ch(U), phi|_O)。式変形の 3 段を別々に見る。"""
    zero = SecondPolynomialRing(0)
    # (a) chi_U = det_t(ch(U))（定義そのもの。和は S_L の全体で取る）。
    chi = zero
    for phi in all_perms:
        chi += permutation_term(L, B, phi, permutation_sign(L, phi, pairs))
    # (b) 零元である項を落としても値は変わらない。
    restricted = zero
    nonzero_terms = 0
    for phi in orbit_perms:
        term = permutation_term(L, B, phi, permutation_sign(L, phi, pairs))
        restricted += term
        if term != zero:
            nonzero_terms += 1
    assert chi == restricted, (L, '和を S^O_L へ狭めた段で値が変わった')
    # (c) 各項を軌道ごとの因子の積へ置き換える。
    factored = zero
    for phi in orbit_perms:
        product = SecondPolynomialRing(1)
        for o in orbits:
            product *= orbit_factor(L, B, o, phi)
        factored += product
    assert restricted == factored, (L, '各項を軌道ごとの因子の積へ置き換えた段で値が変わった')
    # 主張そのもの。
    assert chi == factored, (L, 'chi_U が軌道ごとの因子の積の和と一致しない')
    assert nonzero_terms > 0, (L, '零元でない項が 1 つも無い（主張が空虚）')
    print(f'OK: L={L} で chi_U = sum_{{phi in S^O_L}} prod_O W_O(ch(U), phi|_O)'
          f'（式変形の 3 段 (a)(b)(c) を別々に確認。S_L は {len(all_perms)} 個、'
          f'S^O_L は {len(orbit_perms)} 個、零元でない項は {nonzero_terms} 個）')
    return chi


def check_against_orbit_product(L, chi, orbits):
    """独立な経路との突き合わせ（**検証であって証明ではない**。次のセクション以降で示す）。"""
    expected = SecondPolynomialRing(1)
    for o in orbits:
        expected *= t ** len(o) - SecondPolynomialRing(1)
    assert chi == expected, (L, 'chi_U が prod_O (t^{|O|} - 1) と一致しない')
    sizes = sorted(len(o) for o in orbits)
    print(f'記録: L={L} で chi_U = prod_O (t^{{|O|}} - 1) と一致した'
          f'（軌道の大きさ {sizes}。これは検証であって証明ではない）')


def main():
    for L in [1, 2, 3]:
        orbits = orbit_set(L)
        pairs = ordered_pair_keys(L)
        all_perms = all_permutations_as_keys(L)
        orbit_perms = [phi for phi in all_perms if is_orbit_preserving_map(L, phi)]
        B = characteristic_matrix(L, shift_matrix(L))
        outside = check_non_orbit_preserving_term_zero(L, all_perms, orbit_perms, B, pairs)
        chi = check_char_poly_sum(L, all_perms, orbit_perms, B, pairs, orbits)
        check_against_orbit_product(L, chi, orbits)
        if outside == 0:
            print(f'記録: L={L} では S_L = S^O_L なので、上の 1 は空虚である')
    print('（L=4 以上は S_L の全列挙（16! 通り）ができないので走らせていない）')
    print('すべての検証が通った'
          '（chi_U は軌道を保つ置換にわたる、軌道ごとの因子の積の和である）')


main()
