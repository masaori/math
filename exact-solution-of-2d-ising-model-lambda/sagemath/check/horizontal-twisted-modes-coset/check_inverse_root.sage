# 対象ラベル: claim_horizontal_twisted_modes_coset
# (ξ^L)^{-1}z^L = (-1)^{-1}(-1)。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    for z in [xi * QQbar.zeta(L)^k for k in range(L)]:
        assert (xi^L)^(-1) * z^L == (-1)^(-1) * (-1)
print('RESULT: PASS')
