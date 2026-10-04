# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: d_{A_\sigma}(i,j) = \sum_{e\in A_\sigma,a\in\{0,1\},\partial_a(e)=(i,j)}1
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    lhs = incidence_count(L, dual_broken, vertex)
    rhs = sum(ZZ(1) for edge in dual_broken for a in (0, 1)
              if endpoints(L, edge)[a] == vertex)
    assert lhs == rhs
    checked += 1
print("RESULT: PASS (incidence_definition, %d cases)" % checked)
