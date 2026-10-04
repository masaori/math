# 対象ラベル: claim_dual_broken_edges_even
# 式ペア: s_0^2s_1^2s_2^2s_3^2=1*1*1*1
# 帰属: 有限集合、NN、ZZ。浮動小数点を使わない。

load('sagemath/check/dual-broken-edges-even/_prelude.sage')

checked = 0
for L, sigma, broken, dual_broken, vertex, dual_edges, inverse_edges, boundary_edges, spins in local_data():
    assert prod(s ** 2 for s in spins) == ZZ(1) * ZZ(1) * ZZ(1) * ZZ(1)
    checked += 1
print("RESULT: PASS (spin_squares, %d cases)" % checked)
