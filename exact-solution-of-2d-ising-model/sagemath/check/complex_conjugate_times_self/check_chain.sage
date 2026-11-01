# 対象ラベル: complex_conjugate_times_self
# conj(z) z = (|z|^2)_C の五行を、z = (x, y) の x, y を QQ 上の不定元に置いて厳密に確かめる。
# |z|^2 は abs_basic_properties (2) の x^2 + y^2。具体の z では |z| を AA で取って二乗と比べる。
load("../../_shared/complex_as_real_pairs.sage")

P = PolynomialRing(QQ, ["x", "y"])
x, y = P.gens()
z = (x, y)
abs_sq = x^2 + y^2   # abs_basic_properties (2)
lines = [
    cc_mul(cc_conj(z), z),                  # conj(z) z
    cc_mul((x, -y), (x, y)),                # (x,-y)(x,y)                 (def_complex_conjugate)
    (x * x - (-y) * y, x * y + (-y) * x),   # (xx - (-y)y, xy + (-y)x)    (definition_of_cc の積)
    (x^2 + y^2, P(0)),                      # (x^2+y^2, 0)                (ℝ の四則)
    (abs_sq, P(0)),                         # (|z|^2, 0)                  (abs_basic_properties (2))
    iota(abs_sq, P),                        # (|z|^2)_C                   (inclusion_rr_to_cc)
]
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], t
KG = QuadraticField(-1, 'i')
set_random_seed(3)
for _ in range(20):
    a, b = QQ(ZZ.random_element(-9, 10)) / ZZ.random_element(1, 5), QQ(ZZ.random_element(-9, 10)) / ZZ.random_element(1, 5)
    lhs = cc_mul(cc_conj((a, b)), (a, b))
    w = a + KG.gen() * b
    assert lhs == iota(cc_abs_aa((a, b))^2, AA)          # 本文の |z| を AA で取った値の二乗
    assert lhs[0] == QQbar(w).abs()^2 and lhs[1] == 0    # 比べる側: QQbar の abs
print("不定元と具体の 20 点で conj(z) z = (|z|^2)_C を確かめた")
print("RESULT: PASS")
