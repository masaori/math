# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio
# 式ペア: Pbar_G(x) = sum_{m=0}^{|E|} iota(eta(Omega_G(m))) x^m
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    embedded_coefficient_expansion = sum(
        (
            QQbar(QQ(data["multiplicities"][exponent])) * data["x"] ** exponent
            for exponent in range(data["edge_count"] + 1)
        ),
        data["polynomial_ring"].zero(),
    )
    assert data["polynomial"] == embedded_coefficient_expansion, data["name"]
print("RESULT: PASS — the two standard embeddings give the QQbar coefficient expansion")
