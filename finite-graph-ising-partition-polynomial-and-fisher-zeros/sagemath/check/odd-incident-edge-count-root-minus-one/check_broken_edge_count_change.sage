# 対象ラベル: theorem_odd_incident_edge_count_root_minus_one
# 式: b_G(T_w(sigma)) = b_G(sigma) + |I_w| - 2 r_w(sigma)
# 帰属: 有限集合、NN、ZZ だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/odd-incident-edge-count-root-minus-one/_prelude.sage")

for vertex_count, edges, vertex in examples:
    configurations, incident_edges, flip, broken_edges, _ = build_example(vertex_count, edges, vertex)
    assert ZZ(len(incident_edges)) % 2 == 1
    for configuration in configurations:
        broken = broken_edges(configuration)
        flipped_broken = broken_edges(flip(configuration))
        intersection_count = ZZ(len(broken.intersection(incident_edges)))
        assert flipped_broken == broken.symmetric_difference(incident_edges)
        assert ZZ(len(flipped_broken)) == ZZ(len(broken)) + ZZ(len(incident_edges)) - 2 * intersection_count

print("RESULT: PASS — broken-edge count change holds exactly over ZZ")
