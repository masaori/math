# 対象ラベル: claim_galois_hyperoctahedral_bound
# L=2 の分解体の全自己同型が逆数対を置換することを検証する。
# 帰属: QQ 上の有限次代数拡大と、その有限な自己同型集合の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

polynomial, _edge_count = partition_polynomial(2)
rational_polynomial_ring = PolynomialRing(QQ, "T")
T = rational_polynomial_ring.gen()
rational_polynomial = rational_polynomial_ring(polynomial)
splitting_field = rational_polynomial.squarefree_part().splitting_field("a")
roots = {root for root, _multiplicity in rational_polynomial.roots(splitting_field)}
nonfixed_roots = roots.difference({splitting_field(1), splitting_field(-1)})
pairs = {frozenset((root, root ** (-1))) for root in nonfixed_roots}

for automorphism in splitting_field.automorphisms():
    assert all(rational_polynomial(automorphism(root)) == 0 for root in roots)
    for root in nonfixed_roots:
        assert automorphism(root ** (-1)) * automorphism(root) == 1
        assert automorphism(root ** (-1)) == automorphism(root) ** (-1)
        assert frozenset((automorphism(root), automorphism(root ** (-1)))) in pairs

print("RESULT: PASS")
