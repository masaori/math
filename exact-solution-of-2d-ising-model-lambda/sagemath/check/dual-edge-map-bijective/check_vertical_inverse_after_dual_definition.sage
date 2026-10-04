# 対象ラベル: claim_dual_edge_map_bijective
# 対象: 縦向き辺の eta_L o delta_L、def_dual_edge_map の適用。
# 式ペア: \eta_L(\delta_L(n_{\mathrm v}(i,j))) = \eta_L(n_{\mathrm h}(i+\bar1,j))
# 帰属: 辺番号は ZZ、i, j, one は Zmod(L)。
load('sagemath/check/dual-edge-map-bijective/_prelude.sage')

for L, i, j, one in coordinate_cases:
    expr1 = dual_inverse(L, dual_image(L, vertical_number(L, i, j)))
    expr2 = dual_inverse(L, horizontal_number(L, i + one, j))
    assert expr1 == expr2, (L, i, j, expr1, expr2)

print('縦向き辺: 双対辺写像を開く等式を55辺で確認')
print('RESULT: PASS')
