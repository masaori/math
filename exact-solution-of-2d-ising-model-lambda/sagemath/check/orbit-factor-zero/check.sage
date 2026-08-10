# 対象ラベル: claim_orbit_factor_zero
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「行の添字にもその像にも当たらない値を取る軌道の上の全単射の因子は零元である」
# （ある tau_1 in O で psi(tau_1) != tau_1 かつ psi(tau_1) != S(tau_1) ならば
#  W_O(ch(U), psi) = iota(kappa(0))）を、小さい L で総当たりに確かめる。
# すべて ZZ / ZZ[x] / ZZ[x][t] の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の式変形の段に 1 対 1 で対応させる）:
#   1. 第 1 の等号。W_O(ch(U), psi) が定義どおり
#      iota(kappa(sgn_O(psi))) * prod_{tau in O} ch(U)_{tau,psi(tau)} であること。
#   2. 第 2 の等号。有限積から tau_1 の因子を括り出せること。
#   3. 第 3 の等号。ch(U)_{tau_1,psi(tau_1)} が零元であること
#      （claim_shift_char_matrix_entry_zero を、この場面の 2 元について確かめ直す）。
#   4. 第 4 の等号（主張そのもの）。W_O(ch(U), psi) = iota(kappa(0)) であること。
#   5. 主張が空でないこと、および対偶の側。仮定を満たす psi が実際にあること、
#      そして仮定を満たさない psi（＝任意の tau で psi(tau) が tau か S(tau)）の因子は
#      零元でないこと。**これを見ないと、すべての因子が零元でも 4 が通ってしまう。**
#
# 走らせる範囲（打ち切りを隠さない）。
#   軌道 O をすべて、O の上の全単射 psi をすべて（|O|! 通り）走らせる。
#   L = 1,...,6 まで回す（本文の他の検証と範囲を揃えた）。L <= 6 では軌道の元の個数が
#   高々 6 なので、psi の全列挙は高々 720 通りである。

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


def orbit_bijections(L, o):
    """def_orbit_bijection_set: B_O（O から O への全単射の全体）をキーの辞書で返す。"""
    members = sorted(o)
    return [
        {key: image for key, image in zip(members, perm)}
        for perm in itertools.permutations(members)
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
        shifted = shift_key(L, key)
        for key_other in keys:
            entries[(key, key_other)] = (
                const_poly(1) if key_other == shifted else const_poly(0)
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


def witnesses(L, o, psi):
    """仮定を満たす tau_1（psi(tau_1) != tau_1 かつ psi(tau_1) != S(tau_1)）の全体。"""
    return [
        key for key in sorted(o)
        if psi[key] != key and psi[key] != shift_key(L, key)
    ]


def check_for_L(L):
    zero = iota_kappa(0)
    ch_u = characteristic_matrix(L, shift_matrix(L))
    orbits = orbit_set(L)

    count_hypothesis = 0
    count_complement = 0
    for o in orbits:
        for psi in orbit_bijections(L, o):
            found = witnesses(L, o, psi)
            factor = orbit_factor(L, ch_u, o, psi)
            if not found:
                # 5 の後半（対偶の側）。仮定を満たさない psi の因子は零元ではない。
                assert factor != zero, (L, sorted(o), '仮定を満たさない psi の因子が零元になった')
                count_complement += 1
                continue
            tau_1 = found[0]

            # 1: 定義そのもの。
            product_all = SecondPolynomialRing(1)
            for key in sorted(o):
                product_all *= ch_u[(key, psi[key])]
            defined = iota_kappa(orbit_permutation_sign(L, psi, o)) * product_all
            assert factor == defined, (L, sorted(o), 'W_O が定義と合わない')

            # 2: 有限積から tau_1 の因子を括り出す。
            product_rest = SecondPolynomialRing(1)
            for key in sorted(o):
                if key != tau_1:
                    product_rest *= ch_u[(key, psi[key])]
            split = (iota_kappa(orbit_permutation_sign(L, psi, o))
                     * ch_u[(tau_1, psi[tau_1])] * product_rest)
            assert defined == split, (L, sorted(o), '因子の括り出しが破れた')

            # 3: 括り出した成分が零元であること。
            assert ch_u[(tau_1, psi[tau_1])] == zero, (
                L, sorted(o), 'ch(U) の成分が零元でない')

            # 4: 主張そのもの。
            assert factor == zero, (L, sorted(o), 'W_O(ch(U), psi) が零元でない')
            count_hypothesis += 1

    print(f'OK: L={L}（軌道 {len(orbits)} 個、'
          f'仮定を満たす psi {count_hypothesis} 件はすべて因子が零元、'
          f'満たさない psi {count_complement} 件はすべて因子が零元でない）')
    return len(orbits), count_hypothesis, count_complement


def main():
    rows = []
    for L in range(1, 7):
        rows.append((L,) + check_for_L(L))
    print()
    print('| L | 軌道の個数 | 仮定を満たす psi | 満たさない psi |')
    print('|---|---|---|---|')
    for (L, n_orbits, n_hyp, n_comp) in rows:
        print(f'| {L} | {n_orbits} | {n_hyp} | {n_comp} |')


main()
