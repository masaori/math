# 対象ラベル: claim_tagged_matching_matching_recovery
# 相手写像の全域一致から二元対の集合の一致
load("sagemath/check/tagged-matching-matching-recovery/_prelude.sage")

checked = 0
for oriented, pairs, mate, selected, local, reconstructed in tagged_cases():
    assert reconstructed == mate
    assert {frozenset((h, reconstructed[h])) for h in oriented} == \
        {frozenset(pair) for pair in pairs}
    checked += 1
print("RESULT: PASS; %d exact tagged matchings" % checked)
