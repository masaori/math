# 対象ラベル: claim_constant_finite_box_sequence_only_at_one
# 箱 V_1 に辺が無く、任意の正の有理点 q で Z_1(q)=2、#V_1=1 ゆえ a_1(q)=2 であることを検証する。
# 帰属: ZZ[X] と QQ の厳密計算（正の実数乗根は #V_1=1 のため現れない）。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

multiplicity, edge_count = multiplicities(1)
assert edge_count == ZZ(0)
polynomial = partition_polynomial(multiplicity, edge_count)
assert polynomial == polynomial_ring(2)
assert len(box_sites(1)) == 1

for q in [QQ(1), QQ(2), QQ(1) / QQ(3), QQ(7) / QQ(5), QQ(100)]:
    assert q > QQ(0)
    assert polynomial(q) == QQ(2)
    assert polynomial(q) ** (QQ(1) / QQ(len(box_sites(1)))) == QQ(2)

print("RESULT: PASS")
