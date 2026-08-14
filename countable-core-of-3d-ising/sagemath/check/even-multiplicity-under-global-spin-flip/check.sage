# 全スピン反転による多重度の偶数性を、本文の証明順に検証する。
# 有限集合と ZZ の厳密計算だけを使う。

from itertools import product


def box_sites(box_side):
    return [
        (ZZ(a), ZZ(b), ZZ(c))
        for a in range(box_side)
        for b in range(box_side)
        for c in range(box_side)
    ]


def inner_edges(box_side):
    sites = set(box_sites(box_side))
    edges = []
    for endpoint_zero in sorted(sites):
        for direction in range(3):
            endpoint_one = list(endpoint_zero)
            endpoint_one[direction] += ZZ(1)
            endpoint_one = tuple(endpoint_one)
            if endpoint_one in sites:
                edges.append((endpoint_zero, endpoint_one))
    return edges


def all_configurations(box_side):
    sites = box_sites(box_side)
    for values in product([ZZ(1), ZZ(-1)], repeat=len(sites)):
        yield tuple(values)


def global_spin_flip(configuration):
    return tuple(-value for value in configuration)


def broken_edge_set(configuration, sites, edges):
    value_at = dict(zip(sites, configuration))
    return frozenset(
        edge for edge in edges if value_at[edge[0]] != value_at[edge[1]]
    )


def check_even_multiplicity(box_side):
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    configurations = list(all_configurations(box_side))

    # 全スピン反転を二回適用すると元へ戻る。
    for configuration in configurations:
        assert global_spin_flip(global_spin_flip(configuration)) == configuration

    # 両端をともに反転しても、破れ辺集合と破れ数は変わらない。
    for configuration in configurations:
        flipped = global_spin_flip(configuration)
        broken = broken_edge_set(configuration, sites, edges)
        flipped_broken = broken_edge_set(flipped, sites, edges)
        assert flipped_broken == broken
        assert ZZ(len(flipped_broken)) == ZZ(len(broken))

    # 原点の値が変わるので不動点は無い。
    origin_index = sites.index((ZZ(0), ZZ(0), ZZ(0)))
    for configuration in configurations:
        flipped = global_spin_flip(configuration)
        assert flipped[origin_index] != configuration[origin_index]
        assert flipped != configuration

    edge_count = ZZ(len(edges))
    level_sets = {ZZ(m): set() for m in range(edge_count + 1)}
    for configuration in configurations:
        broken_count = ZZ(len(broken_edge_set(configuration, sites, edges)))
        level_sets[broken_count].add(configuration)

    for broken_count, level_set in level_sets.items():
        # 各水準集合は全スピン反転で閉じ、軌道は相異なる二元集合である。
        unseen = set(level_set)
        orbits = []
        while unseen:
            configuration = unseen.pop()
            flipped = global_spin_flip(configuration)
            assert flipped in level_set
            assert flipped != configuration
            assert flipped in unseen
            unseen.remove(flipped)
            orbits.append(frozenset([configuration, flipped]))
        assert all(len(orbit) == 2 for orbit in orbits)
        assert len(set(orbits)) == len(orbits)
        assert set().union(*orbits) == level_set

        # Omega_L(m) = 2 k_m, k_m は自然数。
        multiplicity = ZZ(len(level_set))
        orbit_count = ZZ(len(orbits))
        assert multiplicity == ZZ(2) * orbit_count
        assert multiplicity % ZZ(2) == ZZ(0)

    print(
        "claim_even_multiplicity: L=%d の全 %d 配位・全 %d 水準で PASS"
        % (box_side, len(configurations), edge_count + 1)
    )


check_even_multiplicity(1)
check_even_multiplicity(2)
print("RESULT: PASS")
