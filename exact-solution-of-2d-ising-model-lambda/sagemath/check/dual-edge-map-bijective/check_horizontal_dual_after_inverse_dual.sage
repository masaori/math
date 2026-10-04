# 対象ラベル: claim_dual_edge_map_bijective
# 対象: 横向き辺の delta_L o eta_L、def_dual_edge_map の適用。
# 式ペア: \delta_L(n_{\mathrm v}(i-\bar1,j)) = n_{\mathrm h}((i-\bar1)+\bar1,j)
# 帰属: 辺番号は ZZ、i, j, one は Zmod(L)。
load('sagemath/check/dual-edge-map-bijective/_prelude.sage')

for L, i, j, one in coordinate_cases:
    expr1 = dual_image(L, vertical_number(L, i - one, j))
    expr2 = horizontal_number(L, (i - one) + one, j)
    assert expr1 == expr2, (L, i, j, expr1, expr2)

print('横向き辺: 反対の往復で双対辺写像を開く等式を55辺で確認')
print('RESULT: PASS')
