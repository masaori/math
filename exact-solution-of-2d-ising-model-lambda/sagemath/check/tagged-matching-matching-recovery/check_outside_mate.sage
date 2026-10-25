# 対象ラベル: claim_tagged_matching_matching_recovery
# 非選択辺上: mate_{D_tau}(h) = iota(h) = mate_D(h)
load("sagemath/check/tagged-matching-matching-recovery/_prelude.sage")

checked = 0
for oriented, pairs, mate, selected, local, reconstructed in tagged_cases():
    assert all(reconstructed[h] == (h[0], 1 - h[1]) == mate[h]
               for h in oriented if h[0] not in selected)
    checked += 1
print("RESULT: PASS; %d exact tagged matchings" % checked)
