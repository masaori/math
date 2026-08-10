# 対象ラベル: claim_orbit_sum_two_terms
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「軌道ごとの和は、軌道の元の個数を指数とする冪と、単位元の加法についての逆元との和である」
# （sum_{psi in B_O} W_O(ch(U), psi) = t^{|O|} + iota(-kappa(1))）を、小さい L で総当たりに確かめる。
# 計算は ZZ / ZZ[x] / ZZ[x][t] の中の厳密計算と有限集合の数え上げだけで行い、
# 浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備の第一。id_O と S↾_O がどちらも O の上の全単射であること（G ⊂ B_O）。
#   2. 準備の第二。psi in B_O が psi ∉ G を満たすなら W_O(ch(U), psi) = iota(kappa(0)) であり、
#      それが ZZ[x][t] の零元であること。
#   3. 準備の第三。|O| >= 1 であり、|O| >= 2 と |O| = 1 が場合を尽くして重ならないこと。
#   4. 共通の段。B_O にわたる和が G にわたる和に等しいこと（和の添字を狭めてよいこと）。
#   5. 第一の場合（|O| >= 2）。S↾_O != id_O なので G はちょうど 2 元であり、
#      和が W_O(ch(U), id_O) + W_O(ch(U), S↾_O) = t^{|O|} + u であること。
#   6. 第二の場合（|O| = 1）。S↾_O = id_O なので G はちょうど 1 元であり、
#      和が W_O(ch(U), id_O) = t + u = t^{|O|} + u であること。
#   7. 主張そのもの。sum_{psi in B_O} W_O(ch(U), psi) = t^{|O|} + iota(-kappa(1))。
#   8. 和を狭める段が空虚でないこと。G の外に B_O の元が実際に存在する軌道があること
#      （そうでなければ「狭める」段を確かめたことにならない）。
#   9. 2 項が実際に相異なる値を与えること（|O| >= 2 の軌道で t^{|O|} != u）。
#      **これを見ないと、2 項のどちらか一方を落としても通るように見える。**
#
# 走らせる範囲（打ち切りを隠さない）。
#   軌道 O をすべて走らせ、各 O について B_O（|O|! 個）を全列挙する。
#   L = 1,...,6 まで回す（本文の他の検証と範囲を揃えた。|O| <= 6 なので |B_O| <= 720）。

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


def orbit_shift_restriction(L, o):
    """def_orbit_restriction: S↾_O をキーの辞書として返す。"""
    return {key: shift_key(L, key) for key in sorted(o)}


def orbit_identity(o):
    """O の上の恒等写像 id_O をキーの辞書として返す。"""
    return {key: key for key in sorted(o)}


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
    zero = iota_kappa(0)
    assert zero == SecondPolynomialRing(0), (L, 'iota(kappa(0)) が零元でない')

    count_big = 0
    count_one = 0
    count_outside = 0
    for o in orbits:
        members = sorted(o)
        identity = orbit_identity(o)
        restriction = orbit_shift_restriction(L, o)
        bijections = orbit_bijections(o)

        # 1: 準備の第一。id_O と S↾_O はどちらも B_O の元である。
        assert any(psi == identity for psi in bijections), (L, 'id_O が B_O に無い')
        assert any(psi == restriction for psi in bijections), (L, 'S↾_O が B_O に無い')

        # 3: 準備の第三。|O| >= 1 であり、2 つの場合が尽くしていて重ならない。
        assert len(o) >= 1, (L, '軌道が空である')
        assert (len(o) >= 2) != (len(o) == 1), (L, '2 つの場合が尽くしていないか重なっている')

        # 2: 準備の第二。G の外の因子は零元である。
        total = SecondPolynomialRing(0)
        for psi in bijections:
            factor = orbit_factor(L, ch_u, o, psi)
            total += factor
            if psi != identity and psi != restriction:
                assert factor == zero, (L, 'G の外の因子が零元でない')
                count_outside += 1

        # 4: 共通の段。B_O にわたる和は G にわたる和に等しい。
        restricted_members = [identity] if restriction == identity else [identity, restriction]
        total_restricted = SecondPolynomialRing(0)
        for psi in restricted_members:
            total_restricted += orbit_factor(L, ch_u, o, psi)
        assert total == total_restricted, (L, '和を G へ狭めた値がもとの和と違う')

        if len(o) >= 2:
            # 5: 第一の場合。G はちょうど 2 元であり、和は t^{|O|} + u である。
            assert restriction != identity, (L, '|O| >= 2 なのに S↾_O = id_O')
            assert len(restricted_members) == 2, (L, 'G が 2 元でない')
            assert orbit_factor(L, ch_u, o, identity) == t ** len(o), (
                L, '恒等写像の因子が t^{|O|} でない')
            assert orbit_factor(L, ch_u, o, restriction) == u, (
                L, '巡回シフトの制限の因子が u でない')

            # 9: 2 項が相異なる値を与えること（片方を落とすと通らないこと）。
            assert t ** len(o) != u, (L, '2 項の値が一致してしまっている')
            assert total != t ** len(o), (L, '巡回シフトの制限の項を落としても通ってしまう')
            assert total != u, (L, '恒等写像の項を落としても通ってしまう')
            count_big += 1
        else:
            # 6: 第二の場合。G はちょうど 1 元であり、和は t + u である。
            assert restriction == identity, (L, '|O| = 1 なのに S↾_O != id_O')
            assert len(restricted_members) == 1, (L, 'G が 1 元でない')
            assert total == t + u, (L, '|O| = 1 の和が t + iota(-kappa(1)) でない')
            count_one += 1

        # 7: 主張そのもの。
        assert total == t ** len(o) + u, (
            L, 'sum_{psi in B_O} W_O(ch(U), psi) = t^{|O|} + iota(-kappa(1)) が破れた')

    # 8: 和を狭める段が空虚でないこと。
    if L >= 3:
        assert count_outside >= 1, (L, 'G の外の元が 1 つも無く、狭める段を確かめられていない')

    print(f'OK: L={L}（軌道 {len(orbits)} 個。'
          f'|O| >= 2 の軌道 {count_big} 個、|O| = 1 の軌道 {count_one} 個。'
          f'G の外の全単射 {count_outside} 個はすべて因子が零元）')
    return len(orbits), count_big, count_one, count_outside


def main():
    rows = []
    for L in range(1, 7):
        rows.append((L,) + check_for_L(L))
    print()
    print('| L | 軌道の個数 | |O| >= 2 の軌道 | |O| = 1 の軌道 | G の外の全単射の個数 |')
    print('|---|---|---|---|---|')
    for (L, n_orbits, n_big, n_one, n_outside) in rows:
        print(f'| {L} | {n_orbits} | {n_big} | {n_one} | {n_outside} |')


main()
