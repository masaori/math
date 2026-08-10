# 対象ラベル: claim_shift_char_root_of_unity
#   併せて引く定義: def_algebraic_numbers, def_root_of_unity_set, def_second_evaluation
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「シフト行列の特性多項式の値を 0 にする代数的数は 1 の L 乗根である」
# （ev_{xi,z}(chi_U) = 0 ならば z in mu_L）を、小さい L で総当たりに確かめる。
#
# 計算はすべて厳密に行う（浮動小数点は使わない）。ZZ[x][t] の中の計算と、
# 代数的数の全体 Qbar を表す SageMath の QQbar の中の計算だけである。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 鎖の第 2 段。chi_U = prod_{O in O_L} (t^{|O|} + u)（claim_shift_char_orbit_factorization）。
#      chi_U は特性行列の行列式として直に計算して突き合わせる（下の範囲を参照）。
#   2. 鎖の第 3 段。ev_{xi,z}(prod_O f_O) = prod_O ev_{xi,z}(f_O)（claim_second_evaluation_prod）。
#   3. 0 である因子が取れること（claim_qbar_prod_eq_zero）。ev_{xi,z}(chi_U) = 0 を満たす
#      (xi, z) について、ev_{xi,z}(t^{|O_0|} + u) = 0 を満たす軌道 O_0 が実際に取れること。
#   4. その因子から z^{|O_0|} = 1 が出ること（claim_orbit_factor_root）。
#   5. |O_0| が L を割り切ること（claim_row_config_orbit_card と
#      claim_row_config_minimal_period_divides_L。ここでは全軌道について確かめる）。
#   6. 主張そのもの。ev_{xi,z}(chi_U) = 0 ならば z^L = 1、すなわち z in mu_L。
#   7. 主張が空虚でないこと。ev_{xi,z}(chi_U) = 0 になる z と、ならない z の両方が実際にあること。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1,...,6。z は L 乗根の全体（QQbar の中で t^L - 1 の根として取る。L 個）と、
#   1 の冪根でない代数的数 4 個（2, -3/4, sqrt2, 1 の 7 乗根の 1 つ）である。
#   xi は 3 個（0, 1, sqrt2）を走らせる（chi_U の係数は x を含まないので値は xi によらないが、
#   ev_{xi,z} の定義どおり xi を動かして確かめる）。
#   1（chi_U を特性行列の行列式として直に計算して積と突き合わせる段）だけは L = 1,...,4 に
#   絞った。行列の大きさが 2^L なので L >= 5 では ZZ[x][t] 上の 32 行 32 列以上の行列式になり、
#   この検証の実行時間に収まらないためである（同じ段は
#   sagemath/check/shift-char-orbit-factorization が L = 1,...,5 で確かめている）。
#   L >= 5 では 1 を仮定して 2 以降を確かめている。
#   本文の主張は任意の L と任意の (xi, z) についてのものなので、有限個で確かめたことは証明ではない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


# def_second_polynomial_ring: ZZ[x] を係数環とする、もう 1 つの不定元 t の多項式環。
SecondPolynomialRing = PolynomialRing(PolynomialRingZx, 't')
t = SecondPolynomialRing.gen()


def iota(a):
    """def_second_constant_embedding: ZZ[x] の元を t について定数な元へ送る。"""
    return SecondPolynomialRing(PolynomialRingZx(a))


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


def characteristic_polynomial_by_determinant(L, A):
    """def_characteristic_polynomial: chi_A = det_t(ch(A))。Sage の行列式で計算する。"""
    keys = row_matrix_keys(L)
    rows = [
        [(t if a == b else SecondPolynomialRing(0)) + iota(-A[(a, b)]) for b in keys]
        for a in keys
    ]
    return matrix(SecondPolynomialRing, rows).determinant()


def eval_second(f, xi, z):
    """def_second_evaluation: ev_{xi,z}(f) = sum_k (cf_k(f))(xi) * z^k in Qbar。"""
    value = QQbar(0)
    for k, coefficient in enumerate(f.list()):
        if coefficient == PolynomialRingZx(0):
            continue
        value += QQbar(coefficient(QQbar(xi))) * z**k
    return value


# ---- 走らせる代数的数 ---------------------------------------------------------

xi_values = [QQbar(0), QQbar(1), QQbar(2).sqrt()]

QbarPoly = PolynomialRing(QQbar, 'w')
w = QbarPoly.gen()


def roots_of_unity(n):
    """mu_n = { z in Qbar | z^n = 1 } を QQbar の中で厳密に取る。"""
    return [root for (root, _) in (w**n - 1).roots()]


not_roots_of_unity = [
    QQbar(2),
    QQbar(-3) / QQbar(4),
    QQbar(2).sqrt(),
    roots_of_unity(7)[1],  # 1 の 7 乗根（1 でないもの）。L = 1,...,6 では mu_L に属さない
]


def check_for_L(L, compute_determinant):
    orbits = orbit_set(L)
    u = iota(-const_poly(1))
    factors = [t**len(o) + u for o in orbits]

    chi_by_product = SecondPolynomialRing(1)
    for factor in factors:
        chi_by_product *= factor

    # 1: 鎖の第 2 段。chi_U = prod_{O} (t^{|O|} + u)。
    if compute_determinant:
        chi_by_determinant = characteristic_polynomial_by_determinant(L, shift_matrix(L))
        assert chi_by_determinant == chi_by_product, (L, '第 2 段（軌道ごとの因子の積）が破れた')

    # 5: |O| が L を割り切ること（軌道の元の個数は最小周期に等しく、最小周期は L を割る）。
    for o in orbits:
        assert L % len(o) == 0, (L, len(o), '軌道の元の個数が L を割り切らない')

    zeros = 0
    nonzeros = 0
    for xi in xi_values:
        for z in roots_of_unity(L) + not_roots_of_unity:
            value_of_chi = eval_second(chi_by_product, xi, z)
            factor_values = [eval_second(factor, xi, z) for factor in factors]

            # 2: 鎖の第 3 段。積の値は値の積である。
            product_of_values = QQbar(1)
            for factor_value in factor_values:
                product_of_values *= factor_value
            assert value_of_chi == product_of_values, (L, '第 3 段（積の値が値の積）が破れた')

            if value_of_chi != QQbar(0):
                nonzeros += 1
                continue
            zeros += 1

            # 3: 0 である因子が取れること。
            indices = [i for i, v in enumerate(factor_values) if v == QQbar(0)]
            assert indices, (L, '積が 0 なのに 0 である因子が無い')
            i0 = indices[0]
            m = len(orbits[i0])

            # 4: その因子から z^{|O_0|} = 1 が出ること。
            assert z**m == QQbar(1), (L, m, '軌道ごとの因子の根が 1 の |O_0| 乗根でない')

            # 6: 主張そのもの。|O_0| が L を割るので z^L = 1。
            assert L % m == 0, (L, m, '|O_0| が L を割り切らない')
            assert z**L == QQbar(1), (L, '主張が破れた: z^L != 1')

    # 7: 主張が空虚でないこと。
    assert zeros > 0, (L, '値が 0 になる z が 1 つも無い')
    assert nonzeros > 0, (L, '値が 0 にならない z が 1 つも無い')
    return zeros, nonzeros, len(orbits)


print('対象ラベル: claim_shift_char_root_of_unity')
for L in range(1, 7):
    compute_determinant = L <= 4
    zeros, nonzeros, orbit_count = check_for_L(L, compute_determinant)
    print(
        'L = %d: 軌道 %d 個、値が 0 になる (xi,z) が %d 組、ならない組が %d 組。'
        '行列式との突き合わせ: %s'
        % (L, orbit_count, zeros, nonzeros, '実施' if compute_determinant else '省略（範囲の注記を参照）')
    )

print('すべて通過: ev_{xi,z}(chi_U) = 0 ならば z^L = 1（L = 1,...,6）')
