# 対象ラベル: theorem_even_incident_edge_counts_evaluation_minus_one
# 式: Z_G(-1) = 2^|V|
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/even-incident-edge-counts-evaluation-minus-one/_prelude.sage")

for vertex_count, edges in examples:
    configurations, incident_edges, broken_edges, polynomial = build_example(vertex_count, edges)
    assert all(ZZ(len(incident_edges(vertex))) % 2 == 0 for vertex in range(vertex_count))
    assert all((-1) ** ZZ(len(broken_edges(configuration))) == 1 for configuration in configurations)
    assert polynomial(-1) == ZZ(2) ** vertex_count

print("RESULT: PASS — exact ZZ[x] evaluation equals the spin-configuration count")
