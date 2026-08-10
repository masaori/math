# 対象ラベル: claim_orbit_family_distributive
#
# 本文（structured-latex/content/main-text.ts の章「固有値の代数性」）の主張
#   prod_{O in s} ( sum_{psi in B_O} g(O, psi) ) = sum_{alpha in A(s)} prod_{O in s} g(O, alpha(O))
# を、小さい L で s を動かしながら総当たりに確かめる。
# 計算はすべて Z[x][t] の中の厳密な多項式演算であり、浮動小数点は使わない。
#
# 何を確かめるか:
#   0. 出発点（s = 空集合）。両辺とも Z[x][t] の 1 になること。
#      本文の証明はここで「空集合にわたる有限積は 1」と「A(空集合) がちょうど 1 元」を使う。
#   1. 主張そのもの。s を動かして両辺を別々に組み立て、多項式として等しいこと。
#      左辺は「各軌道で和を取ってから積」、右辺は「組ごとに積を取ってから和」であり、
#      同じ式を 2 通りに書いたものではない（片方から他方を代入で作っていない）。
#   2. 一歩（帰納法の段）。O_0 not in s のとき
#        LHS({O_0} + s) = ( sum_{psi in B_{O_0}} g(O_0, psi) ) * LHS(s)
#      であること。本文の一歩の第 1 の等号（元を 1 つ足した集合にわたる有限積）に当たる。
#   3. 主張が空でないこと。左辺の因子が 1 項だけの和になっていない（|B_O| > 1 の軌道がある）、
#      かつ右辺の項数 |A(s)| が 1 より大きい s が実在すること。
#      すべての軌道が 1 元集合なら両辺とも自明に一致してしまうので、これを別に見る。
#
# 走らせる L の範囲について。
#   L=1,2,3 は s を O_L の部分集合すべてにわたって走らせる。
#   L=4 は A(s) が全体で 27648 個になり多項式の積の総当たりが現実的でないため、
#   s を空集合・1 元・2 元（軌道の大きさが 4 のもの 2 つ）に絞る。この打ち切りは隠さない。
#
# g の取り方について。
#   本文の g は「各 (O, psi) へ Z[x][t] の元を与える任意の対応」である。検証では、
#   軌道と全単射の並び順から決まる決定的な多項式を割り当てる（乱数を使わない。再現するため）。
#   零多項式にも定数にもならない形（t の冪と x の冪と定数の和）にして、
#   分配則が退化した状況で通ってしまうことを避ける。

import itertools
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', '..', '_shared', 'defs.sage'))

# Z[x][t]。本文の def_second_polynomial_ring と同じ持ち方（係数環が Z[x]）。
Rx = PolynomialRing(ZZ, 'x')
Rxt = PolynomialRing(Rx, 't')
xx = Rx.gen()
tt = Rxt.gen()


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


def orbit_set(L):
    """def_row_config_orbit_set: O_L = { O(tau) | tau in R_L }。"""
    return {
        orbit(L, row_config_from_key(key)) for key in row_matrix_keys(L)
    }


def orbit_bijections(O):
    """def_orbit_bijection_set: B_O（O から O への全単射の全体）。"""
    keys = sorted(O)
    return [dict(zip(keys, images)) for images in itertools.permutations(keys)]


def orbit_families_on(L, s):
    """def_orbit_family_on_subset: A(s)（s の各元 O へ B_O の元を 1 つずつ）。"""
    ordered = sorted(s, key=lambda o: sorted(o))
    per_orbit = [orbit_bijections(o) for o in ordered]
    for choice in itertools.product(*per_orbit):
        yield {ordered[i]: choice[i] for i in range(len(ordered))}


def weight(orbits, O, psi):
    """g(O, psi) in Z[x][t]。軌道と全単射の並び順から決まる決定的な元（乱数を使わない）。

    i は O が O_L の中で何番目か、j は psi が B_O の中で何番目かである。
    t^(j+1) + (i+1) x^(j+1) + (i+j+2) と取る。零にも定数にもならず、
    (O, psi) ごとに異なる（j が違えば t の次数が違い、i が違えば x の係数が違う）。
    """
    i = orbits.index(O)
    bijs = orbit_bijections(O)
    j = bijs.index(psi)
    return tt ** (j + 1) + (i + 1) * xx ** (j + 1) + (i + j + 2)


def lhs(L, orbits, s):
    """左辺 prod_{O in s} ( sum_{psi in B_O} g(O, psi) )。"""
    value = Rxt(1)
    for O in sorted(s, key=lambda o: sorted(o)):
        factor = Rxt(0)
        for psi in orbit_bijections(O):
            factor += weight(orbits, O, psi)
        value *= factor
    return value


def rhs(L, orbits, s):
    """右辺 sum_{alpha in A(s)} prod_{O in s} g(O, alpha(O))。"""
    total = Rxt(0)
    for alpha in orbit_families_on(L, s):
        term = Rxt(1)
        for O in sorted(s, key=lambda o: sorted(o)):
            term *= weight(orbits, O, alpha[O])
        total += term
    return total


def subsets_to_run(L, orbits):
    """走らせる s の範囲。L<=3 は全部分集合、L=4 は空・1 元・大きい軌道 2 つに絞る（打ち切り）。"""
    if L <= 3:
        for r in range(len(orbits) + 1):
            for combo in itertools.combinations(orbits, r):
                yield list(combo)
    else:
        yield []
        for O in orbits:
            yield [O]
        big = [O for O in orbits if len(O) == max(len(o) for o in orbits)]
        yield big[:2]


def check_base_case(L, orbits):
    """0. 出発点。s = 空集合で両辺とも 1 であること。"""
    assert lhs(L, orbits, []) == Rxt(1), L
    families = list(orbit_families_on(L, []))
    assert len(families) == 1 and families[0] == {}, (L, families)
    assert rhs(L, orbits, []) == Rxt(1), L
    print(f'L={L}: 出発点（s = 空集合）は両辺とも 1 である')


def check_distributive(L, orbits):
    """1. 主張そのもの。s を動かして両辺が Z[x][t] の元として等しいこと。"""
    count = 0
    for s in subsets_to_run(L, orbits):
        left = lhs(L, orbits, s)
        right = rhs(L, orbits, s)
        assert left == right, (L, [sorted(o) for o in s], left, right)
        count += 1
    print(f'L={L}: 分配則が成り立つ（確かめた s は {count} 個）')


def check_induction_step(L, orbits):
    """2. 一歩。O_0 not in s のとき LHS({O_0}+s) = ( sum_psi g(O_0,psi) ) * LHS(s)。"""
    count = 0
    for s in subsets_to_run(L, orbits):
        for O_0 in orbits:
            if O_0 in s:
                continue
            s_plus = list(s) + [O_0]
            factor = Rxt(0)
            for psi in orbit_bijections(O_0):
                factor += weight(orbits, O_0, psi)
            assert lhs(L, orbits, s_plus) == factor * lhs(L, orbits, s), (L, sorted(O_0))
            # 右辺の側も、一歩の前後で項数が |B_{O_0}| 倍になること（1 対 1 対応の帰結）。
            n_s = len(list(orbit_families_on(L, s)))
            n_plus = len(list(orbit_families_on(L, s_plus)))
            assert n_plus == n_s * len(orbit_bijections(O_0)), (L, n_s, n_plus)
            count += 1
    print(f'L={L}: 一歩（元を 1 つ足した有限積の分解）が成り立つ（確かめた (s, O_0) は {count} 組）')


def check_not_vacuous():
    """3. 主張が空でないこと（両辺が 1 項どうしの比較になっていないこと）。"""
    L = 3
    orbits = sorted(orbit_set(L), key=lambda o: sorted(o))
    sizes = sorted(len(o) for o in orbits)
    assert sizes == [1, 1, 3, 3], sizes
    big = [O for O in orbits if len(O) == 3]
    assert len(orbit_bijections(big[0])) == 6
    s = big
    n_terms = len(list(orbit_families_on(L, s)))
    assert n_terms == 36, n_terms
    left = lhs(L, orbits, s)
    assert left.degree() > 1, left.degree()
    print(f'L=3: 大きさ 3 の軌道 2 つでは右辺が {n_terms} 項、左辺の次数は {left.degree()} で自明でない')


def main():
    for L in [1, 2, 3, 4]:
        orbits = sorted(orbit_set(L), key=lambda o: sorted(o))
        check_base_case(L, orbits)
        check_distributive(L, orbits)
        check_induction_step(L, orbits)
    check_not_vacuous()
    print('すべての検証が通った（軌道の部分集合にわたる有限積の分配則）')


main()
