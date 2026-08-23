# 対象ラベル: claim_constant_finite_box_sequence_only_at_one
# 列が定数列という仮定から a_2(q)=a_1(q)=2、ゆえに Z_2(q)=2^{#V_2}=2^8=Z_2(1) となることを検証する。
# 帰属: ZZ[X] と QQ の厳密計算。8 乗を取ることで正の実数乗根を回避する。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

site_count = ZZ(len(box_sites(2)))
assert site_count == ZZ(8)

multiplicity_two, edge_count_two = multiplicities(2)
polynomial_two = partition_polynomial(multiplicity_two, edge_count_two)

# a_2(q)=2 は Z_2(q)=a_2(q)^{#V_2}=2^8 と同値（正の実数上で 8 乗は単射）。
assert ZZ(2) ** site_count == ZZ(256)
assert polynomial_two(QQ(1)) == ZZ(2) ** site_count

print("RESULT: PASS")
