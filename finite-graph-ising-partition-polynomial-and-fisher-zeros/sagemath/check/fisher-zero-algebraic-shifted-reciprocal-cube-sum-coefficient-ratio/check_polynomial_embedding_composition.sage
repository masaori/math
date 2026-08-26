# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: iota_{Z[x],Qbar[x]}(Z_G) = iota_{Q[x],Qbar[x]}(iota_{Z[x],Q[x]}(Z_G))
# 帰属: 有限集合、NN、ZZ、ZZ[x]、QQ、QQ[x]、QQbar、QQbar[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")

integer_polynomial_ring = PolynomialRing(ZZ, "y")
rational_polynomial_ring = PolynomialRing(QQ, "y")
algebraic_polynomial_ring = PolynomialRing(QQbar, "y")
y_integer = integer_polynomial_ring.gen()

for data in examples:
    integer_polynomial = sum(
        (
            ZZ(data["multiplicities"][exponent]) * y_integer**exponent
            for exponent in range(data["edge_count"] + 1)
        ),
        integer_polynomial_ring.zero(),
    )
    direct_embedding = algebraic_polynomial_ring(integer_polynomial)
    rational_embedding = rational_polynomial_ring(integer_polynomial)
    composed_embedding = algebraic_polynomial_ring(rational_embedding)
    assert direct_embedding == composed_embedding, data["name"]

print("RESULT: PASS — the direct polynomial embedding equals the embedding through QQ[x]")
