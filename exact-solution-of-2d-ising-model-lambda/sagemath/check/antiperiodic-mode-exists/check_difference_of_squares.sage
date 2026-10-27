# 対象ラベル: claim_antiperiodic_mode_exists
# (ξ^L-1)(ξ^L+1) = (ξ^L)^2-1。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    assert (xi^L - 1) * (xi^L + 1) == (xi^L)^2 - 1
print('RESULT: PASS')
