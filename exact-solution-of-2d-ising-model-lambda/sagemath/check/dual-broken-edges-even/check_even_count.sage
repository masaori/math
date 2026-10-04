# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: (-1)^d=1\Longrightarrow d=2k,\quad k\in\mathbb N
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    degree = ZZ(incidence_count(L, dual_broken, vertex))
    assert ZZ(-1) ** degree == 1
    k = degree // 2
    assert k >= 0 and degree == 2 * k
    checked += 1
print("RESULT: PASS (even_count, %d cases)" % checked)
