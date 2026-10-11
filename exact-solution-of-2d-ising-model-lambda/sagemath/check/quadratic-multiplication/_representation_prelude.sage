# 対象ラベル: claim_quadratic_multiplication_representation
# 帰属: QQ / QQbar。積の係数は数体の {1,r} 基底から取り出す。
from itertools import product

qm_polynomials = PolynomialRing(QQ, 't')
qm_t = qm_polynomials.gen()
qm_field = NumberField(qm_t**2 - 2, 'r')
qm_r = qm_field.gen()
qm_roots = (qm_t**2 - 2).roots(QQbar, multiplicities=False)
qm_samples = sorted(set(QQ(n) / QQ(d) for n in range(-2, 3) for d in range(1, 3)))
assert len(qm_roots) == 2 and len(qm_samples) == 7
j = QQbar
qm_representation_cases = []
for s in qm_roots:
    assert s*s == j(2)
    embedding = qm_field.hom([s], QQbar)
    assert embedding(qm_r) == s
    for a, b, ap, bp in product(qm_samples, repeat=4):
        xi_field = qm_field([a, b])
        eta_field = qm_field([ap, bp])
        xi = j(a) + j(b)*s
        eta = j(ap) + j(bp)*s
        assert embedding(xi_field) == xi
        assert embedding(eta_field) == eta
        field_product = xi_field * eta_field
        c, d = tuple(field_product)
        qm_representation_cases.append((s, a, b, ap, bp, xi, eta,
                                        field_product, embedding, c, d))
assert len(qm_representation_cases) == 4802
_quadratic_product_representation_ready = True
