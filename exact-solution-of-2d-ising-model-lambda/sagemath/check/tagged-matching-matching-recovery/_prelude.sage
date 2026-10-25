# 対象ラベル: claim_tagged_matching_matching_recovery
# 有限な対と標識を厳密に列挙し、相手写像の両場合と完全マッチングの回復を検査する。
from itertools import combinations


def pairings(items):
    if not items:
        yield ()
        return
    first = items[0]
    for second in items[1:]:
        rest = tuple(x for x in items[1:] if x != second)
        for remaining in pairings(rest):
            yield ((first, second),) + remaining


def tagged_cases():
    for edge_count in (1, 2, 3):
        edges = tuple(range(edge_count))
        oriented = tuple((e, d) for e in edges for d in (0, 1))
        for pairs in pairings(oriented):
            mate = {a: b for a, b in pairs}
            mate.update({b: a for a, b in pairs})
            for count in range(edge_count + 1):
                for selected_tuple in combinations(edges, count):
                    selected = set(selected_tuple)
                    short_pairs = tuple((a, b) for a, b in pairs if a[0] in selected)
                    long_pairs = tuple((a, b) for a, b in pairs if a[0] not in selected)
                    if any(b[0] not in selected for a, b in short_pairs):
                        continue
                    if any(b != (a[0], 1 - a[1]) for a, b in long_pairs):
                        continue
                    complement = set(edges) - {a[0] for a, _ in long_pairs}
                    assert complement == selected
                    local = {h: mate[h] for h in oriented if h[0] in selected}
                    reconstructed = {
                        h: local[h] if h[0] in selected else (h[0], 1 - h[1])
                        for h in oriented
                    }
                    yield oriented, pairs, mate, selected, local, reconstructed
