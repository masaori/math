# 対象ラベル: claim_shift_char_orbit_product
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「シフト行列の特性多項式は、軌道ごとの和の積である」
#   chi_U = prod_{O in O_L} ( sum_{psi in B_O} W_O(ch(U), psi) )
# を、小さい L で総当たりに確かめる。
# すべて ZZ / ZZ[x] / ZZ[x][t] の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか（本文の式変形の 3 段を**別々に**見る）:
#   (a) chi_U = sum_{alpha in A_L} prod_O W_O(ch(U), alpha(O))（前セクションの主張）
#   (b) A(O_L) = A_L（和の添字の集合そのものが一致すること。本文の第 2 の等号）
#   (c) 分配則を s = O_L と取った段。
#       sum_{alpha in A(O_L)} prod_O W_O(ch(U), alpha(O))
#         = prod_{O in O_L} ( sum_{psi in B_O} W_O(ch(U), psi) )
#   最終の等式だけを見ると、複数の段が同時に誤っていて辻褄が合う場合を見逃す。
#
#   **和と積が空虚でないことを記録する。** 軌道ごとの和がすべて零元なら積は零元で、
#   「0 = 0」を見ているだけになる。L ごとに軌道ごとの和が零元でない個数を記録し、
#   すべての軌道で零元でないことを assert する。
#
# 走らせる範囲（打ち切りを隠さない）。
#   chi_U を定義（S_L の全列挙）から作る (a) は L = 1, 2, 3 に限る
#   （L = 3 で S_L は 8! = 40320 通り、L = 4 では 16! 通りで走らせられない）。
#   S_L を要さない (b)(c) は L = 4 まで走らせる。

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


def shift_key(L, key):
    """S をキーの上の写像として持つ。"""
    return row_config_key(L, row_shift(L, row_config_from_key(key)))


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


def orbit_bijections(o):
    """def_orbit_bijection_set: B_O（O の上の全単射の全体）を全列挙する。"""
    members = sorted(o)
    return [dict(zip(members, image)) for image in itertools.permutations(members)]


def families_on(orbits):
    """def_orbit_family_on_subset: A(s)（s の各元 O へ B_O の元を対応させる対応の全体）。

    s = O_L と取ったものが def_orbit_permutation_family の A_L である。
    """
    per_orbit = [orbit_bijections(o) for o in orbits]
    return [
        {o: psi for (o, psi) in zip(orbits, combination)}
        for combination in itertools.product(*per_orbit)
    ]


def check_family_on_full_equals_family(L, orbits):
    """(b) A(O_L) = A_L。和の添字の集合そのものが一致すること。

    A_L（def_orbit_permutation_family）の定義は「各 O in O_L へ B_O の元 alpha(O) を
    与える対応の全体」である。ここで確かめるのは、生成手続き families_on(O_L) が
    その定義を満たす対応をちょうど全部作っていることであって、
    **同じ手続きを 2 度走らせて突き合わせることではない**
    （2 度走らせても構成から自明に一致するだけで、何も確かめたことにならない）。

    そこで 2 つに分けて見る。
      健全性: families_on(O_L) の各元が A_L の定義を満たすこと
              （定義域がちょうど O_L で、値 alpha(O) が O の上の全単射であること）を
              生成手続きに依らず、その場で判定して確かめる。
      完全性: 定義を満たす対応の全体は各軌道ごとの独立な選択なので prod_O |B_O| 個であり、
              |B_O| = |O|! である。families_on(O_L) の元が相異なり、その個数が
              prod_O factorial(|O|) に一致すれば、健全性と合わせて両者は一致する。
    """
    families_full = families_on(orbits)          # A(s) を s = O_L で取ったもの
    orbit_keys = {frozenset(o) for o in orbits}
    # 健全性。
    for alpha in families_full:
        assert {frozenset(o) for o in alpha.keys()} == orbit_keys, (
            L, 'A(O_L) の元の定義域が O_L と一致しない')
        for o in orbits:
            psi = alpha[o]
            assert set(psi.keys()) == set(o), (L, 'alpha(O) の定義域が O でない')
            assert set(psi.values()) == set(o), (L, 'alpha(O) が O の上の全単射でない')
    # 完全性（元が相異なることと、個数が独立に数えた prod_O |O|! に一致すること）。
    as_tuples = {
        tuple(tuple(sorted(alpha[o].items())) for o in orbits) for alpha in families_full
    }
    assert len(as_tuples) == len(families_full), (L, 'A(O_L) に重複がある')
    expected = 1
    for o in orbits:
        assert len(orbit_bijections(o)) == factorial(len(o)), (L, '|B_O| が |O|! でない')
        expected *= factorial(len(o))
    assert len(families_full) == expected, (L, 'A(O_L) の個数が prod_O |O|! と一致しない')
    print(f'OK: L={L} で A(O_L) = A_L'
          f'（各元が A_L の定義を満たし、個数 {len(families_full)} が'
          f' prod_O |O|! = {expected} に一致する）')
    return families_full


def check_distributive_at_full(L, families, B, orbits):
    """(c) 分配則を s = O_L と取った段。

    sum_{alpha in A(O_L)} prod_O W_O(ch(U), alpha(O))
      = prod_{O in O_L} ( sum_{psi in B_O} W_O(ch(U), psi) )
    """
    zero = SecondPolynomialRing(0)
    left = zero
    for alpha in families:
        product = SecondPolynomialRing(1)
        for o in orbits:
            product *= orbit_factor(L, B, o, alpha[o])
        left += product
    right = SecondPolynomialRing(1)
    nonzero_orbit_sums = 0
    for o in orbits:
        orbit_sum = zero
        for psi in orbit_bijections(o):
            orbit_sum += orbit_factor(L, B, o, psi)
        if orbit_sum != zero:
            nonzero_orbit_sums += 1
        right *= orbit_sum
    assert left == right, (L, '分配則を s = O_L と取った段で値が変わった')
    # 積が空虚でないこと。どれか 1 つの軌道の和が零元なら積は零元になる。
    assert nonzero_orbit_sums == len(orbits), (L, '零元の軌道和がある（積が空虚）')
    print(f'OK: L={L} で分配則の s = O_L の場合が成り立つ'
          f'（A(O_L) は {len(families)} 個、軌道は {len(orbits)} 個で'
          f'そのすべての和が零元でない）')
    return right


def check_char_poly_orbit_product(L, families, B, pairs, orbits, right):
    """(a) と主張そのもの。chi_U を定義から作り、軌道ごとの和の積と突き合わせる。"""
    zero = SecondPolynomialRing(0)
    chi = zero
    for phi in all_permutations_as_keys(L):
        chi += permutation_term(L, B, phi, permutation_sign(L, phi, pairs))
    # (a) 前セクションの主張。chi_U = sum_{alpha in A_L} prod_O W_O(ch(U), alpha(O))。
    family_sum = zero
    for alpha in families:
        product = SecondPolynomialRing(1)
        for o in orbits:
            product *= orbit_factor(L, B, o, alpha[o])
        family_sum += product
    assert chi == family_sum, (L, '前セクションの主張が成り立たない')
    # 主張そのもの。
    assert chi == right, (L, 'chi_U が軌道ごとの和の積と一致しない')
    assert chi != zero, (L, 'chi_U が零元（主張が空虚）')
    print(f'OK: L={L} で chi_U = prod_O ( sum_{{psi in B_O}} W_O(ch(U), psi) )'
          f'（chi_U は S_L の {len(all_permutations_as_keys(L))} 個の項の和から作った）')


def main():
    # S_L を要さない (b)(c) は L = 4 まで走らせる。
    for L in [1, 2, 3, 4]:
        orbits = orbit_set(L)
        B = characteristic_matrix(L, shift_matrix(L))
        families = check_family_on_full_equals_family(L, orbits)
        check_distributive_at_full(L, families, B, orbits)
    # chi_U を定義（S_L の全列挙）から作る (a) は L = 3 までに限る。
    for L in [1, 2, 3]:
        orbits = orbit_set(L)
        pairs = ordered_pair_keys(L)
        B = characteristic_matrix(L, shift_matrix(L))
        families = families_on(orbits)
        right = check_distributive_at_full(L, families, B, orbits)
        check_char_poly_orbit_product(L, families, B, pairs, orbits, right)
    print('（L=4 以上で chi_U を定義から作る部分は、S_L の全列挙（16! 通り）ができないので'
          '走らせていない）')
    print('すべての検証が通った'
          '（chi_U は軌道ごとの和の積である）')


main()
