# claim_root_of_unity_inverse_is_real_closed_conjugate の本文の式変形を一行ずつ確かめる。
# 共役の各行は Q[a,b,c,d][w]/(w^2+1) の多項式恒等式、帰納段の各行は Q[N,c,u] の恒等式（N = c^2 の代入込み）、
# N^n の鎖と最後の鎖は QQbar の厳密計算（R として QQbar ∩ 実数、ω = i）で確かめる。浮動小数点は使わない。
P = PolynomialRing(QQ, names=('a', 'b', 'c', 'd'))
a, b, c, d = P.gens()
S = P['w'].quotient(P['w'].gen()^2 + 1, 'w')
w = S.gen()
def conj(x):
    co = x.lift()
    return S(co[0] - co[1]*w)
z = S(a + b*w); t = S(c + d*w)
count = 0
# 加法の保存の二行
assert conj(z + t) == S((a + c) - (b + d)*w); count += 1
assert S((a + c) - (b + d)*w) == conj(z) + conj(t); count += 1
# 乗法の保存の三行
assert z*t == S((a*c - b*d) + (a*d + b*c)*w); count += 1
assert conj(z*t) == S((a*c - b*d) - (a*d + b*c)*w); count += 1
assert S((a*c - b*d) - (a*d + b*c)*w) == S(a - b*w)*S(c - d*w); count += 1
assert S(a - b*w)*S(c - d*w) == conj(z)*conj(t); count += 1
# R の固定と対合
assert conj(S(a)) == S(a); count += 1
assert conj(conj(z)) == S(a + b*w) == z; count += 1
# N の二行
assert z*conj(z) == S(a + b*w)*S(a - b*w) == S(a^2 + b^2); count += 1
# 否定の対照: 符号を取り違えた共役は乗法を保たない
bad = lambda x: S(-x.lift()[0] + x.lift()[1]*w)
assert bad(z*t) != bad(z)*bad(t); count += 1

# 帰納段の四行（二つの場合）
Q = PolynomialRing(QQ, names=('cc', 'uu', 'm0'))
cc, uu, _ = Q.gens()
for m in range(1, 7):
    N = cc^2
    # 1 <_R N の場合: N^m - 1 = u^2 を仮定として、左辺 (N^{m+1}-1)-(N-1) を N(N^m-1) の形まで恒等式で、
    # 最後の二行は N^m - 1 を u^2 へ置き換えた形で比べる。
    lhs = (N^(m+1) - 1) - (N - 1)
    assert lhs == N^(m+1) - N; count += 1
    assert N^(m+1) - N == N*(N^m - 1); count += 1
    assert (cc*cc)*(uu*uu) == (cc*uu)*(cc*uu); count += 1
    lhs2 = (1 - N^(m+1)) - (1 - N)
    assert lhs2 == N - N^(m+1); count += 1
    assert N - N^(m+1) == N*(1 - N^m); count += 1
    # 否定の対照: N(N^m - 1) は N^m(N - 1) と一般には異ならないが、N^{m+1}-1 とは異なる
    assert lhs != N^(m+1) - 1; count += 1

# 具体値: R = QQbar ∩ 実数、ω = i、ζ = 1 の n 乗根
I = QQbar(-1).sqrt()
neg = 0
for n in range(1, 13):
    for k in range(n):
        zeta = QQbar.zeta(n)^k
        al = zeta.real(); be = zeta.imag()
        assert zeta == al + be*I
        cz = al - be*I
        N = zeta*cz
        assert N == al^2 + be^2; count += 1
        assert N^n == (zeta*cz)^n == zeta^n*cz^n; count += 1
        assert cz^n == (zeta^n).real() - (zeta^n).imag()*I; count += 1  # conj(ζ)^n = conj(ζ^n)
        assert zeta^n*cz^n == 1*1 == 1; count += 1
        assert al^2 + be^2 == 1; count += 1
        assert zeta^(-1) == zeta^(-1)*N == zeta^(-1)*(zeta*cz) == cz == al - be*I; count += 1
        # 否定の対照: 1 の冪根でない 2ζ ではノルムが 1 にならない
        assert (2*zeta)*(2*cz) != 1; neg += 1
print('lines checked:', count, 'negative controls:', neg + 1 + 6)
print('RESULT: PASS root of unity real-closed conjugate')
