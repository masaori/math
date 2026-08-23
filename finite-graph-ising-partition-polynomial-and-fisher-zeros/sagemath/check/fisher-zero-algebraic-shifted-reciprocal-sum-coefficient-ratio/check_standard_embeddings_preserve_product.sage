# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_sum_coefficient_ratio
# 式ペア: iota(eta(Omega_G(m))) iota(eta(m)) = iota(eta(m Omega_G(m)))
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-sum-coefficient-ratio/_prelude.sage")
for data in examples:
    for exponent in range(1, data["edge_count"] + 1):
        multiplicity = data["multiplicities"][exponent]
        embedded_product = QQbar(QQ(multiplicity)) * QQbar(QQ(NN(exponent)))
        embedded_natural_product = QQbar(QQ(NN(exponent) * multiplicity))
        assert embedded_product == embedded_natural_product, (data["name"], exponent)
print("RESULT: PASS — the standard embeddings from NN through QQ to QQbar preserve each coefficient product")
