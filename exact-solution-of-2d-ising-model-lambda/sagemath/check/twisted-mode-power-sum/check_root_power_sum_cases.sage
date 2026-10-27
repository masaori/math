# 対象ラベル: claim_twisted_mode_power_sum
# 対象: L が指数を割る場合と割らない場合の一の冪根の冪和
# 帰属: QQbar
for L in range(1, 7):
    roots = [QQbar.zeta(L) ** j for j in range(L)]
    for twist in (0, 1):
        xi = QQbar(1) if twist == 0 else QQbar.zeta(2 * L)
        for k in range(2 * L + 4):
            actual = xi ** k * sum((y ** k for y in roots), QQbar(0))
            expected = xi ** k * (L if k % L == 0 else 0)
            assert actual == expected
print('RESULT: PASS — both root power sum cases over QQbar')
