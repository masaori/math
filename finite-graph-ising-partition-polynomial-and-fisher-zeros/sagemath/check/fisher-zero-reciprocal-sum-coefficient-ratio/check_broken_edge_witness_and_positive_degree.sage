# 対象ラベル: theorem_fisher_zero_reciprocal_sum_coefficient_ratio
# 式ペア: sigma_0 in S_G, e_0 in B_G(sigma_0), d >= b_G(sigma_0) >= 1

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-reciprocal-sum-coefficient-ratio/_prelude.sage")

for data in examples:
    source, target = data["edges"][0]
    sigma_0 = tuple(
        ZZ(0) if vertex == target else ZZ(1)
        for vertex in range(data["vertex_count"])
    )
    assert sigma_0 in data["configurations"], data["name"]
    assert source != target, data["name"]
    assert sigma_0[source] != sigma_0[target], data["name"]
    witness_broken_count = ZZ(sum(
        1
        for edge_source, edge_target in data["edges"]
        if sigma_0[edge_source] != sigma_0[edge_target]
    ))
    assert witness_broken_count in data["broken_counts"], data["name"]
    assert witness_broken_count >= 1, data["name"]
    assert data["degree"] >= witness_broken_count, data["name"]

print("RESULT: PASS — the constructed spin configuration contains the chosen broken edge and forces positive degree")
