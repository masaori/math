# 対象ラベル: claim_square_root_adjoined_weighted_square_sum_excludes_minus_one
# 基礎体の重み付き平方和への分解。有理係数の有限標本による厳密検算。
load('sagemath/check/square-root-adjoined-weighted-square-sum-excludes-minus-one/sample.sage')
assert A == sum(c[i]*u[i]^2 for i in range(len(c))) + sum((c[i]*a)*v[i]^2 for i in range(len(c)))
print('PASS: base_weighted_sum')
