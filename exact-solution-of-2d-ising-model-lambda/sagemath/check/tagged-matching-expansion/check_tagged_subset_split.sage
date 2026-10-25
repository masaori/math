# 対象ラベル: claim_tagged_matching_expansion
# 短い標識の集合を新しい対の有無で分ける行を検算する。
load('sagemath/check/tagged-matching-expansion/_prelude.sage')

for n in range(3):
    left = l[n] * tagged_sum(n) - s[n] * tagged_sum(n)
    right = tagged_sum(n + 1)
    assert left == right
print('RESULT: PASS')
