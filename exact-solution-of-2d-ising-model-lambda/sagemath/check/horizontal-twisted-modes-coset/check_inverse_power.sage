# 対象ラベル: claim_horizontal_twisted_modes_coset
# (ξ^{-1}z)^L = (ξ^L)^{-1}z^L。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    for z in [xi * QQbar.zeta(L)^k for k in range(L)]:
        assert (xi^(-1) * z)^L == (xi^L)^(-1) * z^L
print('RESULT: PASS')
