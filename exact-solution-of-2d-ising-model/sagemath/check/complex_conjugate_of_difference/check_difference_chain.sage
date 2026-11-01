# 対象ラベル: complex_conjugate_of_difference
# 準備（-1_C の共役）の鎖と、主張の鎖を一行ずつ。ℂ を本文 definition_of_cc どおり実数の対で持つ
# （_shared/complex_as_real_pairs.sage。-w は multiply_by_minus_one の (-1_C) w、差は def_complex_difference の z + (-w)）。
# x, y, u, v は QQ 上の多項式環の不定元。比べる側は QQ(i) 係数の多項式 x + i y と Sage の係数の共役・減法。
load("../../_shared/complex_as_real_pairs.sage")

K = QuadraticField(-1, 'i')
i_K = K.gen()
P = PolynomialRing(QQ, ['x', 'y', 'u', 'v'])
x, y, u, v = P.gens()
z, w = (x, y), (u, v)
m1 = iota(-1, P)   # -1_C = (-1, 0)

prep = [
    cc_conj(m1),          # conj(-1_C)
    cc_conj((P(-1), P(0))),  # conj((-1, 0))     (inclusion_rr_to_cc)
    (P(-1), -P(0)),       # (-1, -0)           (def_complex_conjugate)
    (P(-1), P(0)),        # (-1, 0)            (ℝ で -0 = 0)
    m1,                   # -1_C               (inclusion_rr_to_cc)
]
for t in range(len(prep) - 1):
    assert prep[t] == prep[t + 1], ("prep", t)
print("準備: 鎖の 4 個の等号を確かめた")

lines = [
    cc_conj(cc_sub(z, w, P)),                              # conj(z - w)
    cc_conj(cc_add(z, cc_neg(w, P))),                      # conj(z + (-w))            (def_complex_difference)
    cc_add(cc_conj(z), cc_conj(cc_neg(w, P))),             # conj z + conj(-w)         (complex_conjugate_of_sum, m = 2)
    cc_add(cc_conj(z), cc_conj(cc_mul(m1, w))),            # conj z + conj((-1_C) w)   (multiply_by_minus_one)
    cc_add(cc_conj(z), cc_mul(cc_conj(m1), cc_conj(w))),   # conj z + conj(-1_C) conj w (complex_conjugate_of_product)
    cc_add(cc_conj(z), cc_mul(m1, cc_conj(w))),            # conj z + (-1_C) conj w    (準備)
    cc_add(cc_conj(z), cc_neg(cc_conj(w), P)),             # conj z + (-conj w)        (multiply_by_minus_one)
    cc_sub(cc_conj(z), cc_conj(w), P),                     # conj z - conj w           (def_complex_difference)
]
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], t
PK = PolynomialRing(K, ['x', 'y', 'u', 'v'])
g = lambda q: PK(q[0]) + i_K * PK(q[1])
cj = lambda p: p.map_coefficients(lambda c: c.conjugate())
assert g(lines[0]) == cj(g(z) - g(w))
assert g(lines[-1]) == cj(g(z)) - cj(g(w))
print("主張: 鎖の 7 個の等号と、両端の Sage の共役・減法との一致を不定元で確かめた")

set_random_seed(13)
for _ in range(20):
    a = K(QQ.random_element(10, 10)) + i_K * K(QQ.random_element(10, 10))
    b = K(QQ.random_element(10, 10)) + i_K * K(QQ.random_element(10, 10))
    pa, pb = (QQ(a.real()), QQ(a.imag())), (QQ(b.real()), QQ(b.imag()))
    lhs = cc_conj(cc_sub(pa, pb, QQ))
    rhs = cc_sub(cc_conj(pa), cc_conj(pb), QQ)
    c = (a - b).conjugate()
    assert lhs == rhs == (QQ(c.real()), QQ(c.imag()))
print("20 個の具体の QQ(i) の組で、主張の両端が Sage の conjugate と減法に一致した")
print("RESULT: PASS")
