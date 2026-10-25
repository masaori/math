# 対象ラベル: claim_tagged_matching_expansion
# 同じ対で長い条件と短い条件がともに真の場合の二寄与を独立に保つ。
P = PolynomialRing(QQ, names=('x', 'w', 'a'))
x, w, a = P.gens()
left = w * (1 - x * a)
right = w - x * (w * a)
assert left == right
assert w != 0 and x * w * a != 0
print('RESULT: PASS')
