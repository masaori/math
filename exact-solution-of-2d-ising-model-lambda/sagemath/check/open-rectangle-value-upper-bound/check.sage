# 対象ラベル: claim_open_rectangle_value_upper_bound_le_one claim_open_rectangle_value_upper_bound_one_le

from itertools import product

T_LE_ONE = [QQ(1), QQ(3) / 4, QQ(1) / 2, QQ(1) / 5]
T_ONE_LE = [QQ(1), QQ(5) / 4, QQ(2), QQ(7) / 3]
SHAPES = [(1, 1), (1, 2), (2, 1), (2, 2), (2, 3), (3, 2), (3, 3), (1, 4)]


def vertices(a, b):
    return [(i, j) for i in range(a) for j in range(b)]


def edges(a, b):
    return ([((i, j), (i, j + 1)) for i in range(a) for j in range(b - 1)] +
            [((i, j), (i + 1, j)) for i in range(a - 1) for j in range(b)])


def broken_count(a, b, sigma):
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in edges(a, b))


def terms(a, b, t):
    vs = vertices(a, b)
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vs)):
        sigma = dict(zip(vs, values))
        yield t ** broken_count(a, b, sigma)


def check_le_one():
    total = 0
    for a, b in SHAPES:
        for t in T_LE_ONE:
            values = list(terms(a, b, t))
            assert all(term <= 1 for term in values)
            assert len(values) == 2 ** (a * b)
            assert sum(values) <= 2 ** (a * b)
            total += 1
    print(f"0<t<=1 の配位数上界: {total} 件 OK")
    return total


def check_one_le():
    total = 0
    for a, b in SHAPES:
        edge_cap = 2 * a * b
        assert len(edges(a, b)) == 2 * a * b - a - b
        assert len(edges(a, b)) <= edge_cap
        for t in T_ONE_LE:
            values = list(terms(a, b, t))
            assert all(term <= t ** edge_cap for term in values)
            assert len(values) == 2 ** (a * b)
            assert sum(values) <= 2 ** (a * b) * t ** edge_cap
            total += 1
    print(f"1<=t の配位数・辺数上界: {total} 件 OK")
    return total


n = check_le_one() + check_one_le()
print(f"合計 {n} 件 OK")
