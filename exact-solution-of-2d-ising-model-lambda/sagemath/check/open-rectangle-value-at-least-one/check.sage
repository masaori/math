# 対象ラベル: def_open_rectangle_constant_plus_configuration claim_open_rectangle_constant_plus_breaks_no_bond claim_open_rectangle_value_at_least_one

from itertools import product

T_SAMPLES = [QQ(1), QQ(3) / 4, QQ(1) / 2, QQ(1) / 5, QQ(2), QQ(7) / 3]
SHAPES = [(1, 1), (1, 2), (2, 1), (2, 2), (2, 3), (3, 2), (3, 3), (1, 4)]


def vertices(a, b):
    return [(i, j) for i in range(a) for j in range(b)]


def edges(a, b):
    return ([((i, j), (i, j + 1)) for i in range(a) for j in range(b - 1)] +
            [((i, j), (i + 1, j)) for i in range(a - 1) for j in range(b)])


def broken_count(a, b, sigma):
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in edges(a, b))


def all_plus(a, b):
    return {v: ZZ(1) for v in vertices(a, b)}


def open_value(a, b, t):
    vs = vertices(a, b)
    total = QQ.zero()
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vs)):
        sigma = dict(zip(vs, values))
        total += t ** broken_count(a, b, sigma)
    return total


def check_all_plus_breaks_no_bond():
    total = 0
    for a, b in SHAPES:
        tau = all_plus(a, b)
        # τ_+ は配位（各頂点に +1 を割り当てる写像）であり、破れボンド数は零。
        assert set(tau.keys()) == set(vertices(a, b))
        assert broken_count(a, b, tau) == 0, (a, b)
        total += 1
    print(f"全て正の定数配位の破れボンド数は零: {total} 件 OK")
    return total


def check_value_at_least_one():
    total = 0
    for a, b in SHAPES:
        for t in T_SAMPLES:
            z = open_value(a, b, t)
            # 分離した一項 t^0 = 1 と、残りの項が正であることを厳密（QQ）に確かめる。
            tau = all_plus(a, b)
            vs = vertices(a, b)
            rest = QQ.zero()
            for values in product((ZZ(1), ZZ(-1)), repeat=len(vs)):
                sigma = dict(zip(vs, values))
                if sigma == tau:
                    continue
                term = t ** broken_count(a, b, sigma)
                assert term > 0
                rest += term
            assert t ** broken_count(a, b, tau) == 1
            assert z == 1 + rest
            assert 1 <= z, (a, b, t)
            total += 1
    print(f"開境界長方形の値は 1 以上: {total} 件 OK")
    return total


n = check_all_plus_breaks_no_bond() + check_value_at_least_one()
print(f"合計 {n} 件 OK")
