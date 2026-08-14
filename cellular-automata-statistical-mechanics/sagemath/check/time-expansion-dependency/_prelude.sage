from itertools import combinations, product


def subsets(items):
    for size in range(len(items) + 1):
        yield from combinations(items, size)


def configurations(size):
    return tuple(product((0, 1), repeat=size))


def flip(x, position):
    y = list(x)
    y[position] = 1 - y[position]
    return tuple(y)


def restrict_input(y, subset):
    return tuple(y[position] for position in subset)


def essentially_depends(table, xs, position):
    return any(
        table[x] != table[x_prime]
        and all(
            x[other] == x_prime[other]
            for other in range(len(x))
            if other != position
        )
        for x in xs
        for x_prime in xs
    )


def support(table, xs):
    if not xs:
        return set()
    return {
        position
        for position in range(len(xs[0]))
        if essentially_depends(table, xs, position)
    }


def scan_support_by_flips(table, xs):
    found = set()
    comparisons = 0
    if not xs:
        return found, comparisons
    for position in range(len(xs[0])):
        for x in xs:
            comparisons += 1
            if table[x] != table[flip(x, position)]:
                found.add(position)
                break
    return found, comparisons
