# 対象ラベル: claim_same_direction_dual_inner_orthogonality
# 終点の成分積をモード比の冪に変える。
load('sagemath/check/same-direction-dual-inner-orthogonality/_prelude.sage')
for L, delta, varpi, varsigma, vp, sp in cases():
    r, t = vp / varpi, sp / varsigma
    lhs = sum(varpi**(-j) * varsigma**(-i) * vp**j * sp**i
              for i, j in product(range(L), range(L)))
    rhs = sum(r**j * t**i for i, j in product(range(L), range(L)))
    assert lhs == rhs
print('PASS: quotient powers')
