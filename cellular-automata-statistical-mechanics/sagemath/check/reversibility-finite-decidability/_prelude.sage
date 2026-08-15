import os

_here = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_here, '..', 'periodic-point-count', '_prelude.sage'))


def image_of(mapping):
    """像 Im(F) = { F y : y ∈ A^V } を有限集合として作る。"""
    return frozenset(mapping)


def is_injective_by_definition(mapping):
    """定義どおり: 全ての y, y' について F y = F y' ⇒ y = y'。"""
    state_count = len(mapping)
    return all(
        (mapping[y] != mapping[y_prime]) or (y == y_prime)
        for y in range(state_count)
        for y_prime in range(state_count)
    )


def is_surjective_by_definition(mapping):
    """定義どおり: Im(F) = A^V。"""
    return image_of(mapping) == frozenset(range(len(mapping)))


def min_preperiod_of(mapping, initial):
    prefix = iterate_map(mapping, initial, 4 * len(mapping))
    mu, _ = direct_min_preperiod_period(prefix)
    return mu


def exhaustive_maps_with_larger_stage():
    """periodic-point-count の範囲に、セル数 4 の巡回舞台上の全 256 初等 CA 規則を加える。"""
    yield from exhaustive_maps()
    configurations = elementary_configurations(4)
    for rule in range(256):
        mapping = tuple(
            configurations.index(elementary_global_map(rule, configuration))
            for configuration in configurations
        )
        yield "eca-L4-rule{}".format(rule), mapping
