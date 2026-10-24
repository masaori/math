# 対象ラベル: claim_empty_pfaffian_determinant
# 空添字の各等号を QQ[x] の厳密計算で検査する。
R = PolynomialRing(QQ, 'x')
matchings = [()]
permutations = [()]
c_empty = R((-1) ** 0)
b_empty = R(prod([]))
pf_definition = sum((c_empty * b_empty for D in matchings), R(0))
assert pf_definition == R(1)
det_definition = sum((R((-1) ** 0) * R(prod([])) for sigma in permutations), R(0))
assert det_definition == R(1)
assert pf_definition ** 2 == R(1)
assert R(1) == det_definition
print('PASS: empty matching sum, empty permutation sum, and square equality')
