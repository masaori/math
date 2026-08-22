# 対象ラベル: theorem_even_linear_factor_characterizes_odd_incident_edge_count
# 式: 2(x+1) | Z_G(x) と奇接続辺数頂点の存在は同値
# 帰属: 有限集合、NN、ZZ、ZZ[x] だけを用いる

load("finite-graph-ising-partition-polynomial-and-fisher-zeros/sagemath/check/even-linear-factor-odd-incident-edge-characterization/_prelude.sage")

for example in examples:
    x, partition_polynomial, half_polynomial, incident_edge_counts = build_example(*example)
    quotient, remainder = half_polynomial.quo_rem(x + 1)
    has_even_linear_factor = remainder == 0
    has_odd_incident_edge_count = any(count % 2 == 1 for count in incident_edge_counts)

    if has_even_linear_factor:
        assert partition_polynomial == 2 * (x + 1) * quotient
        assert partition_polynomial(-1) == 0
    else:
        assert partition_polynomial(-1) != 0

    assert has_even_linear_factor == has_odd_incident_edge_count

print("RESULT: PASS — 2(x+1) divides Z_G(x) exactly for an odd incident-edge count")
