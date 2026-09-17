from itertools import permutations, product


def self_maps(size):
    return tuple(product(range(size), repeat=size))


def permutation_tables(size):
    return tuple(permutations(range(size)))


def compose(left, right):
    return tuple(left[right[index]] for index in range(len(right)))


def identity_table(size):
    return tuple(range(size))


def inverse_permutation(permutation):
    inverse = [None] * len(permutation)
    for source, target in enumerate(permutation):
        inverse[target] = source
    return tuple(inverse)


def table_power(table, exponent):
    result = identity_table(len(table))
    base = table
    remaining = ZZ(exponent)
    while remaining > 0:
        if remaining % 2 == 1:
            result = compose(base, result)
        base = compose(base, base)
        remaining //= 2
    return result


def commuting_symmetries(global_map):
    return tuple(
        symmetry
        for symmetry in permutation_tables(len(global_map))
        if compose(symmetry, global_map) == compose(global_map, symmetry)
    )


def conserved_observables(global_map, values=(-1, 0, 1)):
    return tuple(
        observable
        for observable in product(tuple(ZZ(value) for value in values), repeat=len(global_map))
        if tuple(observable[global_map[index]] for index in range(len(global_map))) == observable
    )


def observable_add(left, right):
    return tuple(left[index] + right[index] for index in range(len(left)))


def observable_negate(observable):
    return tuple(-value for value in observable)


def is_conserved(global_map, observable):
    return all(observable[global_map[index]] == observable[index] for index in range(len(global_map)))


def pullback(symmetry, observable):
    inverse = inverse_permutation(symmetry)
    return tuple(observable[inverse[index]] for index in range(len(observable)))
