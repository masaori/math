# 対象ラベル: theorem_odd_incident_edge_count_root_minus_one
# 式: Z_G(-1) = 0
# 帰属: 有限集合、ZZ、ZZ[x] だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/odd-incident-edge-count-root-minus-one/_prelude.sage")

for vertex_count, edges, vertex in examples:
    configurations, incident_edges, flip, broken_edges, polynomial = build_example(vertex_count, edges, vertex)
    assert ZZ(len(incident_edges)) % 2 == 1
    assert all(flip(flip(configuration)) == configuration for configuration in configurations)
    assert all(flip(configuration) != configuration for configuration in configurations)
    assert sum(((-1) ** ZZ(len(broken_edges(configuration))) for configuration in configurations), ZZ.zero()) == 0
    assert polynomial(-1) == 0

print("RESULT: PASS — exact ZZ[x] evaluation vanishes at -1")
