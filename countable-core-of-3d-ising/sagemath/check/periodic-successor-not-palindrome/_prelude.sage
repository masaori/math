from itertools import product


def cycle_system(orbit_length, direction_count=1):
    points = tuple("v%s" % index for index in range(orbit_length))
    successors = {
        direction: {
            points[index]: points[(index + 1) % orbit_length]
            for index in range(orbit_length)
        }
        for direction in range(direction_count)
    }
    return points, successors


def edges_of(points, successors):
    return tuple(
        (start, direction, successors[direction][start])
        for direction in sorted(successors)
        for start in points
    )


def configurations(points):
    for values in product([ZZ(1), ZZ(-1)], repeat=len(points)):
        yield dict(zip(points, values))


def broken_edges(configuration, edges):
    return tuple(edge for edge in edges if configuration[edge[0]] != configuration[edge[2]])


def multiplicities(points, edges):
    result = {}
    for configuration in configurations(points):
        count = ZZ(len(broken_edges(configuration, edges)))
        result[count] = result.get(count, ZZ(0)) + ZZ(1)
    return result
