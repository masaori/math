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


def is_order_convex(subset, event_set, order):
    return all(
        b in subset
        for a in subset
        for c in subset
        for b in event_set
        if (a, b) in order and (b, c) in order
    )


def is_down_set(subset, event_set, order):
    return all(b in subset for a in subset for b in event_set if (b, a) in order)


def is_up_set(subset, event_set, order):
    return all(b in subset for a in subset for b in event_set if (a, b) in order)


def incomparable(a, b, order):
    return (a, b) not in order and (b, a) not in order


def is_antichain(subset, order):
    return all(a == b or incomparable(a, b, order) for a in subset for b in subset)


def one_step_boundary(subset, event_set, dependency):
    outside = frozenset(event_set) - subset
    return frozenset(
        a for a in subset
        if any((a, b) in dependency or (b, a) in dependency for b in outside)
    )


def outgoing_boundary(subset, event_set, dependency):
    outside = frozenset(event_set) - subset
    return frozenset(a for a in subset if any((a, b) in dependency for b in outside))
