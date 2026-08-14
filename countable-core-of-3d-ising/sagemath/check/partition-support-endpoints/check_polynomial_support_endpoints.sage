# 対象ラベル: claim_partition_support_endpoints
# 両端の係数が対応する多重度で非零となり、有限和の外側に係数が無いことを検証する。
# 帰属: ZZ[X] と ZZ の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

for box_side in [1, 2]:
    multiplicity, edge_count = multiplicities(box_side)
    polynomial = partition_polynomial(multiplicity, edge_count)
    assert polynomial[ZZ(0)] == multiplicity[ZZ(0)]
    assert polynomial[edge_count] == multiplicity[edge_count]
    assert polynomial[ZZ(0)] >= ZZ(2)
    assert polynomial[edge_count] >= ZZ(2)
    assert polynomial.degree() == edge_count
    assert polynomial[-1] == ZZ(0)
    assert polynomial[edge_count + 1] == ZZ(0)

print("RESULT: PASS")
