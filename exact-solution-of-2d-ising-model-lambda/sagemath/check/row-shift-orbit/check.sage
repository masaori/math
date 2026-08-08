# 対象ラベル: claim_row_config_shift_iterate_injective / def_row_config_orbit /
#             claim_row_config_orbit_card
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で定めた
# 行配位の軌道 O(tau) と、その元の個数が最小周期 e(tau) に等しいことを、
# 小さい L で総当たりに確かめる。すべて ZZ の中の厳密計算で行い、浮動小数点は使わない。
#
# 何を確かめるか:
#   1. claim_row_config_shift_iterate_injective。S^[k] が単射であること。
#      行配位の全対を走り、行き先が一致するのは出発点が一致するときだけであることを見る。
#   2. def_row_config_orbit。O(tau) が tau を含むこと（k=0 の場合）、および
#      O(tau) が S で閉じていること（人手証明が言っていることではないが、
#      「軌道」という語が意味をなす形になっているかの裏取りである）。
#   3. claim_row_config_orbit_card。|O(tau)| = e(tau)。
#      あわせて人手証明の中身（写像 eta_tau: J(tau) -> O(tau) の単射性と全射性）を
#      別々に確かめる。最終の個数だけを見ると、単射性と全射性の両方が誤っていて
#      個数がたまたま一致する場合を見逃すためである。
#      さらに、O(tau) を「反復を e(tau)-1 回まで集めたもの」ではなく
#      「S で閉じるまで飽和させたもの」として独立に作り直し、一致を見る（作り方が独立）。
#
# 主張が空でないことの確認も行う（下の check_not_vacuous）。
#   - L=4 では |O(tau)| が 1, 2, 4 のすべてを実際に取る。すなわち軌道の大きさが
#     つねに L という自明な理由で成り立っているのではない。
#   - L=4 では S^[k] が k=0 以外でも単射性の主張の中身を持つ（S^[k] != id となる k がある）。

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
    集合は行配位のキー（row_config_key の値）の集合として持つ。
    """
    return {row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)}


def orbit_via_saturation(L, tau):
    """O(tau) を「S で閉じるまで飽和させたもの」として作り直したもの。

    反復の回数を数えず、集合が増えなくなるまで S を施して足す。上の orbit とは
    作り方が独立なので、反復の範囲の取り違え（0..L-1 と 1..L など）を検出できる。
    """
    seen = {row_config_key(L, tau)}
    frontier = [dict(tau)]
    while frontier:
        current = frontier.pop()
        image = row_shift(L, current)
        key = row_config_key(L, image)
        if key not in seen:
            seen.add(key)
            frontier.append(image)
    return seen


def check_iterate_injective(L, k_max):
    """1: S^[k] は単射である。"""
    keys = row_matrix_keys(L)
    for k in range(k_max + 1):
        images = {}
        for key in keys:
            image = row_config_key(L, row_shift_iterate(L, k, row_config_from_key(key)))
            assert image not in images, (L, k, key, images.get(image), '単射でない')
            images[image] = key
    print(f'OK: L={L} で S^[k] は単射（k=0..{k_max}、行配位は全 {2 ** L} 通りを総当たり）')


def check_orbit_definition(L):
    """2: O(tau) は tau を含み、S で閉じている。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        o = orbit(L, tau)
        assert row_config_key(L, tau) in o, (L, key, 'tau が O(tau) に属さない')
        for member_key in o:
            image_key = row_config_key(L, row_shift(L, row_config_from_key(member_key)))
            assert image_key in o, (L, key, member_key, 'S で閉じていない')
    print(f'OK: L={L} で O(tau) は tau を含み S で閉じている（行配位は全 {2 ** L} 通り）')


def check_eta_injective_and_surjective(L):
    """3 の前半: 人手証明の eta_tau: J(tau) -> O(tau) が単射かつ全射であること。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        e = minimal_period(L, tau)
        # 単射性: 0 <= a < b < e では eta_tau(a) != eta_tau(b)。
        images = {}
        for k in range(e):
            image = row_config_key(L, row_shift_iterate(L, k, tau))
            assert image not in images, (L, key, e, k, images.get(image), 'eta が単射でない')
            images[image] = k
        # 全射性: O(tau) の各元が 0 <= r < e のどれかの反復で得られる。
        for member_key in orbit(L, tau):
            assert member_key in images, (L, key, e, member_key, 'eta が全射でない')
    print(f'OK: L={L} で eta_tau: J(tau) -> O(tau) は単射かつ全射（行配位は全 {2 ** L} 通り）')


def check_orbit_card(L):
    """3 の後半: |O(tau)| = e(tau)。飽和で作り直した軌道とも一致する。"""
    for key in row_matrix_keys(L):
        tau = row_config_from_key(key)
        e = minimal_period(L, tau)
        o = orbit(L, tau)
        assert len(o) == e, (L, key, len(o), e)
        assert o == orbit_via_saturation(L, tau), (L, key, '飽和で作った軌道と一致しない')
        # claim_row_config_minimal_period_divides_L と合わせた帰結（次のセクションで使う形）。
        assert L % len(o) == 0, (L, key, len(o))
    print(f'OK: L={L} で |O(tau)| = e(tau)（飽和で作り直した軌道とも一致。全 {2 ** L} 通り）')


def check_not_vacuous():
    """4: 主張が空でないこと。"""
    # |O(tau)| は L と一致するとは限らない（L=4 では 1, 2, 4 のすべてが現れる）。
    L = 4
    sizes = set()
    for key in row_matrix_keys(L):
        sizes.add(len(orbit(L, row_config_from_key(key))))
    assert sizes == {1, 2, 4}, (L, sizes)
    # S^[k] が恒等写像でない k が実際にある（単射性の主張が k=0 で自明に済んでいない）。
    non_identity_seen = False
    for k in range(1, L):
        for key in row_matrix_keys(L):
            tau = row_config_from_key(key)
            if row_shift_iterate(L, k, tau) != tau:
                non_identity_seen = True
    assert non_identity_seen
    print('OK: L=4 で |O(tau)| は 1,2,4 のすべてを取り、S^[k] != id となる k がある（主張は空でない）')


def main():
    for L in [1, 2, 3, 4, 5, 6]:
        check_iterate_injective(L, 2 * L)
        check_orbit_definition(L)
        check_eta_injective_and_surjective(L)
        check_orbit_card(L)
    check_not_vacuous()
    print('すべての検証が通った（行配位の軌道と、その元の個数）')


main()
