# 対象ラベル: claim_complex_realization_preserves_addition
# 本文の二つの式変形を一行ずつ厳密計算で確かめる。
# R として実の数体 K = Q(√2 + √3)（実埋め込みを固定した実代数的数の部分体）、
# omega として K 上の二次拡大 L = K(ω)、ω² = -1 を取る。一意表示 ξ = a + bω の係数は L の K 上の座標。
# 複素数側は同じ L を使い、i を ω で表す。rho_R は K → L の包含（K の元の実数値はその値そのもの）。
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

samples = [K(0), K(1), K(-1), K(1)/3, s2, -s3, s2*s3 - K(7)/2]
count = 0
for a in samples:
    for b in samples:
        for c in samples:
            for d in samples:
                xi = L(a) + L(b) * omega
                eta = L(c) + L(d) * omega
                # 一意表示
                assert decompose(xi) == (a, b) and decompose(eta) == (c, d)
                # 一つ目の式変形
                l0 = xi + eta
                l1 = (L(a) + L(b) * omega) + (L(c) + L(d) * omega)
                l2 = L(a + c) + L(b) * omega + L(d) * omega
                l3 = L(a + c) + L(b + d) * omega
                assert l0 == l1 == l2 == l3
                assert decompose(l0) == (a + c, b + d)
                # 二つ目の式変形
                m0 = rho_C(xi + eta)
                m1 = rho_R(a + c) + I_C * rho_R(b + d)
                m2 = (rho_R(a) + rho_R(c)) + I_C * (rho_R(b) + rho_R(d))
                m3 = (rho_R(a) + rho_R(c)) + (I_C * rho_R(b) + I_C * rho_R(d))
                m4 = (rho_R(a) + I_C * rho_R(b)) + (rho_R(c) + I_C * rho_R(d))
                m5 = rho_C(xi) + rho_C(eta)
                assert m0 == m1 == m2 == m3 == m4 == m5
                count += 1
# 否定の対照: 実部と虚部の係数の和を入れ替えた式は、c != d のとき最後の行と一致しない
neg = 0
for a in samples[:3]:
    for b in samples[:3]:
        for c in samples:
            for d in samples:
                if c != d:
                    xi = L(a) + L(b) * omega
                    eta = L(c) + L(d) * omega
                    assert rho_R(a + d) + I_C * rho_R(b + c) != rho_C(xi) + rho_C(eta)
                    neg += 1
print('checked', count, 'negative', neg)
print('RESULT: PASS')
