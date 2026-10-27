# 対象ラベル: claim_twisted_mode_wrap_phase
# z^L=σ を前進端の等式へ代入する。
for L in range(1, 9):
    for sigma in (QQbar(1), QQbar(-1)):
        for z in (QQbar['t'].gen()**L - sigma).roots(QQbar, multiplicities=False):
            assert sigma * z**0 == sigma
            assert sigma == z**L
