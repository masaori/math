# 対象ラベル: claim_twisted_modes_complex_roots_bijection
# 有限例で根集合の個数、相異性、複素実現の像の一致を厳密に検算する。
for L in range(1, 9):
    for c in (0, 1):
        polynomial = PolynomialRing(QQbar, 'X').gen()**L - (-1)**c
        roots = [z for z, multiplicity in polynomial.roots(ring=QQbar)]
        primitive = QQbar.zeta(2 * L)
        algebraic_modes = [primitive**k for k in range(2 * L) if (primitive**k)**L == (-1)**c]
        assert len(roots) == L
        assert len(algebraic_modes) == L
        assert len(set(algebraic_modes)) == L
        assert set(algebraic_modes) == set(roots)
print('RESULT: PASS')
