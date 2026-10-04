# 対象ラベル: claim_dual_edge_map_bijective
# 対象: 縦向き辺の delta_L o eta_L、eta_L の定義の適用。
# 式ペア: \delta_L(\eta_L(n_{\mathrm v}(i,j))) = \delta_L(n_{\mathrm h}(i,j-\bar1))
# 帰属: 辺番号は ZZ、i, j, one は Zmod(L)。
load('sagemath/check/dual-edge-map-bijective/_prelude.sage')

for L, i, j, one in coordinate_cases:
    expr1 = dual_image(L, dual_inverse(L, vertical_number(L, i, j)))
    expr2 = dual_image(L, horizontal_number(L, i, j - one))
    assert expr1 == expr2, (L, i, j, expr1, expr2)

print('縦向き辺: 反対の往復で逆写像を開く等式を55辺で確認')
print('RESULT: PASS')
