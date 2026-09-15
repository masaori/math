# 対象ラベル: claim_binary_ca_finite_difference_does_not_determine_derivative
# 併せて検証: def_binary_ca_interpolated_derivative_temperature
# 式ペア: (L(a+h)-L(a))/h=d、(Q(a+h)-Q(a))/h=d-1+h、L'(a)=d、Q'(a)=d-1。
# 帰属: 実多項式と非零刻みの有理関数の恒等式。QQ 上の形式計算として厳密に検査する。
# 多項式微分は厳密であり、浮動小数点・数値極限・実対数は使わない。
polynomial_ring = PolynomialRing(QQ, names=('t', 'a', 'S0', 'd', 'h'))
t, a, S0, d, h = polynomial_ring.gens()
b = a + 1
linear = S0 + (t - a) * d
quadratic = linear + (t - a) * (t - b)
fraction_field = polynomial_ring.fraction_field()

linear_quotient = fraction_field(linear(t=a + h) - linear(t=a)) / h
quadratic_quotient = fraction_field(quadratic(t=a + h) - quadratic(t=a)) / h
assert linear_quotient == fraction_field(d)
assert quadratic_quotient == fraction_field(d - 1 + h)

linear_derivative = linear.derivative(t)(t=a)
quadratic_derivative = quadratic.derivative(t)(t=a)
assert linear_derivative == d
assert quadratic_derivative == d - 1
assert linear_derivative - quadratic_derivative == 1
print('nonzero-step difference quotient identities checked:', ZZ(2))
print('polynomial derivative identities checked:', ZZ(3))
print('RESULT: PASS')
