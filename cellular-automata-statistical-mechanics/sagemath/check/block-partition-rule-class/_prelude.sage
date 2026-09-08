# 有限舞台上のブロック（分割）型更新に共通する有限定義。
# 状態集合は二元集合としてだけ使い、有限集合・有限写像表だけを列挙する。

import itertools


STATES = (0, 1)


def configurations(cells):
    return tuple(itertools.product(STATES, repeat=len(cells)))


def nonempty_subsets(cells):
    return tuple(
        tuple(cell for cell, chosen in zip(cells, flags) if chosen)
        for flags in itertools.product((False, True), repeat=len(cells))
        if any(flags)
    )


def is_block_partition(cells, candidate):
    if len(set(candidate)) != len(candidate):
        return False
    if any(len(block) == 0 for block in candidate):
        return False
    return all(sum(cell in block for block in candidate) == 1 for cell in cells)


def block_partitions(cells):
    candidates = []
    subsets = nonempty_subsets(cells)
    for flags in itertools.product((False, True), repeat=len(subsets)):
        candidate = tuple(subset for subset, chosen in zip(subsets, flags) if chosen)
        if is_block_partition(cells, candidate):
            candidates.append(candidate)
    return tuple(candidates)


def membership_block(partition, cell):
    matches = tuple(block for block in partition if cell in block)
    assert len(matches) == 1
    return matches[0]


def restrict_configuration(configuration, block):
    return tuple(configuration[cell] for cell in block)


def extend_by_zero(cells, block, local_configuration):
    local_values = dict(zip(block, local_configuration))
    return tuple(local_values[cell] if cell in local_values else 0 for cell in cells)


def local_maps(block):
    local_inputs = configurations(block)
    local_outputs = configurations(block)
    return tuple(
        dict(zip(local_inputs, output_table))
        for output_table in itertools.product(local_outputs, repeat=len(local_inputs))
    )


def block_rule_families(partition):
    choices = tuple(local_maps(block) for block in partition)
    return tuple(dict(zip(partition, selected)) for selected in itertools.product(*choices))


def phase_update(cells, partition, family, configuration):
    output = [None] * len(cells)
    for block in partition:
        local_input = restrict_configuration(configuration, block)
        local_output = family[block][local_input]
        for cell, value in zip(block, local_output):
            output[cell] = value
    assert all(value in STATES for value in output)
    return tuple(output)


def global_map_from_family(cells, partition, family):
    return {
        configuration: phase_update(cells, partition, family, configuration)
        for configuration in configurations(cells)
    }


def block_dependence_condition(cells, partition, global_map):
    inputs = configurations(cells)
    return all(
        restrict_configuration(x, block) != restrict_configuration(y, block)
        or restrict_configuration(global_map[x], block) == restrict_configuration(global_map[y], block)
        for block in partition
        for x in inputs
        for y in inputs
    )


def reconstruct_family(cells, partition, global_map):
    family = {}
    for block in partition:
        family[block] = {}
        for local_configuration in configurations(block):
            extended = extend_by_zero(cells, block, local_configuration)
            family[block][local_configuration] = restrict_configuration(global_map[extended], block)
    return family


def all_global_maps(cells):
    inputs = configurations(cells)
    outputs = configurations(cells)
    return tuple(dict(zip(inputs, output_table)) for output_table in itertools.product(outputs, repeat=len(inputs)))
