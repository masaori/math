# 対象ラベル: claim_complex_realization_injective
# 本文の三つの式変形と、単射性から係数の一致を経て ξ = η に戻る段を一行ずつ厳密計算で確かめる。
# R として実の数体 K = Q(√2 + √3)（実埋め込みを固定した実代数的数の部分体）、
# omega として K 上の二次拡大 L = K(ω)、ω² = -1 を取る。一意表示 ξ = a + bω の係数は L の K 上の座標。
# 複素数側は同じ L を使い、i を ω で表す。rho_R は K → L の包含（K の元の実数値はその値そのもの）。
# 複素数 z = x + iy（x, y ∈ K）の実部・虚部は、L の K 上の座標の第一・第二成分で表す。
# 厳密計算だけで、浮動小数点は使わない。
x = polygen(QQ)
K = NumberField(x**4 - 10*x**2 + 1, 't', embedding=RR(sqrt(2) + sqrt(3)))
t = K.gen()
s2 = (t**3 - 9*t) / 2
s3 = (11*t - t**3) / 2
assert s2**2 == 2 and s3**2 == 3
y = polygen(K)
L = K.extension(y**2 + 1, 'omega')
omega = L.gen()
assert omega**2 == -1
I_C = omega

def rho_R(r):
    return L(r)

def decompose(xi):
    a, b = xi.list()
    assert L(a) + L(b) * omega == xi
    return a, b

def rho_C(xi):
    a, b = decompose(xi)
    return rho_R(a) + I_C * rho_R(b)

def Re(z):
    return z.list()[0]

def Im(z):
    return z.list()[1]

samples = [K(0), K(1), K(-1), K(1)/3, s2, -s3, s2*s3 - K(7)/2]
# rho_R の単射性（実現写像の単射性の有限例。K → L の包含）
for r in samples:
    for u in samples:
        assert (rho_R(r) == rho_R(u)) == (r == u)
count = 0
equal_count = 0
for a in samples:
    for b in samples:
        for c in samples:
            for d in samples:
                xi = L(a) + L(b) * omega
                eta = L(c) + L(d) * omega
                assert decompose(xi) == (a, b) and decompose(eta) == (c, d)
                # 一つ目の式変形の両端は、それぞれの定義の行と一致する
                assert rho_R(a) + I_C * rho_R(b) == rho_C(xi)
                assert rho_C(eta) == rho_R(c) + I_C * rho_R(d)
                # 実部・虚部の定義の行（どの組でも成り立つ）
                assert rho_R(a) == Re(rho_R(a) + I_C * rho_R(b))
                assert rho_R(b) == Im(rho_R(a) + I_C * rho_R(b))
                assert Re(rho_R(c) + I_C * rho_R(d)) == rho_R(c)
                assert Im(rho_R(c) + I_C * rho_R(d)) == rho_R(d)
                if rho_C(xi) == rho_C(eta):
                    equal_count += 1
                    # 一つ目の式変形
                    assert rho_R(a) + I_C * rho_R(b) == rho_C(xi) == rho_C(eta) == rho_R(c) + I_C * rho_R(d)
                    # 二つ目・三つ目の式変形
                    assert rho_R(a) == Re(rho_R(a) + I_C * rho_R(b)) == Re(rho_R(c) + I_C * rho_R(d)) == rho_R(c)
                    assert rho_R(b) == Im(rho_R(a) + I_C * rho_R(b)) == Im(rho_R(c) + I_C * rho_R(d)) == rho_R(d)
                    # 単射性から a = c, b = d、最後の式変形
                    assert a == c and b == d
                    assert xi == L(a) + L(b) * omega == L(c) + L(d) * omega == eta
                else:
                    assert xi != eta
                count += 1
# 否定の対照: 実部だけ、または虚部だけが一致する組では像が一致しない
neg = 0
for a in samples:
    for b in samples:
        for d in samples:
            if b != d:
                assert rho_C(L(a) + L(b) * omega) != rho_C(L(a) + L(d) * omega)
                assert rho_C(L(b) + L(a) * omega) != rho_C(L(d) + L(a) * omega)
                neg += 2
print('checked', count, 'equal', equal_count, 'negative', neg)
print('RESULT: PASS')
