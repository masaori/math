import os
from itertools import product

load(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                  '..', 'probabilistic-rule-class', '_common.sage'))


def sample_probabilistic_families():
    allowed_weights = (QQ(0), QQ(1) / QQ(2), QQ(1))
    yield from rule_families(0, allowed_weights)
    yield from rule_families(1, allowed_weights)
    yield {
        0: {state: QQ(1) / QQ(2) for state in configurations(2)},
        1: {state: QQ(1) / QQ(2) for state in configurations(2)},
    }
    yield {
        0: {state: QQ(state[0]) for state in configurations(2)},
        1: {state: QQ(state[1]) for state in configurations(2)},
    }
    yield {
        0: {state: QQ(state[1]) for state in configurations(2)},
        1: {state: QQ(1 - state[0]) for state in configurations(2)},
    }


def deterministic_families(cell_count):
    states = configurations(cell_count)
    tables = tuple(dict(zip(states, values)) for values in product(A, repeat=len(states)))
    if cell_count == 0:
        yield {}
        return
    for chosen_tables in product(tables, repeat=cell_count):
        yield dict(zip(range(cell_count), chosen_tables))


def deterministic_weight_family(family):
    return {
        cell: {local_input: QQ(value) for local_input, value in table.items()}
        for cell, table in family.items()
    }


def transfer_matrix_from_kernel(kernel):
    states = tuple(kernel)
    return {
        source: {target: QQ(kernel[source][target]) for target in states}
        for source in states
    }


def transfer_power(matrix, exponent):
    states = tuple(matrix)
    current = {
        source: {target: QQ(1) if source == target else QQ(0) for target in states}
        for source in states
    }
    for _step in range(exponent):
        current = compose_transitions(current, matrix)
    return current


def iterate_configuration(family, source, exponent):
    value = source
    for _step in range(exponent):
        value = deterministic_global_update(family, value)
    return value


def transfer_trace(matrix, exponent):
    power = transfer_power(matrix, exponent)
    return sum((power[state][state] for state in matrix), QQ(0))


def fixed_point_count(family, exponent):
    states = configurations(len(family))
    return ZZ(sum(1 for state in states if iterate_configuration(family, state, exponent) == state))
