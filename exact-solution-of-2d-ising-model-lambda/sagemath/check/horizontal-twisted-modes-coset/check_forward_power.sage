# 対象ラベル: claim_horizontal_twisted_modes_coset
# (ξy)^L = ξ^L y^L。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    for y in [QQbar.zeta(L)^k for k in range(L)]:
        assert (xi * y)^L == xi^L * y^L
print('RESULT: PASS')
