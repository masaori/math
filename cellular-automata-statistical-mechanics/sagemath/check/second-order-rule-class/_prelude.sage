# 有限舞台上の二次の局所規則族に共通する有限定義。

import itertools

STATES = (0, 1)


def add(a, b):
    return (a + b) % 2


def inputs(neighborhood):
    ordered = tuple(sorted(neighborhood))
    return tuple(tuple(zip(ordered, values)) for values in itertools.product(STATES, repeat=len(ordered)))


def all_tables(domain):
    return tuple(dict(zip(domain, outputs)) for outputs in itertools.product(STATES, repeat=len(domain)))


def second_order_domain(neighborhood):
    return tuple((local_input, previous) for local_input in inputs(neighborhood) for previous in STATES)


def lift_base_table(neighborhood, base):
    return {
        (local_input, previous): add(base[local_input], previous)
        for local_input, previous in second_order_domain(neighborhood)
    }


def recovered_base_table(neighborhood, second_order_table):
    return {local_input: second_order_table[(local_input, 0)] for local_input in inputs(neighborhood)}


def is_second_order(neighborhood, table):
    return all(
        table[(local_input, previous)] == add(table[(local_input, 0)], previous)
        for local_input, previous in second_order_domain(neighborhood)
    )


def configurations(cells):
    return tuple(tuple(zip(cells, values)) for values in itertools.product(STATES, repeat=len(cells)))


def stages(cell_count):
    cells = tuple(range(cell_count))
    subsets = tuple(frozenset(cell for cell, present in zip(cells, flags) if present)
                    for flags in itertools.product((False, True), repeat=cell_count))
    return tuple((cells, dict(zip(cells, choices))) for choices in itertools.product(subsets, repeat=cell_count))


def pointwise_add(x, y):
    x_values = dict(x)
    y_values = dict(y)
    return tuple((cell, add(x_values[cell], y_values[cell])) for cell, _ in x)


def global_map(cells, stage, family, configuration):
    values = dict(configuration)
    return tuple(
        (cell, family[cell][tuple((neighbor, values[neighbor]) for neighbor in sorted(stage[cell]))])
        for cell in cells
    )


def evolution(cells, stage, family, previous, current):
    return (current, pointwise_add(global_map(cells, stage, family, current), previous))


def inverse_candidate(cells, stage, family, current, following):
    return (pointwise_add(following, global_map(cells, stage, family, current)), current)
