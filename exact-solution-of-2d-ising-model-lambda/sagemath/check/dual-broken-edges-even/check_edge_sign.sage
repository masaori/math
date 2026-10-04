# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: (-1)^{q_\sigma(e)} = \sigma(\partial_0(e))\sigma(\partial_1(e))
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L in (1, 2, 3):
    for sigma in configurations(L):
        broken = broken_edge_set(L, sigma)
        for edge in range(1, 2 * L * L + 1):
            u, v = endpoints(L, edge)
            assert ZZ(-1) ** ZZ(edge in broken) == ZZ(sigma[u]) * ZZ(sigma[v])
            checked += 1
print("RESULT: PASS (edge_sign, %d cases)" % checked)
