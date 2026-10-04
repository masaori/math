# 対象ラベル: claim_dual_edge_map_bijective
# 対象: 縦向き辺の eta_L o delta_L、eta_L の定義の適用。
# 式ペア: \eta_L(n_{\mathrm h}(i+\bar1,j)) = n_{\mathrm v}((i+\bar1)-\bar1,j)
# 帰属: 辺番号は ZZ、i, j, one は Zmod(L)。
load('sagemath/check/dual-edge-map-bijective/_prelude.sage')

for L, i, j, one in coordinate_cases:
    expr1 = dual_inverse(L, horizontal_number(L, i + one, j))
    expr2 = vertical_number(L, (i + one) - one, j)
    assert expr1 == expr2, (L, i, j, expr1, expr2)

print('縦向き辺: 逆写像を開く等式を55辺で確認')
print('RESULT: PASS')
