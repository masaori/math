# 対象ラベル: claim_dual_edge_map_bijective
# 対象: 縦向き辺の delta_L o eta_L、剰余類の減法と加法。
# 式ペア: n_{\mathrm v}(i,(j-\bar1)+\bar1) = n_{\mathrm v}(i,j)
# 帰属: 辺番号は ZZ、i, j, one は Zmod(L)。
load('sagemath/check/dual-edge-map-bijective/_prelude.sage')

for L, i, j, one in coordinate_cases:
    expr1 = vertical_number(L, i, (j - one) + one)
    expr2 = vertical_number(L, i, j)
    assert expr1 == expr2, (L, i, j, expr1, expr2)

print('縦向き辺: 減法の後の加法による相殺を55辺で確認')
print('RESULT: PASS')
