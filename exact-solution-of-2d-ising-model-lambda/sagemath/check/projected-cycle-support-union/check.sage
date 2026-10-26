# 対象ラベル: claim_projected_cycle_support_union
# 有限の標識付き完全マッチングで、閉歩道の台の合併と補辺を比較する。
from itertools import combinations


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


tested = 0
cycles = 0
for size in (2, 4, 6):
    vertices = tuple(range(size))
    reference = frozenset(frozenset((i, i + 1)) for i in range(0, size, 2))
    supports = set(range(size // 2))
    for matching in matchings(vertices):
        pairs = tuple(matching)
        for count in range(len(pairs) + 1):
            for choice in combinations(pairs, count):
                short = frozenset(choice)
                long = matching - short
                if any(pair not in reference for pair in long):
                    continue
                complement = supports - {next(iter(pair)) // 2 for pair in long}
                active = {vertex for pair in short for vertex in pair}
                assert active == {vertex for vertex in vertices if vertex // 2 in complement}
                unseen = set(active)
                union = set()
                while unseen:
                    start = min(unseen)
                    cycle = [start]
                    color = 'short'
                    while True:
                        successor = mate(matching if color == 'short' else reference, cycle[-1])
                        if successor == start:
                            break
                        assert successor not in cycle
                        cycle.append(successor)
                        color = 'long' if color == 'short' else 'short'
                    assert len(cycle) % 2 == 0
                    first_color = cycle[::2]
                    projected = {vertex // 2 for vertex in first_color}
                    assert len(projected) == len(first_color)
                    union.update(projected)
                    unseen.difference_update(cycle)
                    cycles += 1
                assert union == complement
                tested += 1

assert tested > 0 and cycles > 0
print(f'RESULT: PASS; {tested} labelled matchings, {cycles} cycles')
