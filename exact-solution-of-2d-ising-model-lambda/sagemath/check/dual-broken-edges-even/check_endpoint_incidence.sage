# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: \sum_{e,a:\partial_a(e)=(i,j)}1 = a_\sigma(n_h(i,j))+a_\sigma(n_h(i,j-1))+a_\sigma(n_v(i,j))+a_\sigma(n_v(i-1,j))
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    lhs = sum(ZZ(1) for edge in dual_broken for a in (0, 1)
              if endpoints(L, edge)[a] == vertex)
    rhs = sum(ZZ(edge in dual_broken) for edge in dual_edges)
    assert lhs == rhs
    checked += 1
print("RESULT: PASS (endpoint_incidence, %d cases)" % checked)
