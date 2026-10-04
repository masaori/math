# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: (-1)^{d_{A_\sigma}(i,j)}=(-1)^{q_\sigma(e_1)+q_\sigma(e_2)+q_\sigma(e_3)+q_\sigma(e_4)}
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    lhs = ZZ(-1) ** incidence_count(L, dual_broken, vertex)
    rhs = ZZ(-1) ** sum(ZZ(edge in broken) for edge in boundary_edges)
    assert lhs == rhs
    checked += 1
print("RESULT: PASS (degree_substitution, %d cases)" % checked)
