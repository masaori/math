# 対象ラベル: theorem_even_linear_factor_characterizes_odd_incident_edge_count
# 式: Z_G(-1) = 0 ならば P_G(-1) = 0
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

load("countable-ising-on-hyperbolic-surfaces/sagemath/check/even-linear-factor-odd-incident-edge-characterization/_prelude.sage")

for example in examples:
    x, partition_polynomial, half_polynomial, incident_edge_counts = build_example(*example)
    has_odd_incident_edge_count = any(count % 2 == 1 for count in incident_edge_counts)
    if has_odd_incident_edge_count:
        assert partition_polynomial(-1) == 0
        assert partition_polynomial(-1) == 2 * half_polynomial(-1)
        assert half_polynomial(-1) == 0

print("RESULT: PASS — cancellation of nonzero 2 in ZZ transfers the root to P_G")
