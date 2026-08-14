# 対象ラベル: claim_partition_support_endpoints
# m_L(T sigma)=#E_L-m_L(sigma) と、定数配位二つの像が相異なることを検証する。
# 帰属: 有限集合と ZZ の厳密計算。
import os
directory = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(directory, "_prelude.sage"))

for box_side in [1, 2]:
    sites = box_sites(box_side)
    edges = inner_edges(box_side)
    edge_count = ZZ(len(edges))
    sigma_plus = {site: ZZ(1) for site in sites}
    sigma_minus = {site: ZZ(-1) for site in sites}
    flipped_plus = odd_flip(sigma_plus)
    flipped_minus = odd_flip(sigma_minus)
    assert flipped_plus != flipped_minus
    for configuration, flipped in [
        (sigma_plus, flipped_plus),
        (sigma_minus, flipped_minus),
    ]:
        broken_count = ZZ(len(broken_edges(configuration, edges)))
        flipped_broken_count = ZZ(len(broken_edges(flipped, edges)))
        assert flipped_broken_count == edge_count - broken_count
        assert flipped_broken_count == edge_count

print("RESULT: PASS")
