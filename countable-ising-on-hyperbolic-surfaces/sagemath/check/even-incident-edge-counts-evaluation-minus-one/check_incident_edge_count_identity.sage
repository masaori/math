# 対象ラベル: theorem_even_incident_edge_counts_evaluation_minus_one
# 式: sum_{v in U_sigma} |I_v| = 2 |E_sigma^in| + b_G(sigma)
# 帰属: 有限集合、NN、ZZ だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/even-incident-edge-counts-evaluation-minus-one/_prelude.sage")

for vertex_count, edges in examples:
    configurations, incident_edges, broken_edges, _ = build_example(vertex_count, edges)
    assert all(ZZ(len(incident_edges(vertex))) % 2 == 0 for vertex in range(vertex_count))
    for configuration in configurations:
        up_vertices = frozenset(vertex for vertex, spin in enumerate(configuration) if spin == 1)
        internal_edges = frozenset(
            edge_index
            for edge_index, (source, target) in enumerate(edges)
            if source in up_vertices and target in up_vertices
        )
        incident_count_sum = sum((ZZ(len(incident_edges(vertex))) for vertex in up_vertices), ZZ.zero())
        broken_count = ZZ(len(broken_edges(configuration)))
        assert incident_count_sum == 2 * ZZ(len(internal_edges)) + broken_count
        assert broken_count % 2 == 0

print("RESULT: PASS — incident-edge double count and broken-edge parity hold over ZZ")
