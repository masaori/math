# 対象ラベル: claim_rational_values_determine_partition_polynomial
# 相異なる次数+1 個の正の有理点の素指数データから分配多項式を復元する。
# 帰属: ZZ[X]、QQ[X]、QQ と有限台の整数列だけを使う厳密計算。
from itertools import product


integer_polynomial_ring = PolynomialRing(ZZ, "X")
X = integer_polynomial_ring.gen()
rational_polynomial_ring = PolynomialRing(QQ, "T")


def box_sites(box_side):
    return list(product(range(box_side), repeat=3))


def inner_edges(box_side):
    sites = set(box_sites(box_side))
    edges = []
    for start in sites:
        for direction in range(3):
            end = list(start)
            end[direction] += 1
            end = tuple(end)
            if end in sites:
                edges.append((start, end))
    return edges


def partition_polynomial(box_side):
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    polynomial = integer_polynomial_ring.zero()
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        configuration = dict(zip(sites, values))
        broken_count = sum(
            ZZ(configuration[start] != configuration[end])
            for start, end in edges
        )
        polynomial += X ** broken_count
    return polynomial, ZZ(len(edges))


def prime_exponent_data(value):
    value = QQ(value)
    assert value > 0
    data = {}
    for prime, exponent in ZZ(value.numerator()).factor():
        data[prime] = ZZ(exponent)
    for prime, exponent in ZZ(value.denominator()).factor():
        data[prime] = data.get(prime, ZZ(0)) - ZZ(exponent)
    return {prime: exponent for prime, exponent in data.items() if exponent != 0}


def rational_from_prime_exponent_data(data):
    numerator = ZZ(1)
    denominator = ZZ(1)
    for prime, exponent in data.items():
        if exponent >= 0:
            numerator *= prime ** exponent
        else:
            denominator *= prime ** (-exponent)
    return QQ(numerator) / QQ(denominator)


for box_side in [1, 2]:
    polynomial, degree_bound = partition_polynomial(box_side)
    rational_polynomial = rational_polynomial_ring(polynomial)
    points = [QQ(index + 1) for index in range(degree_bound + 1)]
    values = [rational_polynomial(point) for point in points]

    assert all(value > 0 for value in values)
    exponent_data = [prime_exponent_data(value) for value in values]
    reconstructed_values = [
        rational_from_prime_exponent_data(data) for data in exponent_data
    ]
    assert reconstructed_values == values

    reconstructed_polynomial = rational_polynomial_ring.lagrange_polynomial(
        list(zip(points, reconstructed_values))
    )
    difference = rational_polynomial - reconstructed_polynomial
    assert all(difference(point) == 0 for point in points)
    assert difference == 0
    assert reconstructed_polynomial == rational_polynomial

print("RESULT: PASS")
