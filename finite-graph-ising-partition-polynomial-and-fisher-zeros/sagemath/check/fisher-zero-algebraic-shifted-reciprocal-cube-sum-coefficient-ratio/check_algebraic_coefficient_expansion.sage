# 対象ラベル: theorem_fisher_zero_algebraic_shifted_reciprocal_cube_sum_coefficient_ratio
# 式ペア: Pbar_G(x) = sum_m iota_{Q,Qbar}(eta_{N,Q}(Omega_G(m))) x^m
# 帰属: 有限集合、NN、QQ、QQ[x]、QQbar、QQbar[x] だけを用いる
load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/fisher-zero-algebraic-shifted-reciprocal-cube-sum-coefficient-ratio/_prelude.sage")

rational_polynomial_ring = PolynomialRing(QQ, "y")
algebraic_polynomial_ring = PolynomialRing(QQbar, "y")
y_rational = rational_polynomial_ring.gen()
y_algebraic = algebraic_polynomial_ring.gen()

for data in examples:
    rational_polynomial = sum(
        (
            QQ(data["multiplicities"][exponent]) * y_rational**exponent
            for exponent in range(data["edge_count"] + 1)
        ),
        rational_polynomial_ring.zero(),
    )
    embedded_polynomial = algebraic_polynomial_ring(rational_polynomial)
    algebraic_coefficient_expansion = sum(
        (
            QQbar(QQ(data["multiplicities"][exponent])) * y_algebraic**exponent
            for exponent in range(data["edge_count"] + 1)
        ),
        algebraic_polynomial_ring.zero(),
    )
    assert embedded_polynomial == algebraic_coefficient_expansion, data["name"]

print("RESULT: PASS — the rational coefficient expansion maps coefficientwise into QQbar[x]")
