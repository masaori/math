from itertools import product


def configurations(cell_count):
    return tuple(product((ZZ(0), ZZ(1)), repeat=cell_count))


def observation_tables(configuration_set, value_range):
    return tuple(product(value_range, repeat=len(configuration_set)))


def multiplicity(configuration_set, observation, value):
    return ZZ(sum(1 for index in range(len(configuration_set)) if observation[index] == value))


def shell_pairs(first_set, second_set, first_observation, second_observation, total):
    return tuple(
        (first_index, second_index)
        for first_index in range(len(first_set))
        for second_index in range(len(second_set))
        if first_observation[first_index] + second_observation[second_index] == total
    )


def sample_systems():
    values = tuple(ZZ(value) for value in range(-1, 2))
    totals = tuple(ZZ(total) for total in range(-2, 3))
    for first_cell_count in range(0, 3):
        first_set = configurations(first_cell_count)
        for second_cell_count in range(0, 3):
            second_set = configurations(second_cell_count)
            for first_observation in observation_tables(first_set, values):
                for second_observation in observation_tables(second_set, values):
                    for total in totals:
                        yield (
                            first_set,
                            second_set,
                            first_observation,
                            second_observation,
                            total,
                        )
