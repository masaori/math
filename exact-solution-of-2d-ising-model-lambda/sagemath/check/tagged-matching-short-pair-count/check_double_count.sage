from itertools import combinations

# 対象ラベル: claim_tagged_matching_short_pair_count
# 補辺の二つの向きと短い標識の対の二端点を別々に数える。
for L in (1, 2, 3):
    edges = [(i, j, axis) for i in range(L) for j in range(L) for axis in (0, 1)]
    half_edges = [(e, a) for e in edges for a in (0, 1)]

    def source(h):
        (i, j, axis), a = h
        if a == 0:
            return (i, j)
        return ((i + 1) % L, j) if axis == 0 else (i, (j + 1) % L)

    def choices(h, remaining):
        for other in remaining:
            if h[0] == other[0]:
                yield other, "long"
            if source(h) == source(other):
                yield other, "short"

    def matchings(remaining):
        if not remaining:
            yield ()
            return
        first = min(remaining)
        tail = remaining - {first}
        for other, label in choices(first, tail):
            for rest in matchings(tail - {other}):
                yield ((first, other, label),) + rest

    count = 0
    for matching in matchings(set(half_edges)):
        long_edges = {h[0] for h, _, label in matching if label == "long"}
        P = set(edges) - long_edges
        short_halves = {h for first, second, label in matching if label == "short"
                        for h in (first, second)}
        assert short_halves == {(e, a) for e in P for a in (0, 1)}
        short_pair_count = sum(1 for _, _, label in matching if label == "short")
        oriented_count = sum(1 for e, a in half_edges if e in P)
        assert oriented_count == 2 * len(P)
        assert oriented_count == len(short_halves)
        assert len(short_halves) == 2 * short_pair_count
        assert len(P) == short_pair_count
        count += 1
    print("L=%d: %d tagged matchings, double count PASS" % (L, count))

print("RESULT: PASS")
