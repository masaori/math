# 対象ラベル: claim_orbit_identity_factor
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「恒等写像の因子は、その軌道の元の個数で決まる」
# （O in O_L について、|O| >= 2 なら W_O(ch(U), id_O) = t^{|O|}、
#   |O| = 1 なら W_O(ch(U), id_O) = t + iota(-kappa(1))）を、小さい L で総当たりに確かめる。
# 計算は ZZ / ZZ[x] / ZZ[x][t] の中の厳密計算と有限集合の数え上げだけで行い、
# 浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備。O は空でない（|O| >= 1）ので、|O| >= 2 と |O| = 1 が場合を尽くすこと。
#      および id_O が O から O への全単射であること（id_O in B_O）。
#   2. 共通の段の第 1 の等号。W_O(ch(U), id_O) が定義どおり
#      iota(kappa(sgn_O(id_O))) * prod_{tau in O} ch(U)_{tau,id_O(tau)} であること。
#   3. 共通の段の第 2 の等号。sgn_O(id_O) = +1 であること。
#   4. 共通の段の第 3・第 4 の等号。iota(kappa(1)) が ZZ[x][t] の単位元であり、
#      W_O(ch(U), id_O) = prod_{tau in O} ch(U)_{tau,tau} であること。
#   5. 第一の場合。|O| >= 2 のとき prod_{tau in O} ch(U)_{tau,tau} = prod_{tau in O} t
#      であり、それが t^{|O|} に等しいこと。
#   6. 第二の場合。|O| = 1 のとき O = {tau_1} と書けて、
#      prod_{tau in O} ch(U)_{tau,tau} = ch(U)_{tau_1,tau_1} = t + iota(-kappa(1)) であること。
#   7. 主張が空でないこと。|O| >= 2 の軌道と |O| = 1 の軌道が両方現れること。
#      **これを見ないと、どちらか一方の場合しか無くても 5・6 が通ってしまう。**
#   8. 2 つの場合の値が相異なること（場合分けが値を実際に分けていること）。
#      |O| = 1 では t^{|O|} = t であり、t + iota(-kappa(1)) とは異なる。
#      すなわち第二の場合を第一の場合の式で書くことはできない。
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

    value_one_case = t + iota(-const_poly(1))

    # 8: 2 つの場合の値が相異なること（|O| = 1 のとき t^1 = t と比べる）。
    assert t ** 1 != value_one_case, (L, '2 つの場合の値が一致してしまっている')

    count_big = 0
    count_one = 0
    for o in orbits:
        identity = orbit_identity(o)

        # 1: 準備。O は空でなく、id_O は O の上の全単射である。
        assert len(o) >= 1, (L, '軌道が空になった')
        assert is_bijection_on(o, identity), (L, 'id_O が O の上の全単射でない')

        # 2: 共通の段の第 1 の等号（定義そのもの）。
        product_via_identity = SecondPolynomialRing(1)
        for key in sorted(o):
            product_via_identity *= ch_u[(key, identity[key])]
        factor = orbit_factor(L, ch_u, o, identity)
        assert factor == iota_kappa(
            orbit_permutation_sign(L, identity, o)) * product_via_identity, (
            L, '軌道の因子の定義が破れた')

        # 3: 共通の段の第 2 の等号。sgn_O(id_O) = +1。
        assert orbit_permutation_sign(L, identity, o) == 1, (
            L, 'sgn_O(id_O) = +1 が破れた')

        # 4: 共通の段の第 3・第 4 の等号。
        assert iota_kappa(1) * factor == factor, (
            L, 'iota(kappa(1)) が ZZ[x][t] の単位元でない')
        product_diagonal = SecondPolynomialRing(1)
        for key in sorted(o):
            product_diagonal *= ch_u[(key, key)]
        assert factor == product_diagonal, (
            L, 'W_O(ch(U), id_O) が対角成分の積に等しくない')

        if len(o) >= 2:
            # 5: 第一の場合。対角成分がすべて t であり、その積が t^{|O|} であること。
            product_t = SecondPolynomialRing(1)
            for key in sorted(o):
                assert ch_u[(key, key)] == t, (L, '|O| >= 2 なのに対角成分が t でない')
                product_t *= t
            assert product_diagonal == product_t, (L, '対角成分の積が t の積に等しくない')
            assert product_t == t ** len(o), (L, 't の有限積が t^{|O|} に等しくない')
            assert factor == t ** len(o), (L, 'W_O(ch(U), id_O) = t^{|O|} が破れた')
            count_big += 1
        else:
            # 6: 第二の場合。O = {tau_1} であり、積が 1 つの因子であること。
            assert len(o) == 1, (L, '軌道の元の個数が 0 になった')
            tau_1 = sorted(o)[0]
            assert product_diagonal == ch_u[(tau_1, tau_1)], (
                L, '1 元集合にわたる積が 1 つの因子に等しくない')
            assert factor == value_one_case, (
                L, 'W_O(ch(U), id_O) = t + iota(-kappa(1)) が破れた')
            count_one += 1

    # 7: 主張が空でないこと。
    assert count_one >= 1, (L, '|O| = 1 の軌道が 1 つも無い')
    if L >= 2:
        assert count_big >= 1, (L, '|O| >= 2 の軌道が 1 つも無い')

    print(f'OK: L={L}（軌道 {len(orbits)} 個。'
          f'|O| >= 2 の軌道 {count_big} 個はすべて W_O(ch(U), id_O) = t^|O|、'
          f'|O| = 1 の軌道 {count_one} 個はすべて W_O(ch(U), id_O) = t + iota(-kappa(1))）')
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
