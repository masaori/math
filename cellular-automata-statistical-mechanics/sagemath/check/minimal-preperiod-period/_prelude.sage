from itertools import product


def iterate_map(mapping, initial, last_exponent):
    values = [initial]
    for _ in range(last_exponent):
        values.append(mapping[values[-1]])
    return tuple(values)


def all_finite_map_instances():
    """全自己写像を列挙できる配位数 1, 2, 4 の場合を返す。"""
    for state_count in (1, 2, 4):
        for mapping in product(range(state_count), repeat=state_count):
            for initial in range(state_count):
                yield (
                    "all-map-M{}".format(state_count),
                    state_count,
                    iterate_map(mapping, initial, 4 * state_count),
                )


def elementary_configurations(stage_size):
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


def elementary_orbit(rule, initial, last_exponent):
    values = [initial]
    for _ in range(last_exponent):
        values.append(elementary_global_map(rule, values[-1]))
    return tuple(values)


def elementary_ca_instances():
    """セル数 0--3 の巡回舞台上の初等 CA を返す。"""
    yield "eca-L0-rule0", 1, elementary_orbit(0, tuple(), 4)
    for stage_size in range(1, 4):
        state_count = 2 ** stage_size
        for rule in range(256):
            for initial in elementary_configurations(stage_size):
                yield (
                    "eca-L{}-rule{}".format(stage_size, rule),
                    state_count,
                    elementary_orbit(rule, initial, 4 * state_count),
                )


def exhaustive_instances():
    yield from all_finite_map_instances()
    yield from elementary_ca_instances()


def direct_min_preperiod_period(prefix):
    """最初の再訪から、独立に最小前周期と最小周期を得る。"""
    first_visit = {}
    for exponent, value in enumerate(prefix):
        if value in first_visit:
            mu = first_visit[value]
            return mu, exponent - mu
        first_visit[value] = exponent
    raise AssertionError("prefix did not contain a repeated state")


def periodicity_pair_in_window(prefix, preperiod, period, state_count):
    if period < 1:
        return False
    return all(
        prefix[exponent + period] == prefix[exponent]
        for exponent in range(preperiod, preperiod + 2 * state_count + 1)
    )


def scanned_min_preperiod_period(prefix, state_count):
    candidates = tuple(
        (preperiod, period)
        for preperiod in range(state_count + 1)
        for period in range(1, state_count - preperiod + 1)
        if prefix[preperiod + period] == prefix[preperiod]
    )
    assert candidates
    mu = min(preperiod for preperiod, _ in candidates)
    pi = min(period for preperiod, period in candidates if preperiod == mu)
    return mu, pi, candidates
