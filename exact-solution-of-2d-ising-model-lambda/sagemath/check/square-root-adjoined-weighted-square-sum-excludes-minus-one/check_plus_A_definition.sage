# 対象ラベル: claim_square_root_adjoined_weighted_square_sum_excludes_minus_one
# A の定義。有理係数の有限標本による厳密検算。
load('sagemath/check/square-root-adjoined-weighted-square-sum-excludes-minus-one/sample.sage')
assert Psplit == A + sum((2*c[i]*u[i]*v[i])*b for i in range(len(c)))
print('PASS: plus_A_definition')
