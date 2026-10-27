# 対象ラベル: claim_same_direction_dual_inner_orthogonality
# 代表による再添字付けと有限和の分配律。
load('sagemath/check/same-direction-dual-inner-orthogonality/_prelude.sage')
for L, delta, varpi, varsigma, vp, sp in cases():
    r, t = vp / varpi, sp / varsigma
    vertex_sum = sum(r**j * t**i for i, j in product(range(L), range(L)))
    nested_sum = sum(sum(r**j * t**i for j in range(L)) for i in range(L))
    product_sum = sum(r**j for j in range(L)) * sum(t**i for i in range(L))
    assert vertex_sum == nested_sum
    assert nested_sum == product_sum
print('PASS: representative reindexing and distributivity')
