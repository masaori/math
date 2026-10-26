# 対象ラベル: claim_projected_cycle_distinct_edges
# 第一色の点の台への射影が一周期で単射であることを有限標本で調べる。
from itertools import product


def matchings(vertices):
    if not vertices:
        yield frozenset()
        return
    first = vertices[0]
    for partner in vertices[1:]:
        rest = tuple(v for v in vertices if v != first and v != partner)
        for tail in matchings(rest):
            yield tail | {frozenset((first, partner))}


def mate(matching, vertex):
    pair = next(pair for pair in matching if vertex in pair)
    return next(iter(pair - {vertex}))


cycles = 0
one_step = 0
for size in (2, 4, 6):
    vertices = tuple(range(size))
    reference = frozenset(frozenset((i, i + 1)) for i in range(0, size, 2))
    support = lambda i: i // 2
    reversal = lambda i: i + 1 if i % 2 == 0 else i - 1
    for sources in product((0, 1), repeat=size):
        for matching in matchings(vertices):
            pairs = tuple(matching)
            for choice in range(1 << len(pairs)):
                short = {pair for bit, pair in enumerate(pairs) if choice & (1 << bit)}
                if any(pair not in reference for pair in matching - short):
                    continue
                if any(len({sources[e] for e in pair}) != 1 for pair in short):
                    continue
                unseen = {e for pair in short for e in pair}
                while unseen:
                    start = min(unseen)
                    cycle = [start]
                    color = 'short'
                    while True:
                        current = cycle[-1]
                        successor = mate(matching if color == 'short' else reference, current)
                        if successor == start:
                            break
                        assert successor not in cycle
                        cycle.append(successor)
                        color = 'long' if color == 'short' else 'short'
                    assert len(cycle) % 2 == 0
                    first_color = [cycle[2 * r] for r in range(len(cycle) // 2)]
                    projected = [support(reversal(e)) for e in first_color]
                    assert len(projected) == len(set(projected))
                    for r, e in enumerate(first_color):
                        for s, f in enumerate(first_color):
                            if support(e) == support(f):
                                assert e == f or e == reversal(f)
                                assert e != reversal(f)
                                assert r == s
                    one_step += len(first_color) == 1
                    cycles += 1
                    unseen.difference_update(cycle)

assert cycles > 0 and one_step > 0
print(f'RESULT: PASS; {cycles} labelled cycles, including {one_step} one-step cycles')
