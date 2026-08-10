# 対象ラベル: claim_orbit_shift_restriction_factor
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「軌道の元の個数が 2 以上のとき、巡回シフトの制限の因子は単位元の加法についての逆元である」
# （|O| >= 2 ならば W_O(ch(U), S↾_O) = iota(-kappa(1))）を、小さい L で総当たりに確かめる。
# 計算は ZZ / ZZ[x] / ZZ[x][t] の中の厳密計算と有限集合の数え上げだけで行い、
# 浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備の第一。S↾_O が O から O への全単射であること（S↾_O in B_O）。
#   2. 準備の第二。iota(kappa(-1)) = u であること（u := iota(-kappa(1))）。
#   3. 準備の第三。|O| >= 2 のとき、任意の tau in O について S(tau) != tau であり、
#      ch(U)_{tau,S(tau)} = u であること。
#   4. 準備の第四。u * u = iota(kappa(1)) が ZZ[x][t] の単位元であること。
#   5. 鎖の第 1・第 2 の等号。W_O(ch(U), S↾_O) が定義どおりであり、
#      sgn_O(S↾_O) = (-1)^{|O|-1} であること。
#   6. 鎖の第 4・第 5 の等号。積が u^{|O|} であること。
#   7. 鎖の第 6・第 7 の等号。iota(kappa((-1)^{|O|-1})) = u^{|O|-1} であること。
#   8. 主張そのもの。W_O(ch(U), S↾_O) = iota(-kappa(1)) であること。
#   9. 主張が空でないこと。|O| >= 2 の軌道が現れること（L >= 2 で）。
#  10. 仮定 |O| >= 2 が外せないこと。|O| = 1 の軌道では S↾_O = id_O であり、
#      因子は t + iota(-kappa(1)) であって iota(-kappa(1)) ではない。
#      **これを見ないと、仮定を落としても通ってしまうように見える。**
#
# 走らせる範囲（打ち切りを隠さない）。
#   軌道 O をすべて走らせる。L = 1,...,6 まで回す（本文の他の検証と範囲を揃えた）。

import os

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


def orbit_shift_restriction(L, o):
    """def_orbit_restriction: S↾_O をキーの辞書として返す。"""
    return {key: shift_key(L, key) for key in sorted(o)}


def orbit_identity(o):
    """O の上の恒等写像 id_O をキーの辞書として返す。"""
    return {key: key for key in sorted(o)}


def is_bijection_on(o, psi):
    """psi が O から O への全単射であること（有限集合なので像の個数で判定できる）。"""
    members = sorted(o)
    images = [psi[key] for key in members]
    return all(image in o for image in images) and len(set(images)) == len(members)


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


def orbit_factor(L, B, o, psi):
    """def_orbit_term_factor: W_O(B,psi) = iota(kappa(sgn_O(psi))) * prod_{tau in O} B_{tau,psi(tau)}。"""
    product = SecondPolynomialRing(1)
    for key in sorted(o):
        product *= B[(key, psi[key])]
    return iota_kappa(orbit_permutation_sign(L, psi, o)) * product


def check_for_L(L):
    ch_u = characteristic_matrix(L, shift_matrix(L))
    orbits = orbit_set(L)

    u = iota(-const_poly(1))
    unit = iota_kappa(1)

    # 2: 準備の第二。iota(kappa(-1)) = u。
    assert iota_kappa(-1) == u, (L, 'iota(kappa(-1)) = iota(-kappa(1)) が破れた')

    # 4: 準備の第四。u * u = iota(kappa(1)) であり、それが単位元である。
    assert u * u == unit, (L, 'u * u = iota(kappa(1)) が破れた')
    assert unit == SecondPolynomialRing(1), (L, 'iota(kappa(1)) が単位元でない')

    count_big = 0
    count_one = 0
    for o in orbits:
        restriction = orbit_shift_restriction(L, o)

        # 1: 準備の第一。S↾_O は O の上の全単射である。
        assert is_bijection_on(o, restriction), (L, 'S↾_O が O の上の全単射でない')

        factor = orbit_factor(L, ch_u, o, restriction)

        # 5: 鎖の第 1・第 2 の等号（定義そのものと、符号の値）。
        product_via_restriction = SecondPolynomialRing(1)
        for key in sorted(o):
            product_via_restriction *= ch_u[(key, restriction[key])]
        assert factor == iota_kappa(
            orbit_permutation_sign(L, restriction, o)) * product_via_restriction, (
            L, '軌道の因子の定義が破れた')
        assert orbit_permutation_sign(L, restriction, o) == (-1) ** (len(o) - 1), (
            L, 'sgn_O(S↾_O) = (-1)^{|O|-1} が破れた')

        if len(o) >= 2:
            # 3: 準備の第三。S(tau) != tau かつ ch(U)_{tau,S(tau)} = u。
            for key in sorted(o):
                assert shift_key(L, key) != key, (L, '|O| >= 2 なのに S(tau) = tau')
                assert ch_u[(key, shift_key(L, key))] == u, (
                    L, 'ch(U)_{tau,S(tau)} = u が破れた')

            # 6: 鎖の第 4・第 5 の等号。積が u^{|O|} である。
            assert product_via_restriction == u ** len(o), (
                L, '成分の積が u^{|O|} に等しくない')

            # 7: 鎖の第 6・第 7 の等号。iota(kappa((-1)^{|O|-1})) = u^{|O|-1}。
            assert iota_kappa((-1) ** (len(o) - 1)) == u ** (len(o) - 1), (
                L, 'iota(kappa((-1)^{|O|-1})) = u^{|O|-1} が破れた')

            # 8: 主張そのもの。
            assert factor == u, (L, 'W_O(ch(U), S↾_O) = iota(-kappa(1)) が破れた')
            count_big += 1
        else:
            # 10: 仮定が外せないこと。|O| = 1 では S↾_O = id_O であり、値が違う。
            assert len(o) == 1, (L, '軌道の元の個数が 0 になった')
            assert restriction == orbit_identity(o), (
                L, '|O| = 1 なのに S↾_O が id_O と一致しない')
            assert factor == t + u, (
                L, '|O| = 1 の因子が t + iota(-kappa(1)) でない')
            assert factor != u, (L, '|O| = 1 でも主張の値になってしまっている')
            count_one += 1

    # 9: 主張が空でないこと。
    assert count_one >= 1, (L, '|O| = 1 の軌道が 1 つも無い')
    if L >= 2:
        assert count_big >= 1, (L, '|O| >= 2 の軌道が 1 つも無い')

    print(f'OK: L={L}（軌道 {len(orbits)} 個。'
          f'|O| >= 2 の軌道 {count_big} 個はすべて W_O(ch(U), S↾_O) = iota(-kappa(1))、'
          f'|O| = 1 の軌道 {count_one} 個では S↾_O = id_O で値は t + iota(-kappa(1))）')
    return len(orbits), count_big, count_one


def main():
    rows = []
    for L in range(1, 7):
        rows.append((L,) + check_for_L(L))
    print()
    print('| L | 軌道の個数 | |O| >= 2 の軌道 | |O| = 1 の軌道 |')
    print('|---|---|---|---|')
    for (L, n_orbits, n_big, n_one) in rows:
        print(f'| {L} | {n_orbits} | {n_big} | {n_one} |')


main()
