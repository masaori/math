# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: P_G^Q(x) = sum_m eta_{N,Q}(Omega_G(m)) x^m
# 帰属: 有限集合、NN、ZZ、ZZ[x]、QQ、QQ[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")

integer_polynomial_ring = PolynomialRing(ZZ, "y")
rational_polynomial_ring = PolynomialRing(QQ, "y")
y_integer = integer_polynomial_ring.gen()
y_rational = rational_polynomial_ring.gen()

for data in examples:
    integer_polynomial = sum(
        (
            ZZ(data["multiplicities"][exponent]) * y_integer**exponent
            for exponent in range(data["edge_count"] + 1)
        ),
        integer_polynomial_ring.zero(),
    )
    embedded_polynomial = rational_polynomial_ring(integer_polynomial)
    rational_coefficient_expansion = sum(
        (
            QQ(data["multiplicities"][exponent]) * y_rational**exponent
            for exponent in range(data["edge_count"] + 1)
        ),
        rational_polynomial_ring.zero(),
    )
    assert embedded_polynomial == rational_coefficient_expansion, data["name"]

print("RESULT: PASS — the integer coefficient expansion maps coefficientwise into QQ[x]")
