# 対象ラベル: complex_conjugate_of_product
# 鎖の 8 行を一行ずつ。ℂ を本文 definition_of_cc どおり実数の対で持つ（_shared/complex_as_real_pairs.sage）。
# x, y, u, v は QQ 上の多項式環の不定元。比べる側は QQ(i) 係数の多項式 x + i y と Sage の係数の共役。
load("../../_shared/complex_as_real_pairs.sage")

K = QuadraticField(-1, 'i')
i_K = K.gen()
P = PolynomialRing(QQ, ['x', 'y', 'u', 'v'])
x, y, u, v = P.gens()
z, w = (x, y), (u, v)
lines = [
    cc_conj(cc_mul(z, w)),                         # conj(z w)
    cc_conj((x*u - y*v, x*v + y*u)),               # conj((xu - yv, xv + yu))   (definition_of_cc の積)
    (x*u - y*v, -(x*v + y*u)),                     # (xu - yv, -(xv + yu))     (def_complex_conjugate)
    (x*u - (-y)*(-v), -(x*v + y*u)),               # (-y)(-v) = yv
    (x*u - (-y)*(-v), (-(x*v)) + (-(y*u))),        # -(xv + yu) = (-(xv)) + (-(yu))
    (x*u - (-y)*(-v), x*(-v) + (-(y*u))),          # -(xv) = x(-v)
    (x*u - (-y)*(-v), x*(-v) + (-y)*u),            # -(yu) = (-y)u
    cc_mul((x, -y), (u, -v)),                      # (x,-y)(u,-v)               (definition_of_cc の積)
    cc_mul(cc_conj(z), cc_conj(w)),                # conj z conj w              (def_complex_conjugate)
]
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], t
# 積の定義の行が本文の式と一致すること（definition_of_cc の積を開いた形）
assert cc_mul(z, w) == (x*u - y*v, x*v + y*u)
PK = PolynomialRing(K, ['x', 'y', 'u', 'v'])
g = lambda q: PK(q[0]) + i_K * PK(q[1])
assert g(lines[0]) == (g(z) * g(w)).map_coefficients(lambda c: c.conjugate())
assert g(lines[-1]) == g(z).map_coefficients(lambda c: c.conjugate()) * g(w).map_coefficients(lambda c: c.conjugate())
print("鎖の 8 個の等号と、両端の Sage の共役との一致を不定元で確かめた")

set_random_seed(7)
for _ in range(20):
    a = K(QQ.random_element(10, 10)) + i_K * K(QQ.random_element(10, 10))
    b = K(QQ.random_element(10, 10)) + i_K * K(QQ.random_element(10, 10))
    pa, pb = (QQ(a.real()), QQ(a.imag())), (QQ(b.real()), QQ(b.imag()))
    lhs = cc_conj(cc_mul(pa, pb))
    rhs = cc_mul(cc_conj(pa), cc_conj(pb))
    c = (a * b).conjugate()
    assert lhs == rhs == (QQ(c.real()), QQ(c.imag()))
print("20 個の具体の QQ(i) の組で、主張の両端が Sage の conjugate と一致した")
print("RESULT: PASS")
