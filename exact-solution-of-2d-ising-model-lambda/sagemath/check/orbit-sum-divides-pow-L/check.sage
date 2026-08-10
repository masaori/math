# 対象ラベル: claim_orbit_sum_divides_pow_L
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「軌道ごとの和は、格子の一辺を指数とする冪と単位元の逆元との和の因子である」
# （L = |O| k を満たす k が存在し、
#   t^L + iota(-kappa(1)) = (sum_{psi in B_O} W_O(ch(U), psi)) * sum_{j<k} t^{|O| j}）を、
# 小さい L で総当たりに確かめる。
# 計算は ZZ / ZZ[x] / ZZ[x][t] の中の厳密計算と有限集合の数え上げだけで行い、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備。各軌道 O について O = O(tau_0) を満たす tau_0 が存在し、|O| = |O(tau_0)| であること。
#   2. |O| = e(tau_0) であること（claim_row_config_orbit_card）。
#   3. e(tau_0) が L を割り切り、L = |O| k を満たす k in N がただ 1 つ存在すること
#      （claim_row_config_minimal_period_divides_L と自然数の整除の定義）。
#   4. 鎖の第 1 段。t^L + u = t^{|O| k} + u（L = |O| k の代入）。
#   5. 鎖の第 2 段。t^{|O| k} + u = (t^{|O|} + u) * sum_{j<k} t^{|O| j}
#      （claim_power_sum_telescope の d = |O| の場合）。
#   6. 鎖の第 3 段。t^{|O|} + u = sum_{psi in B_O} W_O(ch(U), psi)（claim_orbit_sum_two_terms）。
#      ここだけ B_O の全列挙（|O|! 通り）を要するので、走らせる範囲を下に分けて書く。
#   7. 主張そのもの。t^L + u = (sum_{psi in B_O} W_O(ch(U), psi)) * sum_{j<k} t^{|O| j}。
#   8. 主張が空虚でないこと。商が単位元でない（k >= 2 の）軌道が実際にあること。
#      k = 1 すなわち |O| = L のときは商が単位元なので、それだけでは何も確かめたことにならない。
#   9. 整除関係そのもの。ZZ[x][t] の中で (t^{|O|} + u) が t^L + u を割り、剰余が零元であること。
#
# 走らせる範囲（打ち切りを隠さない）。
#   L = 1,...,6 のすべての軌道。6（B_O の全列挙を要する段）も含めて全部走らせる
#   （|O| <= 6 なので |B_O| <= 720）。
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



def minimal_period(L, key):
    """def_row_config_shift_minimal_period: e(tau) = min { k >= 1 | S^[k](tau) = tau }。"""
    tau = row_config_from_key(key)
    for k in range(1, L + 1):
        if row_config_key(L, row_shift_iterate(L, k, tau)) == key:
            return k
    raise AssertionError('最小周期が L 以下に見つからない')


def power_sum(d, k):
    """sum_{j in {j' in N | j' < k}} t^{d j}。有限和を定義どおり足し上げる。"""
    s = SecondPolynomialRing(0)
    for j in range(k):
        s = s + t**(d * j)
    return s


def check_for_L(L, enumerate_bijections):
    ch_u = characteristic_matrix(L, shift_matrix(L))
    orbits = orbit_set(L)
    u = iota(-const_poly(1))
    zero = iota_kappa(0)

    count_nontrivial = 0
    for o in orbits:
        # 1: 準備。O = O(tau_0) を満たす tau_0 が存在する。
        bases = [key for key in row_matrix_keys(L) if orbit_of_key(L, key) == o]
        assert len(bases) >= 1, (L, 'O = O(tau_0) を満たす tau_0 が無い')
        tau_0 = bases[0]
        assert len(o) == len(orbit_of_key(L, tau_0)), (L, '|O| と |O(tau_0)| が違う')

        # 2: |O| = e(tau_0)。
        period = minimal_period(L, tau_0)
        assert len(o) == period, (L, '|O| = e(tau_0) が破れた')

        # 3: e(tau_0) | L であり、L = |O| k を満たす k がただ 1 つある。
        assert L % period == 0, (L, 'e(tau_0) が L を割り切らない')
        ks = [k for k in range(0, L + 1) if len(o) * k == L]
        assert len(ks) == 1, (L, 'L = |O| k を満たす k がただ 1 つでない')
        k = ks[0]

        # 4: 鎖の第 1 段。
        assert t**L + u == t**(len(o) * k) + u, (L, '第 1 段（L = |O| k の代入）が破れた')

        # 5: 鎖の第 2 段（claim_power_sum_telescope の d = |O|）。
        assert t**(len(o) * k) + u == (t**len(o) + u) * power_sum(len(o), k), (
            L, '第 2 段（冪の有限和との積）が破れた')

        # 6: 鎖の第 3 段（claim_orbit_sum_two_terms）。B_O の全列挙を要する。
        if enumerate_bijections:
            total = SecondPolynomialRing(0)
            for psi in orbit_bijections(o):
                total += orbit_factor(L, ch_u, o, psi)
            assert t**len(o) + u == total, (L, '第 3 段（軌道ごとの和の値）が破れた')

            # 7: 主張そのもの。
            assert t**L + u == total * power_sum(len(o), k), (L, '主張が破れた')

        # 9: 整除関係そのもの。
        assert (t**L + u) % (t**len(o) + u) == zero, (L, '剰余が零元でない')

        if k >= 2:
            # 8: 商が単位元でない軌道（k = 1 では商が単位元で、何も確かめたことにならない）。
            assert power_sum(len(o), k) != SecondPolynomialRing(1), (L, 'k >= 2 なのに商が単位元')
            count_nontrivial += 1

    print(f'OK: L={L}（軌道 {len(orbits)} 個。うち k >= 2（|O| < L）の軌道 {count_nontrivial} 個。'
          f'B_O の全列挙: {"した" if enumerate_bijections else "していない（範囲の説明を参照）"}）')
    return len(orbits), count_nontrivial


def main():
    rows = []
    for L in range(1, 7):
        rows.append((L,) + check_for_L(L, enumerate_bijections=True))
    total_nontrivial = sum(row[2] for row in rows)
    assert total_nontrivial >= 1, '商が単位元でない軌道が 1 つも無い（主張が空虚）'
    print()
    print('| L | 軌道の個数 | k >= 2 の軌道の個数 |')
    print('|---|---|---|')
    for (L, n_orbits, n_nontrivial) in rows:
        print(f'| {L} | {n_orbits} | {n_nontrivial} |')


main()
