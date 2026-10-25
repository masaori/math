# 対象ラベル: claim_tagged_matching_expansion
# 帰納段の分配則だけを厳密多項式で検算する。
load('sagemath/check/tagged-matching-expansion/_prelude.sage')

for n in range(3):
    product_before = pair_product(n)
    left = (l[n] - s[n]) * product_before
    distributed = l[n] * product_before - s[n] * product_before
    assert left == distributed
print('RESULT: PASS')
