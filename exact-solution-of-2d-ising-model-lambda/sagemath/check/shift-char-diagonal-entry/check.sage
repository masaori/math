# 対象ラベル: claim_shift_char_diagonal_entry
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
# 「シフト行列の特性行列の対角成分は、その軌道の元の個数で決まる」
# （O in O_L と tau in O について、|O| >= 2 なら ch(U)_{tau,tau} = t、
#   |O| = 1 なら ch(U)_{tau,tau} = t + iota(-kappa(1))）を、小さい L で総当たりに確かめる。
# 計算は ZZ[x][t] の中の厳密計算と有限集合の数え上げだけで行い、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. 準備。ch(U)_{tau,tau} = t + iota(-U_{tau,tau})。
#   2. 第一の場合。|O| >= 2 ならば S(tau) != tau であり、U_{tau,tau} = kappa(0)、
#      したがって ch(U)_{tau,tau} = t。
#   3. 第二の場合。|O| = 1 ならば S(tau) = tau であり、U_{tau,tau} = kappa(1)、
#      したがって ch(U)_{tau,tau} = t + iota(-kappa(1))。
#   4. 主張が空でないこと。|O| >= 2 の tau と |O| = 1 の tau が両方現れること。
#      **これを見ないと、どちらか一方の場合しか無くても 2・3 が通ってしまう。**
#   5. 2 つの値が相異なること（場合分けが値を実際に分けていること）。
#
# 走らせる範囲（打ち切りを隠さない）。
#   軌道 O をすべて、その元 tau をすべて走らせる。L = 1,...,6 まで回す
#   （本文の他の検証と範囲を揃えた）。

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


def shift_key(L, key):
    """キーの上で S を作用させる。"""
    return row_config_key(L, row_shift(L, row_config_from_key(key)))


def iterate_key(L, k, key):
    """def_row_config_shift_iterate をキーの上で反復する。"""
    result = key
    for _ in range(k):
        result = shift_key(L, result)
    return result


def orbit_of_key(L, key):
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。"""
    return frozenset(iterate_key(L, k, key) for k in range(L))


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


def check_for_L(L):
    U = shift_matrix(L)
    ch = characteristic_matrix(L, U)
    orbits = orbit_set(L)

    value_big = t
    value_one = t + iota(-const_poly(1))

    # 5: 2 つの値が相異なること（場合分けが値を実際に分けていること）。
    assert value_big != value_one, (L, '2 つの場合の値が一致してしまっている')

    count_big = 0
    count_one = 0
    for o in orbits:
        for key in sorted(o):
            # 1: 準備。ch(U)_{tau,tau} = t + iota(-U_{tau,tau})。
            assert ch[(key, key)] == t + iota(-U[(key, key)]), (
                L, '準備の等式が破れた')

            if len(o) >= 2:
                # 2: 第一の場合。
                assert shift_key(L, key) != key, (L, '|O| >= 2 なのに S(tau) = tau')
                assert U[(key, key)] == const_poly(0), (
                    L, 'U_{tau,tau} = kappa(0) が破れた')
                assert ch[(key, key)] == value_big, (
                    L, 'ch(U)_{tau,tau} = t が破れた')
                count_big += 1
            else:
                # 3: 第二の場合。
                assert len(o) == 1, (L, '軌道の元の個数が 0 になった')
                assert shift_key(L, key) == key, (L, '|O| = 1 なのに S(tau) != tau')
                assert U[(key, key)] == const_poly(1), (
                    L, 'U_{tau,tau} = kappa(1) が破れた')
                assert ch[(key, key)] == value_one, (
                    L, 'ch(U)_{tau,tau} = t + iota(-kappa(1)) が破れた')
                count_one += 1

    # 4: 主張が空でないこと。
    assert count_one >= 1, (L, '|O| = 1 の tau が 1 つも無い')
    if L >= 2:
        assert count_big >= 1, (L, '|O| >= 2 の tau が 1 つも無い')

    print(f'OK: L={L}（軌道 {len(orbits)} 個、'
          f'|O| >= 2 の tau {count_big} 件はすべて ch(U)_(tau,tau) = t、'
          f'|O| = 1 の tau {count_one} 件はすべて ch(U)_(tau,tau) = t + iota(-kappa(1))）')
    return len(orbits), count_big, count_one


def main():
    rows = []
    for L in range(1, 7):
        rows.append((L,) + check_for_L(L))
    print()
    print('| L | 軌道の個数 | |O| >= 2 の tau | |O| = 1 の tau |')
    print('|---|---|---|---|')
    for (L, n_orbits, n_big, n_one) in rows:
        print(f'| {L} | {n_orbits} | {n_big} | {n_one} |')


main()
