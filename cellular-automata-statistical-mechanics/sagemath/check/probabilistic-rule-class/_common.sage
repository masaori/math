from itertools import product

A = (ZZ(0), ZZ(1))


def configurations(cell_count):
    return tuple(product(A, repeat=cell_count))


def local_tables(cell_count, allowed_weights):
    inputs = configurations(cell_count)
    return tuple(dict(zip(inputs, values)) for values in product(allowed_weights, repeat=len(inputs)))


def rule_families(cell_count, allowed_weights):
    tables = local_tables(cell_count, allowed_weights)
    if cell_count == 0:
        return ({},)
    return tuple(dict(zip(range(cell_count), table_values)) for table_values in product(tables, repeat=cell_count))


def local_output_weight(probability_of_one, output):
    assert output in A
    return probability_of_one if output == 1 else 1 - probability_of_one


def global_transition_weight(family, source, target):
    weight = QQ(1)
    for cell in range(len(source)):
        weight *= local_output_weight(family[cell][source], target[cell])
    return weight


def transition_matrix(family, cell_count):
    states = configurations(cell_count)
    return {
        source: {target: global_transition_weight(family, source, target) for target in states}
        for source in states
    }


def identity_transition(cell_count):
    states = configurations(cell_count)
    return {
        source: {target: QQ(1) if source == target else QQ(0) for target in states}
        for source in states
    }


def compose_transitions(left, right):
    states = tuple(left)
    return {
        source: {
            target: sum((left[source][middle] * right[middle][target] for middle in states), QQ(0))
            for target in states
        }
        for source in states
    }


def is_probabilistic_table(table):
    return all(value in QQ and QQ(0) <= value <= QQ(1) for value in table.values())


def is_zero_one_family(family):
    return all(value in (QQ(0), QQ(1)) for table in family.values() for value in table.values())


def recover_deterministic_family(family):
    assert is_zero_one_family(family)
    return {cell: {local_input: ZZ(value) for local_input, value in table.items()} for cell, table in family.items()}


def deterministic_global_update(family, source):
    return tuple(family[cell][source] for cell in range(len(source)))
