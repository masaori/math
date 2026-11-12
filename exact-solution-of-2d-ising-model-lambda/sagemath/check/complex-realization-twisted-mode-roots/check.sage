# 対象ラベル: claim_complex_realization_twisted_modes_are_complex_roots
# 本文の四つの式変形（冪の保存の帰納法の零乗の段と冪の段、(-1)^c の実現、横・縦モードの結論）を
# 一行ずつ厳密計算で確かめる。
# R として実の数体 K = Q(√2 + √3)（実埋め込みを固定した実代数的数の部分体）、
# 代数的数として K 上の二次拡大 F = K(ω)、ω² = -1 を取る。F = Q(√2, √3, i) = Q(ζ_24) なので、
# 2L が 24 を割る辺長 L ∈ {1, 2, 3, 4, 6, 12} では、z^L = ±1 の L 個の根がすべて F に入る。
# 一意表示 ξ = a + bω の係数は F の K 上の座標。複素数側は同じ F を使い、i を ω で表す。
# rho_R は K → F の包含（K の元の実数値はその値そのもの）。浮動小数点は使わない。
x = polygen(QQ)
K = NumberField(x**4 - 10*x**2 + 1, 't', embedding=RR(sqrt(2) + sqrt(3)))
y = polygen(K)
F = K.extension(y**2 + 1, 'omega')
omega = F.gen()
assert omega**2 == -1
I_C = omega

def rho_R(r):
    return F(r)

def decompose(xi):
    a, b = xi.list()
    assert F(a) + F(b) * omega == xi
    return a, b

def rho_C(xi):
    a, b = decompose(xi)
    return rho_R(a) + I_C * rho_R(b)

Y = polygen(F)
count = 0
neg = 0
for Lside in (1, 2, 3, 4, 6, 12):
    for c in (0, 1):
        sign = QQ((-1)**c)
        # (-1)^c の実現: 係数表示 (-1)^c + 0ω、定義、有理数上の一致、ℂ の零元
        assert decompose(F(sign)) == (K(sign), K(0))
        assert rho_C(F(sign)) == rho_R(K(sign)) + I_C * rho_R(K(0))
        assert rho_R(K(sign)) + I_C * rho_R(K(0)) == F(sign) + I_C * 0
        assert F(sign) + I_C * 0 == F(sign)
        modes = [r for r, m in (Y**Lside - sign).roots()]
        assert len(modes) == Lside and all(m == 1 for r, m in (Y**Lside - sign).roots())
        for z in modes:
            # 零乗の段
            assert rho_C(z**0) == rho_C(F(1)) == 1 == rho_C(z)**0
            # 冪の段（n = 0, …, L-1）
            for n in range(Lside):
                assert rho_C(z**(n + 1)) == rho_C(z**n * z)
                assert rho_C(z**n * z) == rho_C(z**n) * rho_C(z)
                assert rho_C(z**n) * rho_C(z) == rho_C(z)**n * rho_C(z)
                assert rho_C(z)**n * rho_C(z) == rho_C(z)**(n + 1)
            # 結論の三行（横・縦は同じ形。a または b が c）
            assert rho_C(z)**Lside == rho_C(z**Lside)
            assert rho_C(z**Lside) == rho_C(F(sign))
            assert rho_C(F(sign)) == sign
            # 否定の対照: 反対の符号の方程式の根ではない
            assert rho_C(z)**Lside != -sign
            neg += 1
            count += 1
print('checked modes', count, 'negative', neg)
print('RESULT: PASS')
