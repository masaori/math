# 対象ラベル: theorem_even_linear_factor_characterizes_odd_incident_edge_count
# 式: P_G(-1) = 0 ならば P_G(x) = (x+1) R_G(x)
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/even-linear-factor-odd-incident-edge-characterization/_prelude.sage")

for example in examples:
    x, partition_polynomial, half_polynomial, incident_edge_counts = build_example(*example)
    quotient, remainder = half_polynomial.quo_rem(x + 1)
    assert half_polynomial == (x + 1) * quotient + remainder
    assert remainder == half_polynomial.parent()(half_polynomial(-1))
    if half_polynomial(-1) == 0:
        assert remainder == 0
        assert partition_polynomial == 2 * (x + 1) * quotient

print("RESULT: PASS — monic division in ZZ[x] produces the factor 2(x+1)")
