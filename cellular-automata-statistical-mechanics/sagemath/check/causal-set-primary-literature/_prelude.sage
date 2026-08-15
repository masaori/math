from itertools import combinations


def powerset(items):
    items = tuple(items)
    for size in range(len(items) + 1):
        for subset in combinations(items, size):
            yield frozenset(subset)


def events(tau, stage_size):
    return tuple((time, cell) for time in range(tau + 1) for cell in range(stage_size))


def adjacent_edges(tau, stage_size):
    return tuple(
        ((time, source), (time + 1, target))
        for time in range(tau)
        for source in range(stage_size)
        for target in range(stage_size)
    )


def exhaustive_instances():
    for stage_size in range(3):
        for tau in range(3):
            event_set = events(tau, stage_size)
            for dependency in powerset(adjacent_edges(tau, stage_size)):
                yield tau, stage_size, event_set, dependency


def reachability(dependency):
    closure = set(dependency)
    changed = True
    while changed:
        changed = False
        additions = {
            (a, c)
            for a, b in closure
            for b_prime, c in closure
            if b == b_prime and (a, c) not in closure
        }
        if additions:
            closure.update(additions)
            changed = True
    return frozenset(closure)


def reflexive_order(event_set, dependency):
    return reachability(dependency) | frozenset((a, a) for a in event_set)


def primary_literature_interval(x, y, event_set, order):
    return frozenset(z for z in event_set if (x, z) in order and (z, y) in order)


def previous_chapter_interval(a, b, event_set, order):
    result = set()
    for c in event_set:
        if (a, c) in order:
            if (c, b) in order:
                result.add(c)
    return frozenset(result)
