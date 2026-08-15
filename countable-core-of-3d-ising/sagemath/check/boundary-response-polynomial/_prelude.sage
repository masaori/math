from itertools import product


def sites(side):
    return list(product(range(side), repeat=3))


def edges(side):
    vertex_set = set(sites(side))
    result = []
    for start in sites(side):
        for direction in range(3):
            end = list(start)
            end[direction] += 1
            end = tuple(end)
            if end in vertex_set:
                result.append((start, end))
    return result


outer_sites = sites(2)
inner_site_set = set(sites(1))
outer_edges = edges(2)
active_edges = [
    edge for edge in outer_edges
    if edge[0] in inner_site_set or edge[1] in inner_site_set
]

source_ring = PolynomialRing(ZZ, ["x%s" % index for index in range(len(outer_edges))])
source_variables = source_ring.gens()
target_ring = PolynomialRing(ZZ, ["y%s" % index for index in range(len(active_edges))])
target_variables = target_ring.gens()
active_index = {edge: index for index, edge in enumerate(active_edges)}

images = [
    target_variables[active_index[edge]] if edge in active_index else target_ring.one()
    for edge in outer_edges
]
specialization = source_ring.hom(images, target_ring)


def broken_edges(configuration):
    return [
        edge for edge in outer_edges
        if configuration[edge[0]] != configuration[edge[1]]
    ]


def multivariate_partition_polynomial():
    result = source_ring.zero()
    for values in product([ZZ(-1), ZZ(1)], repeat=len(outer_sites)):
        configuration = dict(zip(outer_sites, values))
        monomial = source_ring.one()
        for edge in broken_edges(configuration):
            monomial *= source_variables[outer_edges.index(edge)]
        result += monomial
    return result


partition_polynomial = multivariate_partition_polynomial()
