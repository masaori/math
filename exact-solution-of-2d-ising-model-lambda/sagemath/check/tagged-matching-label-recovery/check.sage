# 対象ラベル: claim_tagged_matching_label_recovery
# 長短の標識を独立に列挙し、補辺から復元した標識と比較する。
load("sagemath/check/tagged-matching-matching-recovery/_prelude.sage")

checked = 0
for edge_count in (1, 2, 3):
    edges = tuple(range(edge_count))
    oriented = tuple((e, d) for e in edges for d in (0, 1))
    for pairs in pairings(oriented):
        mate = {a: b for a, b in pairs}
        mate.update({b: a for a, b in pairs})
        for count in range(len(pairs) + 1):
            for short_indices in combinations(range(len(pairs)), count):
                original_short = {frozenset(pairs[i]) for i in short_indices}
                original_long = {frozenset(pair) for i, pair in enumerate(pairs)
                                 if i not in short_indices}
                if any(b != (a[0], 1 - a[1]) for a, b in pairs
                       if frozenset((a, b)) in original_long):
                    continue
                selected = set(edges) - {next(iter(pair))[0]
                                         for pair in original_long}
                recovered = {h: mate[h] if h[0] in selected
                             else (h[0], 1 - h[1]) for h in oriented}
                recovered_pairs = {frozenset((h, recovered[h])) for h in oriented}
                recovered_short = {pair for pair in recovered_pairs
                                   if next(iter(pair))[0] in selected}
                assert recovered == mate
                assert recovered_pairs == original_short | original_long
                assert recovered_short == original_short
                assert recovered_pairs - recovered_short == original_long
                checked += 1
print("RESULT: PASS; %d independently tagged matchings" % checked)
