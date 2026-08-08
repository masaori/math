# 対象ラベル: def_shift_matrix / claim_shift_matrix_left / claim_shift_matrix_right /
#             theorem_shift_matrix_commutes
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で定めた
# シフト行列 U と、それが転送行列 T と可換であること UT = TU を、小さい L で
# 総当たりに確かめる。すべて ZZ[x] の中の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. def_shift_matrix。U の成分が kappa(1) / kappa(0) のいずれかであり、
#      各行にちょうど 1 つだけ kappa(1) が現れること（S が写像であることの帰結）。
#      あわせて各列にもちょうど 1 つであること（S が全単射であることの帰結）も見る。
#   2. claim_shift_matrix_left。(UA)_{tau,tau''} = A_{S(tau),tau''}。
#   3. claim_shift_matrix_right。(AU)_{tau,tau''} = A_{tau,S'(tau'')}。
#   4. theorem_shift_matrix_commutes。UT = TU（全成分の一致）。
#
# 2 と 3 は「任意の行列 A について」の主張なので、行列を 3 種類で試す。転送行列 T、
# 成分がすべて異なる x の冪である行列、そして単位行列である。2 種目を入れるのは、
# T が対称な成分を多く持つため添字の順序を取り違えても値が変わらない場合があり、
# T だけでは左右の取り違えが隠れるからである。
#
# 主張が空でないことの確認も行う（下の check_not_vacuous）。
# U が単位行列と一致してしまえば 2・3・4 は自明に成り立つので、S が恒等写像でない
# L では U != I であることを見る。また T が U と可換でない行列と可換であるとは
# 限らないこと（可換性が転送行列の性質であること）も、反例を挙げて確かめる。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def column_translation(L, y):
    """def_column_translation: gamma(y) = y +_{Z/LZ} 1bar。"""
    return (y + 1) % L


def column_translation_inverse(L, y):
    """claim_column_translation_bijective の gamma'。"""
    return (y - 1) % L


def row_shift(L, tau):
    """def_row_config_shift: (S(tau))(y) = tau(gamma(y))。"""
    return {y: tau[column_translation(L, y)] for y in range(L)}


def row_shift_inverse(L, tau):
    """claim_row_config_shift_bijective の S'。"""
    return {y: tau[column_translation_inverse(L, y)] for y in range(L)}


def shift_matrix(L):
    """def_shift_matrix: U_{tau,tau'} は tau' = S(tau) なら kappa(1)、そうでなければ kappa(0)。

    本文と同じく整数を直接は成分に置かず、const_poly（def_constant_polynomial）を通す。
    """
    keys = row_matrix_keys(L)
    entries = {}
    for key in keys:
        shifted_key = row_config_key(L, row_shift(L, row_config_from_key(key)))
        for key_other in keys:
            entries[(key, key_other)] = (
                const_poly(1) if key_other == shifted_key else const_poly(0)
            )
    return entries


def distinct_power_matrix(L):
    """成分がすべて異なる x の冪である行列（添字の取り違えを検出するための試験用）。"""
    keys = row_matrix_keys(L)
    entries = {}
    for i, a in enumerate(keys):
        for j, b in enumerate(keys):
            entries[(a, b)] = x ** ZZ(i * len(keys) + j)
    return entries


def test_matrices(L):
    """2・3 で使う行列 3 種（転送行列・成分がすべて異なる冪・単位行列）。"""
    return [
        ('転送行列 T', transfer_matrix(L)),
        ('成分がすべて異なる x の冪の行列', distinct_power_matrix(L)),
        ('単位行列 I', identity_row_matrix(L)),
    ]


def check_shift_matrix_shape(L):
    """1: U の成分が kappa(1)/kappa(0) で、各行・各列にちょうど 1 つの kappa(1) がある。"""
    U = shift_matrix(L)
    keys = row_matrix_keys(L)
    one, zero = const_poly(1), const_poly(0)
    for key in keys:
        row_ones = [b for b in keys if U[(key, b)] == one]
        assert len(row_ones) == 1, (L, key, row_ones)
        column_ones = [a for a in keys if U[(a, key)] == one]
        assert len(column_ones) == 1, (L, key, column_ones)
        for b in keys:
            assert U[(key, b)] in (one, zero), (L, key, b)
            assert U[(key, b)] in PolynomialRingZx, (L, key, b)
    print(f'OK: L={L} で U の成分は kappa(1)/kappa(0) のみ（各行・各列にちょうど 1 つの kappa(1)）')


def check_left_multiplication(L):
    """2: (UA)_{tau,tau''} = A_{S(tau),tau''}。"""
    U = shift_matrix(L)
    keys = row_matrix_keys(L)
    for name, A in test_matrices(L):
        product = row_matrix_product(L, U, A)
        for key in keys:
            shifted_key = row_config_key(L, row_shift(L, row_config_from_key(key)))
            for key_end in keys:
                assert product[(key, key_end)] == A[(shifted_key, key_end)], \
                    (L, name, key, key_end)
    print(f'OK: L={L} で (UA)_{{tau,tau\'\'}} = A_{{S(tau),tau\'\'}}（行列 3 種、全成分）')


def check_right_multiplication(L):
    """3: (AU)_{tau,tau''} = A_{tau,S'(tau'')}。"""
    U = shift_matrix(L)
    keys = row_matrix_keys(L)
    for name, A in test_matrices(L):
        product = row_matrix_product(L, A, U)
        for key in keys:
            for key_end in keys:
                unshifted_key = row_config_key(
                    L, row_shift_inverse(L, row_config_from_key(key_end))
                )
                assert product[(key, key_end)] == A[(key, unshifted_key)], \
                    (L, name, key, key_end)
    print(f'OK: L={L} で (AU)_{{tau,tau\'\'}} = A_{{tau,S\'(tau\'\')}}（行列 3 種、全成分）')


def check_commutation(L):
    """4: UT = TU。"""
    U = shift_matrix(L)
    T = transfer_matrix(L)
    left = row_matrix_product(L, U, T)
    right = row_matrix_product(L, T, U)
    for key in left:
        assert left[key] == right[key], (L, key, left[key], right[key])
        assert left[key] in PolynomialRingZx, (L, key)
    print(f'OK: L={L} で UT = TU（全成分が ZZ[x] の中で厳密に一致）')


def check_not_vacuous():
    """5: 主張が空でないこと。"""
    # U が単位行列と一致してしまえば 2・3・4 は自明。L >= 2 では S が恒等写像でないので U != I。
    for L in [2, 3, 4]:
        U = shift_matrix(L)
        I = identity_row_matrix(L)
        assert U != I, (L, 'U が単位行列と一致している')
    # 可換性が転送行列の性質であること: U と可換でない行列が存在する。
    L = 3
    U = shift_matrix(L)
    A = distinct_power_matrix(L)
    assert row_matrix_product(L, U, A) != row_matrix_product(L, A, U), \
        'U はどんな行列とも可換になってしまっている'
    # T の成分が行配位の対によって実際に異なること（T が定数行列なら 4 は自明）。
    T = transfer_matrix(L)
    assert len(set(T.values())) >= 2, 'T の成分がすべて等しい'
    print('OK: L=2,3,4 で U != I、かつ U と可換でない行列が存在する（主張は空でない）')


def main():
    for L in [1, 2, 3, 4]:
        check_shift_matrix_shape(L)
        check_left_multiplication(L)
        check_right_multiplication(L)
        check_commutation(L)
    check_not_vacuous()
    print('すべての検証が通った（シフト行列と転送行列の可換性）')


main()
