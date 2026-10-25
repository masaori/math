# 対象ラベル: claim_tagged_matching_matching_recovery
# 選択辺上: mate_{D_tau}(h) = kappa(h) = mate_D(h)
load("sagemath/check/tagged-matching-matching-recovery/_prelude.sage")

checked = 0
for oriented, pairs, mate, selected, local, reconstructed in tagged_cases():
    assert all(reconstructed[h] == local[h] == mate[h]
               for h in oriented if h[0] in selected)
    checked += 1
print("RESULT: PASS; %d exact tagged matchings" % checked)
