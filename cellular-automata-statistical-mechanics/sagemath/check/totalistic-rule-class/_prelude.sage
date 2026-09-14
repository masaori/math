# 有限な閉近傍舞台上の総和型局所規則族に共通する有限定義。
# 状態同士の加法は使わず、開近傍で値 1 を取る元の個数だけを ZZ で数える。

import itertools


STATES = (0, 1)


def closed_neighborhood_stages(cell_count):
    cells = tuple(range(cell_count))
    edges = tuple((u, v) for u in cells for v in cells if u < v)
    stages = []
    for edge_flags in itertools.product((False, True), repeat=len(edges)):
        neighborhoods = {v: {v} for v in cells}
        for edge, enabled in zip(edges, edge_flags):
            if enabled:
                u, v = edge
                neighborhoods[u].add(v)
                neighborhoods[v].add(u)
        stage = {v: frozenset(neighborhoods[v]) for v in cells}
        assert all(v in stage[v] for v in cells)
        assert all((u in stage[v]) == (v in stage[u]) for u in cells for v in cells)
        stages.append((cells, stage))
    return tuple(stages)


def local_inputs(neighborhood):
    ordered = tuple(sorted(neighborhood))
    return tuple(tuple(zip(ordered, values)) for values in itertools.product(STATES, repeat=len(ordered)))


def input_value(local_input, cell):
    return dict(local_input)[cell]


def local_signature(stage, cell, local_input):
    open_neighborhood = stage[cell].difference((cell,))
    one_count = ZZ(sum(input_value(local_input, neighbor) == 1 for neighbor in open_neighborhood))
    return (input_value(local_input, cell), one_count)


def local_input_entries(cells, stage):
    return tuple((cell, local_input) for cell in cells for local_input in local_inputs(stage[cell]))


def signature_domain(cell_count):
    return tuple((state, ZZ(count)) for state in STATES for count in range(cell_count + 1))


def all_binary_tables(domain):
    return tuple(dict(zip(domain, outputs)) for outputs in itertools.product(STATES, repeat=len(domain)))


def induced_family(cells, stage, totalistic_table):
    return {
        (cell, local_input): totalistic_table[local_signature(stage, cell, local_input)]
        for cell, local_input in local_input_entries(cells, stage)
    }


def pairwise_condition(cells, stage, family):
    entries = local_input_entries(cells, stage)
    return all(
        local_signature(stage, u, x) != local_signature(stage, v, y) or family[(u, x)] == family[(v, y)]
        for u, x in entries
        for v, y in entries
    )


def reconstruct_totalistic_table(cells, stage, family):
    table = {}
    entries = local_input_entries(cells, stage)
    for signature in signature_domain(len(cells)):
        realizations = tuple(entry for entry in entries if local_signature(stage, entry[0], entry[1]) == signature)
        table[signature] = family[realizations[0]] if realizations else 0
    return table


def family_matches_table(cells, stage, family, table):
    return all(
        family[(cell, local_input)] == table[local_signature(stage, cell, local_input)]
        for cell, local_input in local_input_entries(cells, stage)
    )

