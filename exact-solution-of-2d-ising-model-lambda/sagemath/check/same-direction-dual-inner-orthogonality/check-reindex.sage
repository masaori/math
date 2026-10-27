# 対象ラベル: claim_same_direction_dual_inner_orthogonality
# 各方向の終点は V_L を一度ずつ走る。
load('sagemath/check/same-direction-dual-inner-orthogonality/_prelude.sage')
for L, delta, varpi, varsigma, vp, sp in cases():
    edge_sum = sum((varpi**(-j) * varsigma**(-i) * vp**j * sp**i
                    if direction == delta else QQbar(0))
                   for i, j, direction in product(range(L), range(L), range(4)))
    vertex_sum = sum(varpi**(-j) * varsigma**(-i) * vp**j * sp**i
                     for i, j in product(range(L), range(L)))
    assert edge_sum == vertex_sum
print('PASS: target-direction reindexing')
