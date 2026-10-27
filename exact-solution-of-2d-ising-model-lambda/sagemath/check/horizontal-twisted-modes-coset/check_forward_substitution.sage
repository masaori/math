# 対象ラベル: claim_horizontal_twisted_modes_coset
# ξ^L y^L = (-1)1。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    for y in [QQbar.zeta(L)^k for k in range(L)]:
        assert xi^L * y^L == (-1) * 1
print('RESULT: PASS')
