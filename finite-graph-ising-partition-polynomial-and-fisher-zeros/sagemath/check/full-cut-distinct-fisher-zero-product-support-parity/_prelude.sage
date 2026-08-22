# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product_support_parity
# 帰属: 有限集合、NN、QQbar だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-distinct-fisher-zero-product/_prelude.sage")


for data, (_name, vertex_count, edges) in zip(example_data, examples):
    data["incident_edge_counts"] = tuple(
        NN(sum(1 for source, target in edges if source == vertex or target == vertex))
        for vertex in range(vertex_count)
    )
    data["root_support_cardinality"] = NN(data["root_support"].cardinality())
    data["root_support_is_odd"] = bool(data["root_support_cardinality"] % 2 == 1)
