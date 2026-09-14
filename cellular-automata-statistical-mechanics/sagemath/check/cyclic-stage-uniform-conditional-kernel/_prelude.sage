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


def window_image(stage, radius):
    return frozenset(embedding(stage, radius).values())


def outside_cells(stage, radius):
    image = window_image(stage, radius)
    return tuple(cell for cell in stage_cells(stage) if cell not in image)


def outside_signature(configuration, stage, radius):
    return tuple(configuration[cell] for cell in outside_cells(stage, radius))


def outside_agrees(source, target, stage, radius):
    return outside_signature(source, stage, radius) == outside_signature(target, stage, radius)


def conditional_weight(source, target, stage, radius):
    if outside_agrees(source, target, stage, radius):
        return QQ(1) / (ZZ(2) ** ZZ(2 * radius + 1))
    return QQ(0)


def uniform_weight(stage):
    return QQ(1) / (ZZ(2) ** ZZ(stage_length(stage)))
