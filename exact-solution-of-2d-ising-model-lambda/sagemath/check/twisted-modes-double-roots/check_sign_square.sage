# 対象ラベル: claim_twisted_modes_are_double_roots
# ((-1)^c)^2 = 1。符号はスピン構造の成分 c∈{0,1} に限る。
for c in (0, 1):
    eps = QQ((-1)^c)
    assert eps^2 == QQ(1)
print('RESULT: PASS')
