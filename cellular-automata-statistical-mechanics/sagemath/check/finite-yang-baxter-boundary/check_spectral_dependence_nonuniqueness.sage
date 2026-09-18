# 対象ラベル: claim_single_finite_yang_baxter_map_does_not_determine_spectral_dependence
# 式ペア: f(l1,l2)f(l1,l3)f(l2,l3) は一元集合上の Yang–Baxter 等式の両辺で一致する。
# 帰属: QQ[l1,l2,l3]。多項式恒等式として判定するため CC・浮動小数点・極限は使わない。
ring = PolynomialRing(QQ, names=('lambda_1', 'lambda_2', 'lambda_3'))
lambda_1, lambda_2, lambda_3 = ring.gens()


def yb_left_coefficient(f):
    return f(lambda_1, lambda_2) * f(lambda_1, lambda_3) * f(lambda_2, lambda_3)


def yb_right_coefficient(f):
    return f(lambda_2, lambda_3) * f(lambda_1, lambda_3) * f(lambda_1, lambda_2)


constant_family = lambda left, right: ring.one()
nonconstant_family = lambda left, right: ring.one() + left

assert yb_left_coefficient(constant_family) == yb_right_coefficient(constant_family)
assert yb_left_coefficient(nonconstant_family) == yb_right_coefficient(nonconstant_family)
assert constant_family(0, 0) == nonconstant_family(0, 0) == 1
assert constant_family(1, 0) == 1
assert nonconstant_family(1, 0) == 2
assert constant_family(1, 0) != nonconstant_family(1, 0)
assert nonconstant_family(lambda_1, lambda_2).degree(lambda_1) == 1
print('exact coefficient identity for the constant family:', yb_left_coefficient(constant_family))
print('exact coefficient identity for the nonconstant family:', yb_left_coefficient(nonconstant_family))
print('common specialization at (0,0):', constant_family(0, 0))
print('distinct specializations at (1,0):', constant_family(1, 0), nonconstant_family(1, 0))
print('RESULT: PASS')
