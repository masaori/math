# 対象ラベル: claim_dual_edge_map_bijective
# 対象: 横向き辺の eta_L o delta_L、剰余類の加法と減法。
# 式ペア: n_{\mathrm h}(i,(j+\bar1)-\bar1) = n_{\mathrm h}(i,j)
# 帰属: 辺番号は ZZ、i, j, one は Zmod(L)。
load('sagemath/check/dual-edge-map-bijective/_prelude.sage')

for L, i, j, one in coordinate_cases:
    expr1 = horizontal_number(L, i, (j + one) - one)
    expr2 = horizontal_number(L, i, j)
    assert expr1 == expr2, (L, i, j, expr1, expr2)

print('横向き辺: 加法の後の減法による相殺を55辺で確認')
print('RESULT: PASS')
