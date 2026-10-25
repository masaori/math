# 対象ラベル: claim_tagged_matching_expansion
# 有限積へ新しい対を加えた行を厳密多項式で検算する。
load('sagemath/check/tagged-matching-expansion/_prelude.sage')

for n in range(3):
    left = pair_product(n + 1)
    right = (l[n] - s[n]) * pair_product(n)
    assert left == right
print('RESULT: PASS')
