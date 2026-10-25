# 対象ラベル: claim_tagged_matching_mate_outside_complement
from itertools import combinations


def perfect_matchings(items):
    if not items:
        yield ()
        return
    first = items[0]
    for second in items[1:]:
        remaining = tuple(item for item in items[1:] if item != second)
        for other in perfect_matchings(remaining):
            yield ((first, second),) + other


checked = 0
for edge_count in (1, 2, 3):
    oriented = tuple((edge, end) for edge in range(edge_count) for end in (0, 1))
    for pairs in perfect_matchings(oriented):
        mate = {a: b for a, b in pairs} | {b: a for a, b in pairs}
        for short_count in range(len(pairs) + 1):
            for short_indices in combinations(range(len(pairs)), short_count):
                short = set(short_indices)
                long_pairs = [pairs[i] for i in range(len(pairs)) if i not in short]
                if any(b != (a[0], 1 - a[1]) for a, b in long_pairs):
                    continue
                selected = set(range(edge_count)) - {a[0] for a, _ in long_pairs}
                for a, b in pairs:
                    if (a, b) in long_pairs:
                        continue
                    assert a[0] in selected and b[0] in selected
                for h in oriented:
                    if h[0] not in selected:
                        assert mate[h] == (h[0], 1 - h[1])
                        checked += 1

assert checked > 0
print("RESULT: PASS; %d nonselected half-edges" % checked)
