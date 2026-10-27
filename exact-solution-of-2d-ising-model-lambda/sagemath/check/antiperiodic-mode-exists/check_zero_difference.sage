# 対象ラベル: claim_antiperiodic_mode_exists
# (ξ^L)^2-1 = 0。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    assert (xi^L)^2 - 1 == 0
print('RESULT: PASS')
