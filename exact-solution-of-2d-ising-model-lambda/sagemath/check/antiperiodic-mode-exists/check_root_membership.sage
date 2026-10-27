# 対象ラベル: claim_antiperiodic_mode_exists
# ξ ∈ μ_{2L}。
for L in range(1, 7):
    xi = QQbar.zeta(2 * L)
    assert xi^(2 * L) == 1
print('RESULT: PASS')
