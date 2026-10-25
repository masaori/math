from itertools import combinations

# 対象ラベル: claim_tagged_matching_even_complement
# 端点番号つき集合と短い標識の半辺の集合の全単射、d_P(v)=2k_v。
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
        for v in {(i, j) for i in range(L) for j in range(L)}:
            incidence = sum(1 for e in P for a in (0, 1) if source((e, a)) == v)
            short_at_v = sum(1 for h in short_halves if source(h) == v)
            short_pairs_at_v = sum(1 for first, _, label in matching
                                   if label == "short" and source(first) == v)
            assert incidence == short_at_v
            assert short_at_v == 2 * short_pairs_at_v
            assert incidence % 2 == 0
        count += 1
    print("L=%d: %d tagged matchings, incidence bijection and evenness PASS" % (L, count))

print("RESULT: PASS")
