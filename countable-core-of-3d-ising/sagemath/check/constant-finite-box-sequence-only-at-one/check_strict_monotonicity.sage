# 対象ラベル: claim_constant_finite_box_sequence_only_at_one
# Z_2 の係数の非負性と正次数の正係数から、正の有理数上の狭義単調増加と
# Z_2(q)=Z_2(1) ⇒ q=1 を検証する。
# 帰属: ZZ[X] と QQ の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

multiplicity, edge_count = multiplicities(2)
polynomial = partition_polynomial(multiplicity, edge_count)

assert edge_count == ZZ(12)
for degree in range(edge_count + 1):
    assert polynomial[ZZ(degree)] >= ZZ(0)
assert polynomial[edge_count] > ZZ(0)

# 狭義単調増加: 正の有理数 q < r で Z_2(q) < Z_2(r)。
sample = [QQ(1) / QQ(7), QQ(1) / QQ(2), QQ(1), QQ(3) / QQ(2), QQ(2), QQ(5)]
for i in range(len(sample)):
    for j in range(i + 1, len(sample)):
        assert sample[i] < sample[j]
        assert polynomial(sample[i]) < polynomial(sample[j])

# Z_2(q)=Z_2(1) を満たす正の有理点は 1 のみ。
shifted = polynomial - polynomial_ring(polynomial(QQ(1)))
positive_rational_roots = [
    root for root, _ in shifted.roots(QQ) if root > QQ(0)
]
assert positive_rational_roots == [QQ(1)]

print("RESULT: PASS")
