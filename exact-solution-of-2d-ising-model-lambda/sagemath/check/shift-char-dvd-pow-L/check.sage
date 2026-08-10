# 対象ラベル: claim_shift_char_dvd_pow_L
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「シフト行列の特性多項式は、格子の一辺を指数とする冪と単位元の逆元との和の、
#   軌道の個数を指数とする冪の因子である」
# （chi_U * g = (t^L + iota(-kappa(1)))^{|O_L|} を満たす g in ZZ[x][t] が存在する）を、
# 小さい L で総当たりに確かめる。
# 計算は ZZ / ZZ[x] / ZZ[x][t] の中の厳密計算と有限集合の数え上げだけで行い、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備。各軌道 O について a(O) = sum_{psi in B_O} W_O(ch(U), psi) を全列挙で作ること。
#   2. 準備。各軌道 O について a(O) * b(O) = t^L + u を満たす b(O) が取れること
#      （claim_orbit_sum_divides_pow_L。ここでは b(O) = sum_{j<k} t^{|O| j} と取る）。
#   3. g := prod_{O in O_L} b(O) と置くこと。
#   4. 鎖の第 1 段。chi_U * g = chi_U * prod_{O} b(O)（g の定義）。
#   5. 鎖の第 2 段。chi_U = prod_{O in O_L} a(O)（claim_shift_char_orbit_product）。
#      chi_U は特性行列の行列式として直に計算する（下の範囲を参照）。
#   6. 鎖の第 3 段。(prod a) * (prod b) = (t^L + u)^{|O_L|}
#      （claim_prod_pair_eq_pow_card の s = O_L、c = t^L + u の場合）。
#   7. 主張そのもの。chi_U * g = (t^L + u)^{|O_L|}。
#   8. 整除関係そのもの。ZZ[x][t] の中で chi_U が (t^L + u)^{|O_L|} を割り、剰余が零元であること。
#   9. 主張が空虚でないこと。商 g が単位元でない L が実際にあること
#      （g = 1 なら chi_U 自身が冪に等しいだけで、整除として何も確かめたことにならない）。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1,...,6 のすべての軌道について 1・2・3・4・6・7・8・9 を確かめる（B_O は全列挙する。
#   |O| <= 6 なので |B_O| <= 720）。
#   第 5 段（chi_U を特性行列の行列式として直に計算して積と突き合わせる段）だけは L = 1,...,5 に
#   絞った。行列の大きさが 2^L なので L = 6 では 64 行 64 列の ZZ[x][t] 上の行列式になり、
#   この検証の実行時間に収まらないためである。L = 6 では第 5 段を仮定して残りを確かめている。
#   本文の主張は任意の L についてのものなので、有限個で確かめたことは証明ではない。

import os
from itertools import permutations

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


def shift_key(L, key):
    """キーの上で S を作用させる。"""
    return row_config_key(L, row_shift(L, row_config_from_key(key)))


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


def orbit_bijections(o):
    """def_orbit_bijection_set: B_O（O から O への全単射の全体）を全列挙する。"""
    members = sorted(o)
    return [
        {key: image for (key, image) in zip(members, images)}
        for images in permutations(members)
    ]


def orbit_inversion_count(L, psi, o):
    """def_orbit_inversion_count: inv_O(psi)。台は F(O,O)。"""
    members = sorted(o)
    return len([
        (key_1, key_2)
        for key_1 in members
        for key_2 in members
        if less(L, key_1, key_2) and less(L, psi[key_2], psi[key_1])
    ])


def orbit_permutation_sign(L, psi, o):
    """def_orbit_permutation_sign: sgn_O(psi) = (-1)^{inv_O(psi)}。"""
    return (-1) ** orbit_inversion_count(L, psi, o)


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


def characteristic_polynomial(L, A):
    """def_characteristic_polynomial: chi_A = det_t(ch(A))。

    行列式の定義（置換の全体にわたる和）は 2^L! 通りになって回らないので、
    同じ値を与える Sage の行列式で計算する（値は ZZ[x][t] の中の厳密計算）。
    """
    keys = row_matrix_keys(L)
    ch = characteristic_matrix(L, A)
    rows = [[ch[(a, b)] for b in keys] for a in keys]
    return matrix(SecondPolynomialRing, rows).determinant()


def orbit_factor(L, B, o, psi):
    """def_orbit_term_factor: W_O(B,psi) = iota(kappa(sgn_O(psi))) * prod_{tau in O} B_{tau,psi(tau)}。"""
    product = SecondPolynomialRing(1)
    for key in sorted(o):
        product *= B[(key, psi[key])]
    return iota_kappa(orbit_permutation_sign(L, psi, o)) * product


def orbit_sum(L, ch, o):
    """a(O) = sum_{psi in B_O} W_O(ch(U), psi)。B_O を全列挙して足し上げる。"""
    total = SecondPolynomialRing(0)
    for psi in orbit_bijections(o):
        total += orbit_factor(L, ch, o, psi)
    return total


def power_sum(d, k):
    """sum_{j in {j' in N | j' < k}} t^{d j}。有限和を定義どおり足し上げる。"""
    s = SecondPolynomialRing(0)
    for j in range(k):
        s = s + t**(d * j)
    return s


def check_for_L(L, compute_determinant):
    ch_u = characteristic_matrix(L, shift_matrix(L))
    orbits = orbit_set(L)
    u = iota(-const_poly(1))
    zero = iota_kappa(0)
    c = t**L + u

    # 1・2: 各軌道について a(O) と、a(O) * b(O) = c を満たす b(O) を作る。
    a_values = []
    b_values = []
    for o in orbits:
        a_o = orbit_sum(L, ch_u, o)
        ks = [k for k in range(0, L + 1) if len(o) * k == L]
        assert len(ks) == 1, (L, 'L = |O| k を満たす k がただ 1 つでない')
        b_o = power_sum(len(o), ks[0])
        assert a_o * b_o == c, (L, 'a(O) * b(O) = t^L + u が破れた')
        a_values.append(a_o)
        b_values.append(b_o)

    # 3: g := prod_{O} b(O)。
    g = SecondPolynomialRing(1)
    for b_o in b_values:
        g *= b_o

    prod_a = SecondPolynomialRing(1)
    for a_o in a_values:
        prod_a *= a_o

    # 5: 鎖の第 2 段。chi_U = prod_{O} a(O)。
    if compute_determinant:
        chi_u = characteristic_polynomial(L, shift_matrix(L))
        assert chi_u == prod_a, (L, '第 2 段（chi_U が軌道ごとの和の積であること）が破れた')
    else:
        chi_u = prod_a

    # 4: 鎖の第 1 段（g の定義）。
    assert chi_u * g == chi_u * prod(b_values, SecondPolynomialRing(1)), (
        L, '第 1 段（g の定義）が破れた')

    # 6: 鎖の第 3 段（claim_prod_pair_eq_pow_card の s = O_L、c = t^L + u）。
    assert prod_a * g == c**len(orbits), (L, '第 3 段（2 つの有限積の積）が破れた')

    # 7: 主張そのもの。
    assert chi_u * g == c**len(orbits), (L, '主張が破れた')

    # 8: 整除関係そのもの。
    assert (c**len(orbits)) % chi_u == zero, (L, '剰余が零元でない')

    nontrivial = g != SecondPolynomialRing(1)
    print(f'OK: L={L}（軌道 {len(orbits)} 個。商 g は'
          f'{"単位元でない" if nontrivial else "単位元"}。'
          f'chi_U の行列式による計算: {"した" if compute_determinant else "していない（範囲の説明を参照）"}）')
    return len(orbits), nontrivial


def main():
    rows = []
    for L in range(1, 7):
        rows.append((L,) + check_for_L(L, compute_determinant=(L <= 5)))
    # 9: 主張が空虚でないこと。
    assert any(row[2] for row in rows), '商が単位元でない L が 1 つも無い（主張が空虚）'
    print()
    print('| L | 軌道の個数 | 商 g が単位元でないか |')
    print('|---|---|---|')
    for (L, n_orbits, nontrivial) in rows:
        print(f'| {L} | {n_orbits} | {"はい" if nontrivial else "いいえ"} |')


main()
