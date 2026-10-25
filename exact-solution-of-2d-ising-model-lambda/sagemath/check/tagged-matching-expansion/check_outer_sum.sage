# 対象ラベル: claim_tagged_matching_expansion
# 各マッチングの標識和への符号因子の分配を検算する。
P = PolynomialRing(QQ, names=('c0', 'c1', 'a0', 'a1', 'b0', 'b1'))
c0, c1, a0, a1, b0, b1 = P.gens()
left = c0 * (a0 + a1) + c1 * (b0 + b1)
right = (c0 * a0 + c0 * a1) + (c1 * b0 + c1 * b1)
assert left == right
print('RESULT: PASS')
