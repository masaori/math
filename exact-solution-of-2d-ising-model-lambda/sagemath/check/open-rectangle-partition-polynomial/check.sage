# 対象ラベル: def_open_rectangle_vertices, def_open_rectangle_edges,
#             def_open_rectangle_configuration,
#             def_open_rectangle_broken_bond_count,
#             def_open_rectangle_partition_polynomial
#
# 開境界長方形の定義を、そのまま有限集合と ZZ[x] の多項式として実装する。
# a,b ∈ {1,2,3} の全長方形について、頂点数・辺数・配位数・破れボンド数の範囲・
# 分配多項式の係数和を厳密に検査する。浮動小数点は使わない。

from itertools import product

R.<x> = PolynomialRing(ZZ)


def open_vertices(a, b):
    return [(i, j) for i in range(a) for j in range(b)]


def open_edges(a, b):
    horizontal = [('h', i, j) for i in range(a) for j in range(b - 1)]
    vertical = [('v', i, j) for i in range(a - 1) for j in range(b)]
    return horizontal + vertical


def endpoints(edge):
    direction, i, j = edge
    if direction == 'h':
        return (i, j), (i, j + 1)
    return (i, j), (i + 1, j)


def open_configurations(a, b):
    vertices = open_vertices(a, b)
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vertices)):
        yield dict(zip(vertices, values))


def open_broken_bond_count(a, b, sigma):
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in map(endpoints, open_edges(a, b)))


def open_partition_polynomial(a, b):
    return sum((x ** open_broken_bond_count(a, b, sigma)
                for sigma in open_configurations(a, b)), R.zero())


total = 0
for a in range(1, 4):
    for b in range(1, 4):
        vertices = open_vertices(a, b)
        edges = open_edges(a, b)
        configs = list(open_configurations(a, b))
        polynomial = open_partition_polynomial(a, b)

        assert len(vertices) == a * b
        assert len(set(vertices)) == len(vertices)
        total += 2

        assert len(edges) == a * (b - 1) + (a - 1) * b
        assert len(set(edges)) == len(edges)
        assert all(u in vertices and v in vertices for u, v in map(endpoints, edges))
        total += 3

        assert len(configs) == 2 ** (a * b)
        assert all(set(sigma.keys()) == set(vertices) for sigma in configs)
        total += 2

        counts = [open_broken_bond_count(a, b, sigma) for sigma in configs]
        assert all(0 <= count <= len(edges) for count in counts)
        total += 1

        assert polynomial.parent() is R
        assert polynomial == sum((x ** count for count in counts), R.zero())
        assert polynomial(ZZ(1)) == 2 ** (a * b)
        assert all(coefficient >= 0 for coefficient in polynomial.list())
        total += 4

print(f"開境界長方形の定義と分配多項式（ZZ[x] で厳密）: {total} 件 OK")
