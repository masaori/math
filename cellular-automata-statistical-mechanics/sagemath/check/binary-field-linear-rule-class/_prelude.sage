# 有限舞台上で二元体線形な局所規則族に共通する有限定義。

import itertools

STATES = (0, 1)


def add(a, b):
    return (a + b) % 2


def multiply(a, b):
    return (a * b) % 2


def inputs(neighborhood):
    ordered = tuple(sorted(neighborhood))
    return tuple(tuple(zip(ordered, values)) for values in itertools.product(STATES, repeat=len(ordered)))


def pointwise_add(x, y):
    return tuple((cell, add(dict(x)[cell], dict(y)[cell])) for cell, _ in x)


def scalar_multiply(a, x):
    return tuple((cell, multiply(a, value)) for cell, value in x)


def zero_input(neighborhood):
    return tuple((cell, 0) for cell in sorted(neighborhood))


def linear_table(neighborhood, coefficients):
    ordered = tuple(sorted(neighborhood))
    return {
        x: sum(coefficient * dict(x)[cell] for cell, coefficient in zip(ordered, coefficients)) % 2
        for x in inputs(neighborhood)
    }


def is_linear(neighborhood, table):
    local_inputs = inputs(neighborhood)
    zero_ok = table[zero_input(neighborhood)] == 0
    addition_ok = all(table[pointwise_add(x, y)] == add(table[x], table[y]) for x in local_inputs for y in local_inputs)
    scalar_ok = all(table[scalar_multiply(a, x)] == multiply(a, table[x]) for a in STATES for x in local_inputs)
    return zero_ok and addition_ok and scalar_ok


def stages(cell_count):
    cells = tuple(range(cell_count))
    subsets = tuple(frozenset(cell for cell, present in zip(cells, flags) if present)
                    for flags in itertools.product((False, True), repeat=cell_count))
    return tuple((cells, dict(zip(cells, choices))) for choices in itertools.product(subsets, repeat=cell_count))


def configurations(cells):
    return tuple(tuple(zip(cells, values)) for values in itertools.product(STATES, repeat=len(cells)))


def global_map(cells, stage, family, configuration):
    values = dict(configuration)
    return tuple((cell, family[cell][tuple((w, values[w]) for w in sorted(stage[cell]))]) for cell in cells)
