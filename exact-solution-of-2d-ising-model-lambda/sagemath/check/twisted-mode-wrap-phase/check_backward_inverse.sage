# 対象ラベル: claim_twisted_mode_wrap_phase
# 非零の z の逆元を右から掛ける最終行を照合する。
for L in range(1, 9):
    for sigma in (QQbar(1), QQbar(-1)):
        for z in (QQbar['t'].gen()**L - sigma).roots(QQbar, multiplicities=False):
            assert z != 0
            assert sigma * z**(L - 1) == z**(-1)
