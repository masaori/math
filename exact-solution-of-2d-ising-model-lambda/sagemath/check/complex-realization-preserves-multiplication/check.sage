# 対象ラベル: claim_complex_realization_preserves_multiplication
# 本文の三つの式変形を一行ずつ厳密計算で確かめる。
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
                A, B, Cc, D = L(a), L(b), L(c), L(d)
                xi = A + B * omega
                eta = Cc + D * omega
                assert decompose(xi) == (a, b) and decompose(eta) == (c, d)
                # 一つ目の式変形（ξη の係数表示）
                l0 = xi * eta
                l1 = (A + B * omega) * (Cc + D * omega)
                l2 = A * Cc + A * (D * omega) + (B * omega) * Cc + (B * omega) * (D * omega)
                l3 = A * Cc + (A * D) * omega + (B * Cc) * omega + (B * D) * omega**2
                l4 = A * Cc + (A * D) * omega + (B * Cc) * omega - B * D
                l5 = (A * Cc - B * D) + (A * D) * omega + (B * Cc) * omega
                l6 = L(a*c - b*d) + L(a*d + b*c) * omega
                assert l0 == l1 == l2 == l3 == l4 == l5 == l6
                assert decompose(l0) == (a*c - b*d, a*d + b*c)
                # 二つ目の式変形（ρ_C(ξη) = ρ_C(ξ)ρ_C(η)）
                ra, rb, rc, rd = rho_R(a), rho_R(b), rho_R(c), rho_R(d)
                m0 = rho_C(xi * eta)
                m1 = rho_R(a*c - b*d) + I_C * rho_R(a*d + b*c)
                m2 = rho_R(a*c) + rho_R(-(b*d)) + I_C * (rho_R(a*d) + rho_R(b*c))
                m3 = rho_R(a*c) - rho_R(b*d) + I_C * (rho_R(a*d) + rho_R(b*c))
                m4 = ra*rc - rb*rd + I_C * (ra*rd + rb*rc)
                m5 = ra*rc - rb*rd + I_C*ra*rd + I_C*rb*rc
                m6 = ra*rc + I_C*ra*rd + I_C*rb*rc - rb*rd
                m7 = ra*rc + I_C*ra*rd + I_C*rb*rc + I_C**2*rb*rd
                m8 = ra*rc + ra*(I_C*rd) + (I_C*rb)*rc + (I_C*rb)*(I_C*rd)
                m9 = (ra + I_C*rb) * (rc + I_C*rd)
                m10 = rho_C(xi) * rho_C(eta)
                assert m0 == m1 == m2 == m3 == m4 == m5 == m6 == m7 == m8 == m9 == m10
                count += 1
# 三つ目の式変形（単位元）
assert decompose(L(1)) == (K(1), K(0))
u0 = rho_C(L(1))
u1 = rho_R(K(1)) + I_C * rho_R(K(0))
u2 = 1 + I_C * 0
assert u0 == u1 == u2 == 1
# 否定の対照: ω² = +1 と誤って実部を ac + bd にした式は、bd != 0 のとき最後の行と一致しない
neg = 0
for a in samples:
    for b in samples:
        for c in samples:
            for d in samples:
                if b * d != 0:
                    xi = L(a) + L(b) * omega
                    eta = L(c) + L(d) * omega
                    assert rho_R(a*c + b*d) + I_C * rho_R(a*d + b*c) != rho_C(xi) * rho_C(eta)
                    neg += 1
print('checked', count, 'negative', neg)
print('RESULT: PASS')
