# 対象ラベル: claim_vertical_twisted_modes_coset
# z = ξ(ξ^{-1}z)。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    for z in [xi * QQbar.zeta(L)^k for k in range(L)]:
        assert xi * (xi^(-1) * z) == z
print('RESULT: PASS')
