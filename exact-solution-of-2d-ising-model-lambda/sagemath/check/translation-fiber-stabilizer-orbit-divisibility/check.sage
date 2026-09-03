"""平行移動で固定されるファイバーの辺集合に課される可除条件を検査する。

対象: claim_selection_even_subgraph_action_character,
      claim_selection_sum_character_evaluation。

一辺 L のトーラスの非零平行移動 (a,b) は、水平辺と垂直辺の各集合へ
自由に作用する。各基底辺の軌道長が (a,b) の Z/LZ × Z/LZ における位数
と一致することを L=2,...,8 で全数検査する。従って (D,E) を固定するなら
D と E はその軌道の和であり、|D| と |E| はともに位数で割り切れる。
"""

from math import gcd, lcm


def translation_order(side, shift):
    a, b = shift
    return lcm(side // gcd(side, a), side // gcd(side, b))


def translate_edge(side, shift, edge):
    kind, i, j = edge
    a, b = shift
    return (kind, (i + a) % side, (j + b) % side)


expected_order_counts = {
    2: {2: 3},
    3: {3: 8},
    4: {2: 3, 4: 12},
    5: {5: 24},
    6: {2: 3, 3: 8, 6: 24},
    7: {7: 48},
    8: {2: 3, 4: 12, 8: 48},
}

for side in range(2, 9):
    edges = {
        (kind, i, j)
        for kind in ("h", "v")
        for i in range(side)
        for j in range(side)
    }
    order_counts = {}
    for a in range(side):
        for b in range(side):
            if (a, b) == (0, 0):
                continue
            shift = (a, b)
            order = translation_order(side, shift)
            order_counts[order] = order_counts.get(order, 0) + 1

            unseen = set(edges)
            orbits = []
            while unseen:
                first = min(unseen)
                orbit = {
                    translate_edge(side, (k * a, k * b), first)
                    for k in range(order)
                }
                assert len(orbit) == order
                assert {
                    translate_edge(side, shift, edge) for edge in orbit
                } == orbit
                orbits.append(frozenset(orbit))
                unseen -= orbit

            assert len(orbits) == 2 * side * side // order
            assert set().union(*orbits) == edges
            assert sum(len(orbit) for orbit in orbits) == len(edges)

            # 軌道の任意の和は固定され、元数は order の倍数になる。
            sample = set().union(*orbits[::2]) if orbits[::2] else set()
            assert {
                translate_edge(side, shift, edge) for edge in sample
            } == sample
            assert len(sample) % order == 0

    assert order_counts == expected_order_counts[side]
    print(f"L={side}: translation orders {order_counts}")

print("PASS: translation-fiber-stabilizer-orbit-divisibility")
