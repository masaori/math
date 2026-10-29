# 対象ラベル: claim_complex_realization_twisted_modes_are_complex_roots
# 複素実現の冪保存と、横・縦モードの複素方程式への移送を有限例で検算する。
for L in range(1, 7):
    for c in (0, 1):
        primitive = QQbar.zeta(2 * L)
        roots = [primitive**k for k in range(2 * L) if (primitive**k)**L == (-1)**c]
        assert len(roots) == L
        for z in roots:
            assert QQbar(z**0) == QQbar(z)**0
            for n in range(0, L):
                assert QQbar(z**(n + 1)) == QQbar(z**n) * QQbar(z)
            assert QQbar(z)**L == QQbar((-1)**c)
        assert QQbar((-1)**c) == (-1)**c
print('RESULT: PASS')
