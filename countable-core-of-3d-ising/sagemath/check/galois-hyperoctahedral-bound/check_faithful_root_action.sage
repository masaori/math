# 対象ラベル: claim_galois_hyperoctahedral_bound
# L=2 で非固定根を全て固定する自己同型が恒等写像だけであることを検証する。
# 帰属: QQ 上の有限次代数拡大と、その有限な自己同型集合の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

polynomial, _edge_count = partition_polynomial(2)
rational_polynomial_ring = PolynomialRing(QQ, "T")
rational_polynomial = rational_polynomial_ring(polynomial)
splitting_field = rational_polynomial.squarefree_part().splitting_field("a")
roots = {root for root, _multiplicity in rational_polynomial.roots(splitting_field)}
nonfixed_roots = roots.difference({splitting_field(1), splitting_field(-1)})
automorphisms = splitting_field.automorphisms()
root_fixers = [
    automorphism
    for automorphism in automorphisms
    if all(automorphism(root) == root for root in nonfixed_roots)
]

assert len(root_fixers) == 1
assert root_fixers[0](splitting_field.gen()) == splitting_field.gen()

print("RESULT: PASS")
