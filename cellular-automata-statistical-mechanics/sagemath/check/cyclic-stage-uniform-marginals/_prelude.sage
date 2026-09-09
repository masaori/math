import itertools


A = (0, 1)


def window(radius):
    return tuple(range(-radius, radius + 1))


def stage_length(stage):
    return 2 * stage + 1


def stage_cells(stage):
    return tuple(range(stage_length(stage)))


def configurations(cells):
    return tuple(itertools.product(A, repeat=len(cells)))


def embedding(stage, radius):
    length = stage_length(stage)
    return {offset: offset % length for offset in window(radius)}


def restrict_to_window(configuration, stage, radius):
    injection = embedding(stage, radius)
    return tuple(configuration[injection[offset]] for offset in window(radius))


def uniform_weight(stage):
    return QQ(1) / (ZZ(2) ** ZZ(stage_length(stage)))


def marginal_table(stage, radius):
    table = {observation: QQ(0) for observation in configurations(window(radius))}
    weight = uniform_weight(stage)
    for configuration in configurations(stage_cells(stage)):
        table[restrict_to_window(configuration, stage, radius)] += weight
    return table


def marginal_weight(stage, radius, observation):
    return marginal_table(stage, radius)[observation]
