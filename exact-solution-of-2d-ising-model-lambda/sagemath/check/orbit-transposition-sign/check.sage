# 対象ラベル: def_orbit_inversion_set, claim_orbit_transposition_sign
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で置いた
# 転倒対の集合 Inv_O(psi) と、互換の軌道への制限の符号が -1 であることを、
# 小さい L で総当たりに確かめる。
# すべて有限集合の上の写像・順序・数え上げと整数 -1 の冪だけであり、浮動小数点は使わない。
#
# 何を確かめるか（人手証明の段に 1 対 1 で対応させる）:
#   1. Inv_O(psi) = A ∪ B ∪ C（人手証明が両包含で示した集合の等号）。
#      **等号そのものを見る**。個数だけを突き合わせると、集合が違っていても
#      個数が偶然一致した場合に気づけない。
#   2. A, B, C が互いに素であること（人手証明が個数の和へ移る段の根拠）。
#   3. |A| = |M|、|B| = |M|、|C| = 1（人手証明が置いた 2 つの全単射と C の定義）。
#   4. inv_O(psi) = 2|M| + 1 であること（第一の主張）。
#   5. sgn_O(psi) = -1 であること（第二の主張）。
#   6. 主張が空でないこと。tau_a ≺ tau_b を満たす 2 点が取れる軌道（|O| >= 2）が
#      あるか L ごとに記録する。さらに M が空でない組（すなわち 2|M|+1 > 1 となる組）が
#      あるかも記録する。M が常に空なら、数え上げの本体を見ていないことになる。

import itertools
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))


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


def less(L, key, key_other):
    """def_row_config_order: tau ≺ tau'（キーを行配位へ戻して比べる）。"""
    return row_config_less(L, row_config_from_key(key), row_config_from_key(key_other))


def transposition(key_a, key_b, key):
    """def_orbit_transposition: t_{tau_a,tau_b}(tau)。"""
    if key == key_a:
        return key_b
    if key == key_b:
        return key_a
    return key


def cross_orbit_ordered_pairs(L, orbit):
    """def_cross_orbit_ordered_pairs で O' = O と取った F(O,O)。"""
    members = sorted(orbit)
    return {
        (key, key_other)
        for key in members
        for key_other in members
        if less(L, key, key_other)
    }


def orbit_inversion_set(L, orbit, psi):
    """def_orbit_inversion_set: Inv_O(psi) = { (tau,tau') in F(O,O) | psi(tau') ≺ psi(tau) }。"""
    return {
        (key, key_other)
        for (key, key_other) in cross_orbit_ordered_pairs(L, orbit)
        if less(L, psi(key_other), psi(key))
    }


def check_orbit(L, orbit):
    """1〜5 を、O の中の tau_a ≺ tau_b を満たすすべての組について確かめる。"""
    members = sorted(orbit)
    pair_count = 0
    nonempty_M_count = 0
    for key_a in members:
        for key_b in members:
            if not less(L, key_a, key_b):
                continue
            pair_count += 1

            def psi(key, key_a=key_a, key_b=key_b):
                return transposition(key_a, key_b, key)

            inv_set = orbit_inversion_set(L, orbit, psi)

            # 人手証明が置いた M, A, B, C。
            M = {
                key for key in members
                if less(L, key_a, key) and less(L, key, key_b)
            }
            A = {(key_a, key) for key in M}
            B = {(key, key_b) for key in M}
            C = {(key_a, key_b)}

            # 1: 集合の等号そのもの。
            assert inv_set == A | B | C, (L, 'Inv_O(psi) = A ∪ B ∪ C が破れた')
            # 2: 互いに素であること。
            assert not (A & B), (L, 'A と B が交わる')
            assert not (A & C), (L, 'A と C が交わる')
            assert not (B & C), (L, 'B と C が交わる')
            # 3: 個数。
            assert len(A) == len(M), (L, '|A| = |M| が破れた')
            assert len(B) == len(M), (L, '|B| = |M| が破れた')
            assert len(C) == 1, (L, '|C| = 1 が破れた')
            # 4: 第一の主張。
            assert len(inv_set) == 2 * len(M) + 1, (L, 'inv_O = 2|M| + 1 が破れた')
            # 5: 第二の主張。符号は ZZ の中の計算である。
            assert ZZ(-1) ** len(inv_set) == ZZ(-1), (L, 'sgn_O = -1 が破れた')

            if M:
                nonempty_M_count += 1
    return pair_count, nonempty_M_count


def main():
    for L in range(1, 7):
        orbits = orbit_set(L)
        total_pairs = 0
        total_nonempty = 0
        for orbit in orbits:
            pair_count, nonempty_M_count = check_orbit(L, orbit)
            total_pairs += pair_count
            total_nonempty += nonempty_M_count
        print(f'OK: L={L} で Inv_O(psi) = A ∪ B ∪ C、互いに素、|A|=|B|=|M|、'
              f'inv_O = 2|M|+1、sgn_O = -1'
              f'（軌道 {len(orbits)} 個、tau_a ≺ tau_b の組 {total_pairs} 通り）')
        sizes = sorted({len(o) for o in orbits})
        print(f'    記録: L={L} 軌道の大きさ {sizes}、'
              f'tau_a ≺ tau_b が取れる組 {total_pairs} 通り、'
              f'そのうち M が空でない組 {total_nonempty} 通り')
    print('すべて通過: def_orbit_inversion_set, claim_orbit_transposition_sign')


main()
