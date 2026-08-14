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
    # |V| <= 2, tau <= 3 の全ての隣接時刻関係に加え、|V|=3, tau=1 を全数検査する。
    for stage_size in range(3):
        for tau in range(4):
            event_set = events(tau, stage_size)
            for relation in powerset(adjacent_edges(tau, stage_size)):
                yield tau, stage_size, event_set, relation
    for relation in powerset(adjacent_edges(1, 3)):
        yield 1, 3, events(1, 3), relation


def paths_from(start, relation):
    outgoing = {}
    for source, target in relation:
        outgoing.setdefault(source, []).append(target)

    paths = []

    def visit(path):
        for target in outgoing.get(path[-1], ()):
            extended = path + (target,)
            paths.append(extended)
            visit(extended)

    visit((start,))
    return tuple(paths)


def all_nonempty_paths(event_set, relation):
    return tuple(path for start in event_set for path in paths_from(start, relation))


def reachability(event_set, relation):
    return frozenset((path[0], path[-1]) for path in all_nonempty_paths(event_set, relation))


def is_transitive(relation):
    return all(
        (a, c) in relation
        for a, b in relation
        for b_prime, c in relation
        if b == b_prime
    )


def reflexive_closure(event_set, relation):
    return frozenset(relation) | frozenset((event, event) for event in event_set)


def is_partial_order(event_set, relation):
    reflexive = all((a, a) in relation for a in event_set)
    antisymmetric = all(a == b for a, b in relation if (b, a) in relation)
    return reflexive and antisymmetric and is_transitive(relation)
