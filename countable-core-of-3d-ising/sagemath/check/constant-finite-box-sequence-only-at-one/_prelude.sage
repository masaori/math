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


def configurations(box_side):
    sites = box_sites(box_side)
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        yield dict(zip(sites, values))


def broken_edges(configuration, edges):
    return {edge for edge in edges if configuration[edge[0]] != configuration[edge[1]]}


def odd_flip(configuration):
    return {
        site: (-value if sum(site) % 2 == 1 else value)
        for site, value in configuration.items()
    }


def multiplicities(box_side):
    edges = inner_edges(box_side)
    result = {ZZ(m): ZZ(0) for m in range(len(edges) + 1)}
    for configuration in configurations(box_side):
        result[ZZ(len(broken_edges(configuration, edges)))] += 1
    return result, ZZ(len(edges))


def partition_polynomial(multiplicity, edge_count):
    return sum(multiplicity[ZZ(m)] * X ** m for m in range(edge_count + 1))
