# 対象ラベル: claim_tagged_matching_local_pairs
# 半辺と局所短対の存在・一意性を、辺長一〜三で標識ごとに列挙する。
for L in (1, 2, 3):
    edges = [(i, j, axis) for i in range(L) for j in range(L) for axis in (0, 1)]
    halves = [(e, a) for e in edges for a in (0, 1)]

    def source(h):
        (i, j, axis), a = h
        if a == 0:
            return (i, j)
        return ((i + 1) % L, j) if axis == 0 else (i, (j + 1) % L)

    def matchings(remaining):
        if not remaining:
            yield ()
            return
        first = min(remaining)
        tail = remaining - {first}
        for second in tail:
            labels = []
            if first[0] == second[0]:
                labels.append("long")
            if source(first) == source(second):
                labels.append("short")
            for label in labels:
                for rest in matchings(tail - {second}):
                    yield ((first, second, label),) + rest

    count = 0
    for matching in matchings(set(halves)):
        long_edges = {first[0] for first, _, label in matching if label == "long"}
        P = set(edges) - long_edges
        for v in {(i, j) for i in range(L) for j in range(L)}:
            H = {(e, a) for e in P for a in (0, 1) if source((e, a)) == v}
            T = [(first, second) for first, second, label in matching
                 if label == "short" and source(first) == v]
            assert all(sum(h in pair for pair in T) == 1 for h in H)
            assert {h for pair in T for h in pair} == H
        count += 1
    print("L=%d: %d labelled matchings, local pairing PASS" % (L, count))

print("RESULT: PASS")
