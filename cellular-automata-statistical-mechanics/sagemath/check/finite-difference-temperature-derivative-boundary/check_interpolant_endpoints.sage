# 対象ラベル: claim_binary_ca_finite_difference_does_not_determine_derivative
# 併せて検証: def_binary_ca_real_entropy_interpolants
# 式ペア: L(a)=S_0、L(a+1)=S_0+d、Q(a)=L(a)、Q(a+1)=L(a+1)。
# 帰属: 実多項式の恒等式。QQ 上の形式多項式として厳密に検査すれば標準埋め込み先 RR でも成り立つ。
# 浮動小数点、実対数、極限は使わない。
ring = PolynomialRing(QQ, names=('t', 'a', 'S0', 'd'))
t, a, S0, d = ring.gens()
b = a + 1
linear = S0 + (t - a) * d
quadratic = linear + (t - a) * (t - b)

assert linear(t=a) == S0
assert linear(t=b) == S0 + d
assert quadratic(t=a) == linear(t=a)
assert quadratic(t=b) == linear(t=b)
assert quadratic(t=a) == S0
assert quadratic(t=b) == S0 + d
print('interpolant endpoint identities checked:', ZZ(6))
print('RESULT: PASS')
