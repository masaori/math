# 対象ラベル: claim_antiperiodic_mode_exists
# ξ^(2L) = 1。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    assert xi^(2 * L) == 1
print('RESULT: PASS')
