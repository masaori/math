# 対象ラベル: theorem_even_linear_factor_characterizes_odd_incident_edge_count
# 式: Z_G(x) = 2 P_G(x)
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/even-linear-factor-odd-incident-edge-characterization/_prelude.sage")

for example in examples:
    x, partition_polynomial, half_polynomial, incident_edge_counts = build_example(*example)
    assert all(ZZ(coefficient) % 2 == 0 for coefficient in partition_polynomial.list())
    assert partition_polynomial == 2 * half_polynomial

print("RESULT: PASS — exact even coefficients give Z_G(x) = 2 P_G(x) in ZZ[x]")
