# 対象ラベル: claim_square_root_adjoined_weighted_square_sum_excludes_minus_one
# 共役側で b²=a を代入。有理係数の有限標本による厳密検算。
load('sagemath/check/square-root-adjoined-weighted-square-sum-excludes-minus-one/sample.sage')
assert Mexpand == Msubstitute
print('PASS: minus_square_relation')
