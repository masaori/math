# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: q_1+q_3+q_2+q_4=q_1+q_2+q_3+q_4
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    lhs = sum(ZZ(edge in broken) for edge in inverse_edges)
    rhs = sum(ZZ(edge in broken) for edge in boundary_edges)
    assert lhs == rhs
    checked += 1
print("RESULT: PASS (boundary_order, %d cases)" % checked)
