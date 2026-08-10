# 対象ラベル: def_orbit_bijection_set / def_orbit_family_on_subset /
#             claim_orbit_family_insert_bijection
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）で置いた
# 「1 つの軌道の上の全単射の全体」B_O、「軌道の部分集合ごとの置換の組」A(s)、および
# ins と spl が互いに逆であることを、小さい L で総当たりに確かめる。
# すべて有限集合の上の写像の比較であり、浮動小数点は使わない（数として現れるのは個数だけ）。
#
# 何を確かめるか:
#   0. 定義が定まること。B_O の元が O から O への全単射であること、A(s) の元が
#      s の各元 O で B_O の値を取ること、A(O_L) = A_L（前セクションの列挙と一致すること）、
#      および A(空集合) がちょうど 1 元であること。
#      **A(O_L) = A_L を別に確かめる理由**: A(s) は s を動かせるように定義し直したものなので、
#      s = O_L と取ったときに前セクションの A_L と本当に同じ集合になっていなければ、
#      以後の帰納法が別の対象についての議論になってしまう。
#   1. ins(psi, alpha) が A({O_0} + s) の元であること、spl(beta) が B_{O_0} x A(s) の
#      元であること（人手証明が式変形の前に確かめている 2 点）。
#   2. claim_orbit_family_insert_bijection の第 1 の等式 spl(ins(psi, alpha)) = (psi, alpha)。
#   3. 同じく第 2 の等式 ins(spl(beta)) = beta。
#   4. **O_0 not in s が要ることの確認**（仮定が空回りしていないこと）。
#      O_0 in s のとき ins の場合分けが 2 つの値を与えうること、すなわち
#      psi != alpha(O_0) と取ると「O_0 では psi」「O_0 では alpha(O_0)」が衝突することを
#      実際に見つける。仮定を外すと主張が壊れることを示すため。
#
# 走らせる L の範囲について。
#   L=1,2,3 は s を O_L の部分集合すべてにわたって走らせる（O_L の元は L=3 で 4 個なので
#   部分集合は 16 個）。L=4 は O_L の元が 6 個で A(s) が最大 27648 個になるため、
#   s は空集合・1 元・全体の 3 種類に絞る。この打ち切りは overview.md にも書いてある。

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


def orbit(L, tau):
    """def_row_config_orbit: O(tau) = { S^[k](tau) | k in N }（キーの凍結集合として持つ）。"""
    return frozenset(
        row_config_key(L, row_shift_iterate(L, k, tau)) for k in range(L)
    )


def orbit_of_key(L, key):
    return orbit(L, row_config_from_key(key))


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return {orbit_of_key(L, key) for key in row_matrix_keys(L)}


def orbit_bijections(O):
    """def_orbit_bijection_set: B_O = { psi | psi は O から O への全単射 }。

    O はキーの凍結集合。psi はキーからキーへの辞書として持つ。
    """
    keys = sorted(O)
    return [dict(zip(keys, images)) for images in itertools.permutations(keys)]


def orbit_families_on(L, s):
    """def_orbit_family_on_subset: A(s) を全列挙する。

    s は軌道（キーの凍結集合）の列。組 alpha は「軌道 -> その上の全単射」の辞書。
    s が空なら、何も対応させない対応ただ 1 つを返す。
    """
    ordered = sorted(s, key=lambda o: sorted(o))
    per_orbit = [orbit_bijections(o) for o in ordered]
    for choice in itertools.product(*per_orbit):
        yield {ordered[i]: choice[i] for i in range(len(ordered))}


def insert_family(O_0, psi, alpha, s):
    """claim_orbit_family_insert_bijection の ins。

    ins(psi, alpha)(O) = psi (O = O_0) / alpha(O) (O in s)。
    """
    result = {O_0: psi}
    for o in s:
        result[o] = alpha[o]
    return result


def split_family(O_0, beta, s):
    """claim_orbit_family_insert_bijection の spl: spl(beta) = (beta(O_0), beta|_s)。"""
    return beta[O_0], {o: beta[o] for o in s}


def is_bijection_on(O, psi):
    """psi が O から O への全単射か（有限集合なので像の大きさで判定する）。"""
    keys = sorted(O)
    if sorted(psi.keys()) != keys:
        return False
    if any(psi[k] not in O for k in keys):
        return False
    return len({psi[k] for k in keys}) == len(keys)


def check_definitions(L):
    """0. B_O と A(s) の定義が定まること、A(O_L) = A_L、A(空集合) が 1 元であること。"""
    orbits = sorted(orbit_set(L), key=lambda o: sorted(o))
    for o in orbits:
        bijs = orbit_bijections(o)
        assert len(bijs) == factorial(len(o)), (L, o)
        for psi in bijs:
            assert is_bijection_on(o, psi), (L, o, psi)
        assert any(all(psi[k] == k for k in psi) for psi in bijs), (L, o)

    empty = list(orbit_families_on(L, []))
    assert len(empty) == 1 and empty[0] == {}, (L, empty)

    # A(O_L) が前セクションの A_L（軌道ごとに 1 つずつ全単射を選んだ組の全体）と一致すること。
    full = list(orbit_families_on(L, orbits))
    expected = 1
    for o in orbits:
        expected *= factorial(len(o))
    assert len(full) == expected, (L, len(full), expected)
    for alpha in full:
        assert sorted(alpha.keys(), key=lambda o: sorted(o)) == orbits, (L, alpha)
        for o in orbits:
            assert is_bijection_on(o, alpha[o]), (L, o)
    print(f'L={L}: B_O と A(s) の定義が定まる（A(O_L) は {len(full)} 個、A(空集合) は 1 個）')


def subsets_to_run(L, orbits):
    """走らせる s の範囲。L<=3 は全部分集合、L=4 は空・1 元・全体に絞る（打ち切り）。"""
    if L <= 3:
        for r in range(len(orbits) + 1):
            for combo in itertools.combinations(orbits, r):
                yield list(combo)
    else:
        yield []
        for o in orbits:
            yield [o]
        yield list(orbits)


def check_insert_split(L):
    """1〜3. ins と spl が所属を保ち、互いに逆であること。"""
    orbits = sorted(orbit_set(L), key=lambda o: sorted(o))
    pairs = 0
    for s in subsets_to_run(L, orbits):
        for O_0 in orbits:
            if O_0 in s:
                continue
            s_plus = sorted(list(s) + [O_0], key=lambda o: sorted(o))
            # 1・2. ins が A({O_0} + s) の元を与え、spl が (psi, alpha) を戻すこと。
            for psi in orbit_bijections(O_0):
                for alpha in orbit_families_on(L, s):
                    gamma = insert_family(O_0, psi, alpha, s)
                    assert sorted(gamma.keys(), key=lambda o: sorted(o)) == s_plus, (L, s, O_0)
                    for o in s_plus:
                        assert is_bijection_on(o, gamma[o]), (L, s, O_0, o)
                    back_psi, back_alpha = split_family(O_0, gamma, s)
                    assert back_psi == psi, (L, s, O_0)
                    assert back_alpha == alpha, (L, s, O_0)
                    pairs += 1
            # 1・3. spl が B_{O_0} x A(s) の元を与え、ins が beta を戻すこと。
            for beta in orbit_families_on(L, s_plus):
                psi2, alpha2 = split_family(O_0, beta, s)
                assert is_bijection_on(O_0, psi2), (L, s, O_0)
                for o in s:
                    assert is_bijection_on(o, alpha2[o]), (L, s, O_0, o)
                assert insert_family(O_0, psi2, alpha2, s) == beta, (L, s, O_0)
    print(f'L={L}: ins と spl は互いに逆である（往復を確かめた組は {pairs} 個）')


def check_disjointness_is_needed(L):
    """4. O_0 not in s を外すと ins の場合分けが 2 つの値を与えうること。"""
    orbits = sorted(orbit_set(L), key=lambda o: sorted(o))
    found = False
    for O_0 in orbits:
        bijs = orbit_bijections(O_0)
        if len(bijs) < 2:
            continue
        # s が O_0 を含む場合。psi と alpha(O_0) が食い違えば、O_0 における値が定まらない。
        s = [O_0]
        for alpha in orbit_families_on(L, s):
            for psi in bijs:
                if psi != alpha[O_0]:
                    found = True
                    break
            if found:
                break
        if found:
            break
    assert found, (L, '仮定 O_0 not in s が空回りしている（値の衝突が起きない）')
    print(f'L={L}: O_0 in s と取ると ins の 2 つの場合が食い違う組が実在する（仮定は空回りしていない）')


def check_not_vacuous():
    """主張が空でないこと。"""
    orbits = sorted(orbit_set(3), key=lambda o: sorted(o))
    sizes = sorted(len(o) for o in orbits)
    assert sizes == [1, 1, 3, 3], sizes
    assert any(len(orbit_bijections(o)) > 1 for o in orbits)
    total = 1
    for o in orbits:
        total *= factorial(len(o))
    assert total == 36, total
    print('L=3: 軌道の大きさは 1,1,3,3 で、A(O_L) は 36 個（1 元集合だけではない）')


def main():
    for L in [1, 2, 3, 4]:
        check_definitions(L)
        check_insert_split(L)
        if L >= 2:
            check_disjointness_is_needed(L)
        else:
            print(f'（L={L} は軌道がすべて 1 元集合で B_O が 1 個しかないので、仮定の必要性は確かめない）')
    check_not_vacuous()
    print('すべての検証が通った（軌道を 1 つ足した組の全体と、その軌道の上の全単射と残りの組との対の 1 対 1 対応）')


main()
