# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: \sum a_\sigma(e) = \sum q_\sigma(\delta_L^{-1}(e))
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    lhs = sum(ZZ(edge in dual_broken) for edge in dual_edges)
    rhs = sum(ZZ(edge in broken) for edge in inverse_edges)
    assert lhs == rhs
    checked += 1
print("RESULT: PASS (dual_preimages, %d cases)" % checked)
