# 対象ラベル: claim_twisted_mode_power_sum
# 対象: 冪の積法則と有限和の分配律
# 帰属: QQbar
for L in range(1, 7):
    roots = [QQbar.zeta(L) ** j for j in range(L)]
    for twist in (0, 1):
        xi = QQbar(1) if twist == 0 else QQbar.zeta(2 * L)
        for k in range(2 * L + 4):
            assert sum(((xi * y) ** k for y in roots), QQbar(0)) == (
                xi ** k * sum((y ** k for y in roots), QQbar(0)))
print('RESULT: PASS — power and finite sum distribution over QQbar')
