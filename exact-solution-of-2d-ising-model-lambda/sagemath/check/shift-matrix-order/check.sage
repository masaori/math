# 対象ラベル: def_column_translation_iterate / claim_column_translation_iterate_apply /
#             claim_column_translation_period / def_row_config_shift_iterate /
#             claim_row_config_shift_iterate_apply / claim_row_config_shift_period /
#             claim_shift_matrix_pow / theorem_shift_matrix_order
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で定めた
# 平行移動の反復 gamma^[k]・巡回シフトの反復 S^[k]・シフト行列の冪 U^k を、
# 小さい L で総当たりに確かめる。すべて ZZ / ZZ[x] の中の厳密計算で行い、
# 浮動小数点は使わない。
#
# 何を確かめるか:
#   1. def_column_translation_iterate と claim_column_translation_iterate_apply。
#      gamma^[k](y) = y +_{Z/LZ} pi(k)。反復は本文の定め方（gamma^[k+1] = gamma^[k] o gamma）
#      をそのまま実装し、右辺は剰余類の加法から独立に作る。
#   2. claim_column_translation_period。gamma^[L] = id。
#   3. def_row_config_shift_iterate と claim_row_config_shift_iterate_apply。
#      (S^[k](tau))(y) = tau(gamma^[k](y))。左辺は S を k 回施して作り、
#      右辺は gamma^[k] で引き戻して作る（作り方が独立）。
#   4. claim_row_config_shift_period。S^[L] = id。
#   5. claim_shift_matrix_pow。(U^k)_{tau,tau'} は tau' = S^[k](tau) なら kappa(1)、
#      そうでなければ kappa(0)。左辺は行列の積を k 回繰り返して作り、右辺は
#      行配位に S を k 回施して作る（作り方が独立）。
#   6. theorem_shift_matrix_order。U^L = I（全成分の一致）。
#
# 主張が空でないことの確認も行う（下の check_not_vacuous）。
#   - L >= 2 では L より小さい k について U^k != I である（U^L = I が
#     「どの冪でも単位行列」という自明な理由で成り立っているのではないこと）。
#   - 反復の順を取り違えた実装（gamma を先に k 回施してから y を送る向きの取り違え、
#     すなわち gamma の逆向きでの反復）では 3 が破れることを見る。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


def column_translation(L, y):
    """def_column_translation: gamma(y) = y +_{Z/LZ} 1bar。"""
    return (y + 1) % L


def column_translation_inverse(L, y):
    """claim_column_translation_bijective の gamma'（取り違えの検出に使う）。"""
    return (y - 1) % L


def column_translation_iterate(L, k, y):
    """def_column_translation_iterate: gamma^[0] = id、gamma^[k+1] = gamma^[k] o gamma。

    本文の定め方をそのまま再帰で実装する（k 回まとめて足す形にはしない）。
    """
    if k == 0:
        return y
    return column_translation_iterate(L, k - 1, column_translation(L, y))


def row_shift(L, tau):
    """def_row_config_shift: (S(tau))(y) = tau(gamma(y))。"""
    return {y: tau[column_translation(L, y)] for y in range(L)}


def row_shift_iterate(L, k, tau):
    """def_row_config_shift_iterate: S^[0] = id、S^[k+1] = S o S^[k]。"""
    if k == 0:
        return dict(tau)
    return row_shift(L, row_shift_iterate(L, k - 1, tau))


def shift_matrix(L):
    """def_shift_matrix: U_{tau,tau'} は tau' = S(tau) なら kappa(1)、そうでなければ kappa(0)。"""
    keys = row_matrix_keys(L)
    entries = {}
    for key in keys:
        shifted_key = row_config_key(L, row_shift(L, row_config_from_key(key)))
        for key_other in keys:
            entries[(key, key_other)] = (
                const_poly(1) if key_other == shifted_key else const_poly(0)
            )
    return entries


def row_matrix_pow(L, A, k):
    """def_matrix_over_row_configs の冪: A^1 = A、A^{k+1} = A^k A。"""
    assert k >= 1
    result = A
    for _ in range(k - 1):
        result = row_matrix_product(L, result, A)
    return result


def residue_add(L, y, n):
    """pi(n) を足す操作（本文の右辺を、反復とは独立に作る）。"""
    return (y + n) % L


def check_column_translation_iterate(L, k_max):
    """1: gamma^[k](y) = y +_{Z/LZ} pi(k)。"""
    for k in range(k_max + 1):
        for y in range(L):
            assert column_translation_iterate(L, k, y) == residue_add(L, y, k), (L, k, y)
    print(f'OK: L={L} で gamma^[k](y) = y + pi(k)（k=0..{k_max}、y は全 {L} 通り）')


def check_column_translation_period(L):
    """2: gamma^[L] = id。"""
    for y in range(L):
        assert column_translation_iterate(L, L, y) == y, (L, y)
    print(f'OK: L={L} で gamma^[L] = id（y は全 {L} 通り）')


def check_row_shift_iterate(L, k_max):
    """3: (S^[k](tau))(y) = tau(gamma^[k](y))。"""
    for k in range(k_max + 1):
        for key in row_matrix_keys(L):
            tau = row_config_from_key(key)
            shifted = row_shift_iterate(L, k, tau)
            for y in range(L):
                assert shifted[y] == tau[column_translation_iterate(L, k, y)], (L, k, key, y)
    print(f'OK: L={L} で (S^[k](tau))(y) = tau(gamma^[k](y))（k=0..{k_max}、行配位と y は総当たり）')


def check_row_shift_period(L):
    """4: S^[L] = id。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        assert row_shift_iterate(L, L, tau) == tau, (L, key)
    print(f'OK: L={L} で S^[L] = id（行配位は全 {2 ** L} 通り）')


def check_shift_matrix_pow(L, k_max):
    """5: (U^k)_{tau,tau'} は tau' = S^[k](tau) なら kappa(1)、そうでなければ kappa(0)。"""
    U = shift_matrix(L)
    keys = row_matrix_keys(L)
    one, zero = const_poly(1), const_poly(0)
    for k in range(1, k_max + 1):
        power = row_matrix_pow(L, U, k)
        for key in keys:
            target = row_config_key(L, row_shift_iterate(L, k, row_config_from_key(key)))
            for key_other in keys:
                expected = one if key_other == target else zero
                assert power[(key, key_other)] == expected, (L, k, key, key_other)
                assert power[(key, key_other)] in PolynomialRingZx, (L, k, key, key_other)
    print(f'OK: L={L} で (U^k) の全成分が反復シフトの行列と一致（k=1..{k_max}、全成分）')


def check_shift_matrix_order(L):
    """6: U^L = I。"""
    U = shift_matrix(L)
    I = identity_row_matrix(L)
    power = row_matrix_pow(L, U, L)
    for key in power:
        assert power[key] == I[key], (L, key, power[key], I[key])
    print(f'OK: L={L} で U^L = I（全成分が ZZ[x] の中で厳密に一致）')


def check_not_vacuous():
    """7: 主張が空でないこと。"""
    # U^L = I が「どの冪でも単位行列」という自明な理由で成り立っているのではないこと。
    for L in [2, 3, 4]:
        U = shift_matrix(L)
        I = identity_row_matrix(L)
        for k in range(1, L):
            assert row_matrix_pow(L, U, k) != I, (L, k, 'L より小さい冪で単位行列になっている')
    # 反復の向きを取り違えた実装（gamma の逆向きで引き戻す）では 3 が破れること。
    L = 3
    broken = False
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        shifted = row_shift_iterate(L, 1, tau)
        for y in range(L):
            if shifted[y] != tau[column_translation_inverse(L, y)]:
                broken = True
    assert broken, '向きを取り違えた実装でも一致してしまい、検証が向きを固定できていない'
    print('OK: L=2,3,4 で L 未満の冪は単位行列でなく、向きの取り違えは検出される（主張は空でない）')


def main():
    for L in [1, 2, 3, 4]:
        check_column_translation_iterate(L, 2 * L)
        check_column_translation_period(L)
        check_row_shift_iterate(L, 2 * L)
        check_row_shift_period(L)
        check_shift_matrix_pow(L, L + 1)
        check_shift_matrix_order(L)
    check_not_vacuous()
    print('すべての検証が通った（シフト行列の位数）')


main()
