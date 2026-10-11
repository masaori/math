def oso_inverse(sigma):
    return tuple(sigma.index(j) for j in range(len(sigma)))

def oso_orbit(sigma, start):
    support = set()
    for direction in (sigma, oso_inverse(sigma)):
        reached = set()
        point = start
        while point not in reached:
            reached.add(point)
            point = direction[point]
        support.update(reached)
    return frozenset(support)

def oso_odd_points(sigma):
    return frozenset(j for j in range(len(sigma)) if len(oso_orbit(sigma, j)) % 2 == 1)

def oso_selected(sigma, rank):
    points = oso_odd_points(sigma)
    if not points:
        return None
    return oso_orbit(sigma, min(points, key=lambda j: rank[j]))

def oso_reverse(sigma, subset):
    inverse = oso_inverse(sigma)
    return tuple(inverse[j] if j in subset else sigma[j] for j in range(len(sigma)))
