from itertools import product


polynomial_ring = PolynomialRing(ZZ, "X")
X = polynomial_ring.gen()


def box_sites(box_side):
    return [
        (ZZ(a), ZZ(b), ZZ(c))
        for a in range(box_side)
        for b in range(box_side)
        for c in range(box_side)
    ]


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
    result = polynomial_ring.zero()
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        configuration = dict(zip(sites, values))
        broken_count = sum(
            ZZ(configuration[start] != configuration[end])
            for start, end in edges
        )
        result += X ** broken_count
    return result, ZZ(len(edges))
