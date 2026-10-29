# 対象ラベル: claim_dispersion_product_real_log_sum
# 実対数への脱出を含むため、有限体積の代数的等式を先に厳密に確かめ、最後だけ高精度実数で比較する。
load('sagemath/check/torus-kac-ward-even-subgraph-square/construction.sage')

real = RealField(150)
for L in (1, 2):
    evens = even_subgraphs(L)
    for a in (0, 1):
        for b in (0, 1):
            Q = P(0)
            for subset in evens:
                h = sum(seam_parities(L, edge)[0] for edge in subset) % 2
                v = sum(seam_parities(L, edge)[1] for edge in subset) % 2
                Q += ZZ(-1) ** ((1+a)*h + (1+b)*v + h*v) * x ** len(subset)
            horizontal = [z for z, multiplicity in
                          (PolynomialRing(QQbar, 'z').gen()**L - (-1)**a).roots(ring=QQbar)]
            vertical = [z for z, multiplicity in
                        (PolynomialRing(QQbar, 'w').gen()**L - (-1)**b).roots(ring=QQbar)]
            for q in (QQ(1)/4, QQ(2)/3):
                factors = [(1+q**2)**2 - q*(1-q**2)*
                           (z + z**(-1) + w + w**(-1))
                           for z in horizontal for w in vertical]
                assert all(AA(factor) > 0 for factor in factors)
                assert QQbar(Q(q))**2 == prod(factors)
                left = real(abs(Q(q))).log() / L**2
                right = sum(real(AA(factor)).log() for factor in factors) / (2*L**2)
                assert abs(left - right) < real(10)**(-12)
print('RESULT: PASS')
