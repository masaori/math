# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: \prod_{r=1}^4(-1)^{q_\sigma(e_r)}=\prod_{r=1}^4\sigma(\partial_0(e_r))\sigma(\partial_1(e_r))
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    lhs = prod(ZZ(-1) ** ZZ(edge in broken) for edge in boundary_edges)
    rhs = prod(ZZ(sigma[u]) * ZZ(sigma[v])
               for edge in boundary_edges for u, v in [endpoints(L, edge)])
    assert lhs == rhs
    checked += 1
print("RESULT: PASS (edge_products, %d cases)" % checked)
