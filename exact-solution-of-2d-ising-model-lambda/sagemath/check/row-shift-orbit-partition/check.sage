# 対象ラベル: claim_row_config_orbit_mem_eq / claim_row_config_orbit_disjoint_or_eq /
#             def_row_config_orbit_set / claim_row_config_orbit_partition
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で示した
# 「行配位の全体が軌道たちへ分割されること」を、小さい L で総当たりに確かめる。
# すべて ZZ の中の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. claim_row_config_orbit_mem_eq。tau' in O(tau) ならば O(tau') = O(tau)。
#      行配位の全対ではなく、tau と「その軌道の各元」の対を総当たりする
#      （仮定を満たす対の全体がちょうどこれである）。
#      あわせて人手証明の中身も別々に確かめる。すなわち
#      (a) 包含の補題「tau_2 in O(tau_1) ならば O(tau_2) は O(tau_1) に含まれる」、
#      (b) 人手証明が tau in O(tau') を出すのに使った具体的な反復の回数
#          k_0 = (e(tau) - 1) * m がほんとうに tau へ戻すこと。
#      最終の等式だけを見ると、k_0 の取り方が誤っていても（別の回数で戻れば）
#      等式は成り立ってしまい、誤りが隠れる。
#   2. claim_row_config_orbit_disjoint_or_eq。O(tau_1) と O(tau_2) が共通の元を持つならば一致する。
#      行配位の全対を総当たりする。
#   3. def_row_config_orbit_set と claim_row_config_orbit_partition。
#      軌道の全体 O_L を作り、分割の 3 条件（空でない・相異なる 2 元は互いに素・
#      合併が R_L）を確かめる。あわせて元の個数の和が |R_L| = 2^L に等しいことも見る
#      （次のセクションで特性多項式の次数を数えるときに使う形）。
#
# 主張が空でないことの確認も行う（下の check_not_vacuous）。
#   - L=4 では |O_L| < |R_L| である。すなわち相異なる行配位が同じ軌道を与える場合が実際にあり、
#     「軌道の全体」を集合として取ることが効いている。
#   - L=4 では互いに素でない（＝一致する）軌道の対が実際にあり、かつ交わらない対も実際にある。
#     すなわち主張の 2 つの場合がどちらも空でない。

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


def minimal_period(L, tau):
    """def_row_config_shift_minimal_period: K(tau) の最小元 e(tau)。"""
    for k in range(1, L + 1):
        if row_shift_iterate(L, k, tau) == tau:
            return k
    raise AssertionError('K(tau) が空である（L が属していない）')


def orbit(L, tau):
    """def_row_config_orbit: O(tau) = { S^[k](tau) | k in N }。

    反復は高々 L 回でもとへ戻るので、k を 0..L-1 まで走らせれば全体が得られる
    （このことは本文の claim_row_config_shift_period が保証している）。
    行配位のキー（row_config_key の値）を凍結した集合として持つ。集合の集合を作るため。
    """
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。

    同じ集合を 2 度数えないこと（本文が O_L を集合として定めていること）は、
    Python の集合が要素の重複を持たないことで実現される。
    """
    return {orbit(L, row_config_from_key(key)) for key in row_matrix_keys(L)}


def check_orbit_mem_eq(L):
    """1: tau' in O(tau) ならば O(tau') = O(tau)。人手証明の中身も別々に見る。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        e = minimal_period(L, tau)
        o = orbit(L, tau)
        for member_key in o:
            tau_prime = row_config_from_key(member_key)
            # (a) 包含の補題（両向きに当てる形で使われる）。
            assert orbit(L, tau_prime) <= o, (L, key, member_key, '包含 O(tau) 側が破れた')
            # 主張そのもの。
            assert orbit(L, tau_prime) == o, (L, key, member_key, 'O(tau) = O(tau) でない')
        # (b) 人手証明が tau in O(tau') を出すのに使った反復の回数 k_0 = (e-1)*m。
        #     m は tau' = S^[m](tau) を満たす回数で、0 <= m < L を走らせれば
        #     O(tau) の元はすべて現れる。
        for m in range(L):
            tau_prime = row_shift_iterate(L, m, tau)
            k_0 = (e - 1) * m
            assert row_shift_iterate(L, k_0, tau_prime) == tau, (
                L, key, m, e, k_0, '人手証明の k_0 = (e-1)m が tau へ戻さない')
    print(f'OK: L={L} で tau\' in O(tau) ならば O(tau\') = O(tau)'
          f'（包含の補題と k_0 = (e-1)m も別々に確認。行配位は全 {2 ** L} 通り）')


def check_orbit_disjoint_or_eq(L):
    """2: O(tau_1) と O(tau_2) が交わるならば一致する。行配位の全対を総当たり。"""
    keys = row_matrix_keys(L)
    for key_1 in keys:
        o_1 = orbit(L, row_config_from_key(key_1))
        for key_2 in keys:
            o_2 = orbit(L, row_config_from_key(key_2))
            if o_1 & o_2:
                assert o_1 == o_2, (L, key_1, key_2, '交わるのに一致しない')
    print(f'OK: L={L} で 2 つの軌道は一致するか互いに素（全 {2 ** L} x {2 ** L} 対を総当たり）')


def check_orbit_partition(L):
    """3: O_L が R_L の分割であること（空でない・互いに素・合併が R_L）。"""
    all_keys = set(row_matrix_keys(L))
    os_l = orbit_set(L)
    # (i) どの元も空でない。
    for o in os_l:
        assert len(o) > 0, (L, '空の軌道がある')
    # (ii) 相異なる 2 元は互いに素。
    for o_1 in os_l:
        for o_2 in os_l:
            if o_1 != o_2:
                assert not (o_1 & o_2), (L, o_1, o_2, '相異なる 2 元が交わる')
    # (iii) 合併が R_L。
    union = set()
    for o in os_l:
        union |= set(o)
    assert union == all_keys, (L, '合併が R_L と一致しない')
    # 次のセクションで使う形: 個数の和が |R_L| = 2^L（(i)〜(iii) からの帰結）。
    assert sum(len(o) for o in os_l) == 2 ** L, (L, sum(len(o) for o in os_l))
    print(f'OK: L={L} で O_L は R_L の分割（|O_L|={len(os_l)}、個数の和は 2^{L}={2 ** L}）')


def check_not_vacuous():
    """4: 主張が空でないこと。"""
    L = 4
    os_l = orbit_set(L)
    # 相異なる行配位が同じ軌道を与える場合が実際にある（|O_L| < |R_L|）。
    assert len(os_l) < 2 ** L, (L, len(os_l))
    # 一致する対と交わらない対がどちらも実際にある（主張の 2 つの場合がどちらも空でない）。
    keys = row_matrix_keys(L)
    equal_seen = False
    disjoint_seen = False
    for key_1 in keys:
        o_1 = orbit(L, row_config_from_key(key_1))
        for key_2 in keys:
            o_2 = orbit(L, row_config_from_key(key_2))
            if key_1 != key_2 and o_1 == o_2:
                equal_seen = True
            if not (o_1 & o_2):
                disjoint_seen = True
    assert equal_seen and disjoint_seen, (equal_seen, disjoint_seen)
    print(f'OK: L=4 で |O_L|={len(os_l)} < 16 であり、一致する軌道の対も交わらない対も実際にある'
          '（主張は空でない）')


def main():
    for L in [1, 2, 3, 4, 5, 6]:
        check_orbit_mem_eq(L)
        check_orbit_disjoint_or_eq(L)
        check_orbit_partition(L)
    check_not_vacuous()
    print('すべての検証が通った（軌道による行配位の全体の分割）')


main()
