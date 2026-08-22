# 対象ラベル: theorem_full_cut_distinct_fisher_zero_product
# 式: product(Z_G) = -1 for an odd incident vertex, and 1 when all incident counts are even
# 帰属: 有限集合、NN、QQbar

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/full-cut-distinct-fisher-zero-product/_prelude.sage")


for data in example_data:
    expected = QQbar(-1) if data["odd_incident_vertex_exists"] else QQbar(1)
    assert data["distinct_root_product"] == expected, data["name"]

print("RESULT: PASS — the distinct-root product satisfies the odd-incidence case formula")
