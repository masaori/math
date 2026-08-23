# SageMath: 有理点 2 での有限箱の量が定数列でないこと
# 対象ラベル: claim_finite_box_sequence_at_two_is_not_constant
# 式ペア: a_1(2) = 2 と a_2(2) > 2
# 帰属: ZZ, ZZ[X], QQbar。浮動小数点は使わない。

from itertools import product

R.<X> = PolynomialRing(ZZ)


def box_vertices(box_side):
    return list(product(range(box_side), repeat=3))


def free_box_edges(box_side):
    vertices = set(box_vertices(box_side))
    edges = []
    for vertex in vertices:
        for direction in range(3):
            endpoint = list(vertex)
            endpoint[direction] += 1
            endpoint = tuple(endpoint)
            if endpoint in vertices:
                edges.append((vertex, endpoint))
    return edges


def partition_polynomial(box_side):
    vertices = box_vertices(box_side)
    edges = free_box_edges(box_side)
    polynomial = R(0)
    for assignment in product([1, -1], repeat=len(vertices)):
        spin = dict(zip(vertices, assignment))
        broken = sum(1 for (a, b) in edges if spin[a] != spin[b])
        polynomial += X ** broken
    return polynomial


# L = 1: 辺が無いので分配多項式は定数 2 であり、a_1(2) = 2 である。
edges_one = free_box_edges(1)
polynomial_one = partition_polynomial(1)
assert len(edges_one) == 0, edges_one
assert polynomial_one == R(2), polynomial_one
assert polynomial_one.degree() == 0
value_one = polynomial_one(2)
site_count_one = len(box_vertices(1))
assert site_count_one == 1
root_one = QQbar(value_one).nth_root(site_count_one)
assert root_one == QQbar(2), root_one
print("PASS L=1: #E_1 = 0, Z_1 = %s, a_1(2) = %s" % (polynomial_one, root_one))

# L = 2: 辺があり係数は非負、最高次係数は 2 以上なので Z_2(2) > Z_2(1) = 2^8。
edges_two = free_box_edges(2)
polynomial_two = partition_polynomial(2)
site_count_two = len(box_vertices(2))
assert site_count_two == 8
assert len(edges_two) >= 1
assert polynomial_two.degree() == len(edges_two)
assert all(coefficient >= 0 for coefficient in polynomial_two.coefficients(sparse=False))
assert polynomial_two.leading_coefficient() >= 2
assert polynomial_two(1) == 2 ** site_count_two, polynomial_two(1)
assert polynomial_two(2) > 2 ** site_count_two
root_two = QQbar(polynomial_two(2)).nth_root(site_count_two)
assert root_two > QQbar(2), root_two
print("PASS L=2: #E_2 = %d, Z_2(1) = %d, Z_2(2) = %d, a_2(2) > 2" % (len(edges_two), polynomial_two(1), polynomial_two(2)))

# 二つの項が相異なるので、列は定数列でない。
assert root_one != root_two
print("PASS: a_1(2) != a_2(2) なので L -> a_L(2) は定数列でない")
