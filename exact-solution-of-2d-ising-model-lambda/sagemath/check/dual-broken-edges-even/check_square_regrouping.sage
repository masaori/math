# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: (s_1s_2)(s_3s_2)(s_0s_3)(s_0s_1)=s_0^2s_1^2s_2^2s_3^2
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    s0, s1, s2, s3 = spins
    lhs = (s1 * s2) * (s3 * s2) * (s0 * s3) * (s0 * s1)
    rhs = prod(s ** 2 for s in spins)
    assert lhs == rhs
    checked += 1
print("RESULT: PASS (square_regrouping, %d cases)" % checked)
