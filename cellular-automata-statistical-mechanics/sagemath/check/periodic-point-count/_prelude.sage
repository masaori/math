import os

_here = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_here, '..', 'minimal-preperiod-period', '_prelude.sage'))


def fixed_by(prefix, exponent):
    return prefix[exponent] == prefix[0]


def is_periodic(prefix, state_count):
    return any(fixed_by(prefix, exponent) for exponent in range(1, state_count + 1))


def fixed_point_count(mapping, exponent):
    return sum(
        1
        for initial in range(len(mapping))
        if iterate_map(mapping, initial, exponent)[exponent] == initial
    )


def minimal_period_counts(mapping):
    counts = {}
    for initial in range(len(mapping)):
        prefix = iterate_map(mapping, initial, 4 * len(mapping))
        mu, pi = direct_min_preperiod_period(prefix)
        if mu == 0:
            counts[pi] = counts.get(pi, 0) + 1
    return counts


def exhaustive_maps():
    from itertools import product
    for state_count in (1, 2, 4):
        for mapping in product(range(state_count), repeat=state_count):
            yield "all-map-M{}".format(state_count), mapping

    for stage_size in range(1, 4):
        configurations = elementary_configurations(stage_size)
        for rule in range(256):
            mapping = tuple(
                configurations.index(elementary_global_map(rule, configuration))
                for configuration in configurations
            )
            yield "eca-L{}-rule{}".format(stage_size, rule), mapping
