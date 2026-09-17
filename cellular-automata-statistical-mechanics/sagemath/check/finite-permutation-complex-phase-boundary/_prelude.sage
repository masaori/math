from itertools import permutations


def identity_table(size):
    return tuple(range(size))


def compose(left, right):
    return tuple(left[right[source]] for source in range(len(right)))


def table_power(table, exponent):
    result = identity_table(len(table))
    for _ in range(ZZ(exponent)):
        result = compose(table, result)
    return result


def permutation_matrix_from_table(table, ring=ZZ):
    size = len(table)
    return matrix(
        ring,
        size,
        size,
        lambda target, source: ring.one() if target == table[source] else ring.zero(),
    )


def cycle_partition(table):
    unseen = set(range(len(table)))
    cycles = []
    while unseen:
        base = min(unseen)
        cycle = []
        current = base
        while current not in cycle:
            cycle.append(current)
            unseen.remove(current)
            current = table[current]
        assert current == base
        cycles.append(tuple(cycle))
    return tuple(cycles)


def permutation_order(table):
    return lcm([ZZ(len(cycle)) for cycle in cycle_partition(table)])


def exact_phase(cycle_length, code):
    if cycle_length == 1:
        return QQ, QQ.one()
    field = CyclotomicField(cycle_length)
    return field, field.zeta(cycle_length) ** ZZ(code)

