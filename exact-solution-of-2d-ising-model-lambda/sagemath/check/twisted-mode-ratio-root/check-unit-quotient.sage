# 対象ラベル: claim_twisted_mode_ratio_root
# (-1)^twist/(-1)^twist = 1。すべて QQbar の厳密等号。
for twist in (0, 1):
    sign = QQbar(-1) ** twist
    assert sign != 0
    assert sign / sign == QQbar(1)
print('PASS: nonzero twist sign has unit quotient')
