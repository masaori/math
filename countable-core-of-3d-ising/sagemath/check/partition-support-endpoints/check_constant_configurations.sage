# 対象ラベル: claim_partition_support_endpoints
# 定数配位二つが相異なり、どちらの破れ辺集合も空で破れ数が 0 であることを検証する。
# 帰属: 有限集合と ZZ の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

for box_side in [1, 2]:
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    sigma_plus = {site: ZZ(1) for site in sites}
    sigma_minus = {site: ZZ(-1) for site in sites}
    assert sigma_plus != sigma_minus
    assert broken_edges(sigma_plus, edges) == set()
    assert ZZ(len(broken_edges(sigma_plus, edges))) == 0
    assert broken_edges(sigma_minus, edges) == set()
    assert ZZ(len(broken_edges(sigma_minus, edges))) == 0

print("RESULT: PASS")
