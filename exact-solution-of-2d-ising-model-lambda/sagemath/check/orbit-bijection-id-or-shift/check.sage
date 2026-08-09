# 対象ラベル: claim_shift_orbit_preserving / claim_orbit_bijection_id_or_shift
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
#   (a) 巡回シフト S は軌道を保つ置換である（S in S^O_L）。したがって各軌道 O について
#       制限 S|_O が定まり、B_O の元である。
#   (b) O の上の全単射 psi が「任意の tau in O について psi(tau) = tau または psi(tau) = S(tau)」を
#       満たすならば、psi = id_O または psi = S|_O である。
# を、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像の比較であり、浮動小数点は使わない（数は ZZ の中の個数だけ）。
#
# (b) は **両向きに** 確かめる。
#   健全性: 条件を満たす psi の全体が {id_O, S|_O} に含まれること（本文の主張そのもの）。
#   非空虚性: 逆に id_O と S|_O が実際に条件を満たすこと。これを確かめないと、
#            条件を満たす psi が 1 つも無い（仮定が空虚）場合に主張が自明に成り立ってしまう。
#   さらに |O| >= 2 の軌道では id_O != S|_O であること（2 つが潰れていないこと）も確かめる。
#   |O| = 1 の軌道では S|_O = id_O であり、条件を満たす全単射はこの 1 つだけである。
#
# 走らせる L の範囲: B_O の全列挙は |O|! 通りで、|O| は L の約数なので L = 1,...,6 まで回せる。
# S_L の全列挙は要らない（S|_O は S から直接作る）。

import os
import itertools

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


def shift_key(L, key):
    """S をキーの上の写像として持つ。"""
    return row_config_key(L, row_shift(L, row_config_from_key(key)))


def orbit(L, tau):
    """def_row_config_orbit: O(tau)（キーの凍結集合として持つ）。"""
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_of_key(L, key):
    return orbit(L, row_config_from_key(key))


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return sorted(
        {orbit_of_key(L, key) for key in row_matrix_keys(L)}, key=lambda o: sorted(o)
    )


def orbit_bijections(o):
    """def_orbit_bijection_set: B_O（O の上の全単射の全体）を全列挙する。"""
    members = sorted(o)
    return [dict(zip(members, image)) for image in itertools.permutations(members)]


def check_shift_orbit_preserving(L, orbits):
    """(a) S in S^O_L であること、および S|_O が B_O の元であること。"""
    for key in row_matrix_keys(L):
        assert shift_key(L, key) in orbit_of_key(L, key), (L, 'S(tau) が O(tau) に属さない')
    for o in orbits:
        restriction = {key: shift_key(L, key) for key in sorted(o)}
        assert set(restriction.values()) == set(o), (L, 'S|_O が O の上の全単射でない')
        assert restriction in orbit_bijections(o), (L, 'S|_O が B_O の元でない')
    print(f'OK: L={L} で S は軌道を保つ置換であり、'
          f'{len(orbits)} 個の軌道すべてで S|_O が B_O の元である')


def check_id_or_shift(L, orbits):
    """(b) 条件を満たす B_O の元が id_O と S|_O だけであること（両向き）。"""
    for o in orbits:
        identity = {key: key for key in sorted(o)}
        restriction = {key: shift_key(L, key) for key in sorted(o)}
        satisfying = [
            psi for psi in orbit_bijections(o)
            if all(psi[key] == key or psi[key] == shift_key(L, key) for key in sorted(o))
        ]
        # 健全性: 条件を満たすものは id_O か S|_O に限る。
        for psi in satisfying:
            assert psi == identity or psi == restriction, (
                L, '条件を満たすのに id_O でも S|_O でもない全単射がある')
        # 非空虚性: id_O と S|_O は実際に条件を満たす。
        assert identity in satisfying, (L, 'id_O が条件を満たさない')
        assert restriction in satisfying, (L, 'S|_O が条件を満たさない')
        # 2 つが潰れる（= 一致する）のは |O| = 1 のときに限る。
        if len(o) == 1:
            assert identity == restriction, (L, '|O|=1 なのに S|_O が id_O と違う')
            assert len(satisfying) == 1, (L, '|O|=1 なのに条件を満たす全単射が 1 つでない')
        else:
            assert identity != restriction, (L, '|O|>=2 なのに S|_O が id_O と一致する')
            assert len(satisfying) == 2, (L, '|O|>=2 なのに条件を満たす全単射が 2 つでない')
    sizes = sorted(len(o) for o in orbits)
    print(f'OK: L={L} で条件を満たす B_O の元は id_O と S|_O だけである（軌道の大きさは {sizes}）')


def main():
    for L in [1, 2, 3, 4, 5, 6]:
        orbits = orbit_set(L)
        check_shift_orbit_preserving(L, orbits)
        check_id_or_shift(L, orbits)
    print('すべての検証が通った'
          '（S は軌道を保ち、条件を満たす軌道の上の全単射は id_O と S|_O だけである）')


main()
