# 対象ラベル: claim_twisted_mode_wrap_phase
# 後退端の冪の加法則、L-1+1=L、z^L=σ、σ²=1 を各行で照合する。
for L in range(1, 9):
    for sigma in (QQbar(1), QQbar(-1)):
        for z in (QQbar['t'].gen()**L - sigma).roots(QQbar, multiplicities=False):
            lhs = (sigma * z**(L - 1)) * z
            assert lhs == sigma * (z**(L - 1) * z)
            assert sigma * (z**(L - 1) * z) == sigma * z**((L - 1) + 1)
            assert sigma * z**((L - 1) + 1) == sigma * z**L
            assert sigma * z**L == sigma**2
            assert sigma**2 == 1
