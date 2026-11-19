# 対象ラベル: claim_square_root_adjoined_weighted_square_sum_excludes_minus_one
# B の定義と有限和の分配。有理係数の有限標本による厳密検算。
load('sagemath/check/square-root-adjoined-weighted-square-sum-excludes-minus-one/sample.sage')
assert Psplit == A + B*b
print('PASS: plus_B_definition')
