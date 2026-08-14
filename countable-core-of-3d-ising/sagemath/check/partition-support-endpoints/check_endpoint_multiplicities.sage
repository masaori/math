# 対象ラベル: claim_partition_support_endpoints
# 破れ数 0 と #E_L の水準集合がそれぞれ少なくとも二元を持つことを検証する。
# 帰属: 有限集合と ZZ の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

for box_side in [1, 2]:
    multiplicity, edge_count = multiplicities(box_side)
    assert multiplicity[ZZ(0)] >= ZZ(2)
    assert multiplicity[edge_count] >= ZZ(2)

print("RESULT: PASS")
