from itertools import product


def powerset(items):
    items = tuple(items)
    return tuple(
        frozenset(item for item, selected in zip(items, mask) if selected)
        for mask in product((False, True), repeat=len(items))
    )


def support_families(stage_size):
    cells = tuple(range(stage_size))
    subsets = powerset(cells)
    for choices in product(subsets, repeat=stage_size):
        yield tuple(choices)


def exhaustive_instances():
    # |V| <= 3 の全 support 族と 0 <= tau <= 4 を検査する。
    for stage_size in range(4):
        for supports in support_families(stage_size):
            for tau in range(5):
                yield tau, stage_size, supports


def dependency_relation(tau, supports):
    return frozenset(
        ((time, source), (time + 1, target))
        for time in range(tau)
        for target, target_support in enumerate(supports)
        for source in target_support
    )


def all_nonempty_paths(tau, supports):
    relation = dependency_relation(tau, supports)
    outgoing = {}
    for source, target in relation:
        outgoing.setdefault(source, []).append(target)
    paths = []

    def visit(path):
        for target in outgoing.get(path[-1], ()):
            extended = path + (target,)
            paths.append(extended)
            visit(extended)

    for time in range(tau + 1):
        for cell in range(len(supports)):
            visit(((time, cell),))
    return tuple(paths)


def propagation_ball(supports, depth, target):
    assert depth >= 1
    if depth == 1:
        return frozenset(supports[target])
    return frozenset(
        source
        for cell in supports[target]
        for source in propagation_ball(supports, depth - 1, cell)
    )


def reachability(tau, supports):
    return frozenset((path[0], path[-1]) for path in all_nonempty_paths(tau, supports))


def dependency_sources(tau, supports, target_event):
    return frozenset(source for source, target in reachability(tau, supports) if target == target_event)


def boundary_union(supports, time, target):
    return frozenset(
        (time - depth, source)
        for depth in range(1, time + 1)
        for source in propagation_ball(supports, depth, target)
    )
