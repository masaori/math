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


def reachability(event_set, dependency):
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
    return reachability(event_set, dependency) | frozenset((a, a) for a in event_set)


def order_interval(a, b, event_set, order):
    return frozenset(c for c in event_set if (a, c) in order and (c, b) in order)


def covering_relation(event_set, closure):
    return frozenset(
        (a, b)
        for a, b in closure
        if not any((a, c) in closure and (c, b) in closure for c in event_set)
    )
