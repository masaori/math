# 対象ラベル: theorem_odd_incident_edge_count_root_minus_one
# 式: (-1)^b_G(T_w(sigma)) = -(-1)^b_G(sigma)
# 帰属: 有限集合、NN、ZZ だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/odd-incident-edge-count-root-minus-one/_prelude.sage")

for vertex_count, edges, vertex in examples:
    configurations, incident_edges, flip, broken_edges, _ = build_example(vertex_count, edges, vertex)
    assert ZZ(len(incident_edges)) % 2 == 1
    for configuration in configurations:
        assert (-1) ** ZZ(len(broken_edges(flip(configuration)))) == -((-1) ** ZZ(len(broken_edges(configuration))))

print("RESULT: PASS — every one-vertex-flip pair has opposite integer signs")
