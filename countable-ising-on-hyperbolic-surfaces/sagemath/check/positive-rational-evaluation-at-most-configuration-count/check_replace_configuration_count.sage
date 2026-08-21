# 対象ラベル: theorem_partition_polynomial_positive_rational_evaluation_at_most_configuration_count
# 式ペア: Z_G(q) <= 2^|V| iff Z_G(q) <= Z_G(1)
# 帰属: NN、QQ、QQ[x]

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/positive-rational-evaluation-at-most-configuration-count/_prelude.sage")

for vertex_count, edges in examples:
    _, polynomial, _, _, _ = partition_data(vertex_count, edges)
    configuration_count = QQ(2**vertex_count)
    value_at_one = QQ(polynomial(QQ(1)))
    for q in positive_rational_points:
        value = QQ(polynomial(q))
        assert (value <= configuration_count) == (value <= value_at_one)

print("RESULT: PASS — replacing the exact value at one by the configuration count preserves every tested weak inequality")

