# 対象ラベル: theorem_root_minus_one_characterizes_odd_incident_edge_count
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

from itertools import product


def check_equivalence(vertex_count, edges):
    polynomial_ring = PolynomialRing(ZZ, "x")
    x = polynomial_ring.gen()
    configurations = tuple(product((0, 1), repeat=vertex_count))

    incident_edge_counts = tuple(
        ZZ(sum(1 for source, target in edges if source == vertex or target == vertex))
        for vertex in range(vertex_count)
    )
    has_odd_incident_edge_count = any(count % 2 == 1 for count in incident_edge_counts)

    partition_polynomial = sum(
        (
            x ** sum(
                1
                for source, target in edges
                if configuration[source] != configuration[target]
            )
            for configuration in configurations
        ),
        polynomial_ring.zero(),
    )
    evaluation_at_minus_one = ZZ(partition_polynomial(-1))

    assert (evaluation_at_minus_one == 0) == has_odd_incident_edge_count
    if has_odd_incident_edge_count:
        assert evaluation_at_minus_one == 0
    else:
        assert all(count % 2 == 0 for count in incident_edge_counts)
        assert evaluation_at_minus_one == ZZ(2) ** vertex_count


examples = (
    (1, ()),
    (2, ((0, 1),)),
    (2, ((0, 1), (0, 1))),
    (2, ((0, 1), (0, 1), (0, 1))),
    (3, ((0, 1), (1, 2))),
    (3, ((0, 1), (1, 2), (2, 0))),
    (4, ((0, 1), (1, 2), (2, 3), (3, 0))),
    (4, ((0, 1), (0, 2), (0, 3), (1, 2), (2, 3))),
)

for example in examples:
    check_equivalence(*example)

print("RESULT: PASS — Z_G(-1) vanishes exactly when an odd incident-edge count exists")
