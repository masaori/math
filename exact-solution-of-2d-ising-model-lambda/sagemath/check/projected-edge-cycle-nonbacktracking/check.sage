# 対象ラベル: claim_projected_edge_cycle_nonbacktracking
# 各行の構成: 短い相手、長い相手の反転、閉性、局所 Next。
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


cases = 0
one_step_cycles = 0
for size in (2, 4, 6):
    vertices = tuple(range(size))
    reference = frozenset(frozenset((i, i + 1)) for i in range(0, size, 2))
    reversal = lambda i: i + 1 if i % 2 == 0 else i - 1
    for sources in product((0, 1), repeat=size):
        target = lambda i: sources[reversal(i)]
        next_step = lambda e, f: target(e) == sources[f] and f != reversal(e)
        for matching in matchings(vertices):
            pairs = tuple(matching)
            for choice in range(1 << len(pairs)):
                short = {pair for bit, pair in enumerate(pairs) if choice & (1 << bit)}
                if any(pair not in reference for pair in matching - short):
                    continue
                if any(len({sources[e] for e in pair}) != 1 for pair in short):
                    continue
                active = {e for pair in short for e in pair}
                unseen = set(active)
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
                    k = len(cycle) // 2
                    e = [cycle[2 * r] for r in range(k)] + [cycle[0]]
                    w = [reversal(edge) for edge in e]
                    assert w[k] == w[0]
                    for r in range(k):
                        odd = cycle[2 * r + 1]
                        assert odd == mate(matching, e[r])
                        assert e[r + 1] == reversal(odd)
                        assert w[r + 1] == odd
                        assert next_step(w[r], w[r + 1])
                    one_step_cycles += k == 1
                    cases += 1
                    unseen.difference_update(cycle)

assert cases > 0 and one_step_cycles > 0
print('RESULT: PASS; cyclic Next steps in', cases, 'labelled cycles, including', one_step_cycles, 'one-step cycles')
