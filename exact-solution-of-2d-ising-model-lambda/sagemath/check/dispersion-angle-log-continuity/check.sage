# 対象ラベル: claim_dispersion_angle_log_continuous
# 連続性は有限検算で証明できないため、被対数の恒等式と正の下界を検算する。
P = PolynomialRing(QQ, names=('q', 'c1', 'c2'))
q, c1, c2 = P.gens()
B = (1+q**2)**2 - 2*q*(1-q**2)*(c1+c2)
lower = (q**2+2*q-1)**2
assert B-lower == 2*q*(1-q**2)*((1-c1)+(1-c2))

for L in range(1, 5):
    root = QQbar.zeta(2*L)
    for a in (0, 1):
        for b in (0, 1):
            for k in range(L):
                z = root**(2*k+a)
                cosine_1 = AA((z+z**(-1))/2)
                assert -1 <= cosine_1 <= 1
                for l in range(L):
                    w = root**(2*l+b)
                    cosine_2 = AA((w+w**(-1))/2)
                    assert -1 <= cosine_2 <= 1
                    for value in (QQ(1)/4, QQ(1)/2, QQ(2)/3):
                        bound = (value**2+2*value-1)**2
                        evaluated = (1+value**2)**2-2*value*(1-value**2)*(cosine_1+cosine_2)
                        assert bound > 0
                        assert evaluated >= bound
print('RESULT: PASS')
