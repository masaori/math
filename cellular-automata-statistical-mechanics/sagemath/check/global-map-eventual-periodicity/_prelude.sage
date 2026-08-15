from itertools import product


def configurations(stage_size):
    return tuple(product((0, 1), repeat=stage_size))


def elementary_global_map(rule, configuration):
    stage_size = len(configuration)
    if stage_size == 0:
        return configuration
    return tuple(
        (rule >> (
            4 * configuration[(cell - 1) % stage_size]
            + 2 * configuration[cell]
            + configuration[(cell + 1) % stage_size]
        )) & 1
        for cell in range(stage_size)
    )


def orbit_prefix(rule, initial, last_exponent):
    result = [initial]
    for _ in range(last_exponent):
        result.append(elementary_global_map(rule, result[-1]))
    return tuple(result)


def exhaustive_instances():
    yield 0, 0, tuple(), orbit_prefix(0, tuple(), 4)
    for stage_size in range(1, 4):
        bound = 2 ** stage_size
        for rule in range(256):
            for initial in configurations(stage_size):
                yield stage_size, rule, initial, orbit_prefix(rule, initial, 4 * bound)


def collision_pairs(prefix, bound):
    return tuple(
        (left, right)
        for left in range(bound + 1)
        for right in range(left + 1, bound + 1)
        if prefix[left] == prefix[right]
    )
