# claim_dispersion_positive_at_rational_point の本文の式変形を一行ずつ確かめる。
# 記号の行は Q[q,α,β,γ,δ][ω]/(ω^2+1) の恒等式（α^2+β^2=1 は仮定として差を比べる）、
# 具体値の行は QQbar の厳密計算（R として QQbar ∩ 実数、ω = i）で確かめる。浮動小数点は使わない。
P = PolynomialRing(QQ, names=('q', 'alpha', 'beta', 'gamma', 'delta', 'cvp', 'cvs', 's', 'e'))
q, alpha, beta, gamma, delta, cvp, cvs, s, e = P.gens()
S = P['w'].quotient(P['w'].gen()^2 + 1, 'w')
w = S.gen()
count = 0
neg = 0
vp = S(alpha + beta*w); vp_inv = S(alpha - beta*w)
vs = S(gamma + delta*w); vs_inv = S(gamma - delta*w)
# 2 - ϖ - ϖ^{-1} の行（第三行は α^2+β^2=1 の代入なので差が (α^2+β^2-1) の倍であることを見る）
assert S(2) - vp - vp_inv == S(2 - 2*alpha); count += 1
assert S(1 - 2*alpha + (alpha^2 + beta^2)) - S(2 - 2*alpha) == S(alpha^2 + beta^2 - 1); count += 1
assert 1 - 2*alpha + (alpha^2 + beta^2) == (1 - alpha)^2 + beta^2; count += 1
assert S(2) - vs - vs_inv == S(2 - 2*gamma); count += 1
assert S(1 - 2*gamma + (gamma^2 + delta^2)) - S(2 - 2*gamma) == S(gamma^2 + delta^2 - 1); count += 1
assert 1 - 2*gamma + (gamma^2 + delta^2) == (1 - gamma)^2 + delta^2; count += 1
# q(1-q^2) = q(1-q)(1+q)
assert q*(1 - q^2) == q*(1 - q)*(1 + q); count += 1
# 正値分解を x := q で評価した行（Δ は def_dispersion_polynomial）
D = (1 + q^2)^2 - q*(1 - q^2)*(vp + vp_inv + vs + vs_inv)
pp = q^2 + 2*q - 1
assert D - S(pp^2) == S(q*(1 - q^2))*((S(2) - vp - vp_inv) + (S(2) - vs - vs_inv)); count += 1
# (s s)(e e) = (se)(se)
assert (s*s)*(e*e) == (s*e)*(s*e); count += 1
# p = 0 の矛盾の三行
assert (q + 1)*(q + 1) == q^2 + 2*q + 1 == pp + 2; count += 1
# 否定の対照: 符号を取り違えた分解は成り立たない
assert D - S(pp^2) != S(q*(1 - q^2))*((S(2) + vp + vp_inv) + (S(2) - vs - vs_inv)); neg += 1

# 具体値
I = QQbar(-1).sqrt()
def is_real_square(x):
    # x ∈ R（実代数的数）が R の元の平方か（零を含む）
    return x.imag() == 0 and x.real() >= 0
points = [QQ(1)/7, QQ(1)/5, QQ(1)/3, QQ(2)/5, QQ(1)/2, QQ(3)/5, QQ(4)/5, QQ(9)/10]
for L in range(1, 5):
    for a in (0, 1):
        for b in (0, 1):
            for j in range(L):
                for k in range(L):
                    vpv = QQbar.zeta(2*L)^(2*j + a)
                    vsv = QQbar.zeta(2*L)^(2*k + b)
                    assert vpv^(2*L) == 1 and vsv^(2*L) == 1; count += 1
                    al, be = vpv.real(), vpv.imag()
                    ga, de = vsv.real(), vsv.imag()
                    assert vpv == al + be*I and vpv^(-1) == al - be*I and al^2 + be^2 == 1; count += 1
                    assert vsv == ga + de*I and vsv^(-1) == ga - de*I and ga^2 + de^2 == 1; count += 1
                    c1 = ((1 - al)^2 + be^2).sqrt(); c2 = ((1 - ga)^2 + de^2).sqrt()
                    assert c1.imag() == 0 and c2.imag() == 0; count += 1
                    A = 2 - vpv - vpv^(-1); B = 2 - vsv - vsv^(-1)
                    assert A == 2 - (al + be*I) - (al - be*I) == 2 - 2*al == 1 - 2*al + (al^2 + be^2) == (1 - al)^2 + be^2 == c1*c1; count += 1
                    assert B == 2 - (ga + de*I) - (ga - de*I) == 2 - 2*ga == 1 - 2*ga + (ga^2 + de^2) == (1 - ga)^2 + de^2 == c2*c2; count += 1
                    ev = (c1*c1 + c2*c2).sqrt()
                    assert ev.imag() == 0 and ev*ev == c1*c1 + c2*c2; count += 1
                    for qq in points:
                        r = qq*(1 - qq)*(1 + qq)
                        assert r > 0; count += 1
                        sv = QQbar(r).sqrt()
                        assert sv.imag() == 0 and sv != 0 and sv*sv == r; count += 1
                        assert qq*(1 - qq^2) == qq*(1 - qq)*(1 + qq) == r == sv*sv; count += 1
                        Dv = (1 + qq^2)^2 - qq*(1 - qq^2)*(vpv + vpv^(-1) + vsv + vsv^(-1))
                        p = qq^2 + 2*qq - 1
                        assert Dv - p^2 == qq*(1 - qq^2)*(A + B) == (sv*sv)*(c1*c1 + c2*c2) == (sv*sv)*(ev*ev) == (sv*ev)*(sv*ev); count += 1
                        assert Dv.imag() == 0 and Dv == p^2 + (sv*ev)*(sv*ev); count += 1
                        assert p != 0 and (qq + 1)*(qq + 1) == qq^2 + 2*qq + 1 == p + 2 != 2; count += 1
                        assert p^2 - 0 == p*p and p^2 > 0 and Dv.real() >= p^2; count += 1
                    # 否定の対照: q = 2（区間の外）では r < 0 で R の平方にならない
                    r_out = QQ(2)*(1 - 2)*(1 + 2)
                    assert not is_real_square(QQbar(r_out)); neg += 1
# 否定の対照: 自己双対点 q = √2 - 1（有理数でない）では p = 0 になる
qs = QQbar(2).sqrt() - 1
assert qs^2 + 2*qs - 1 == 0 and qs not in QQ; neg += 1
print('lines checked:', count, 'negative controls:', neg)
print('RESULT: PASS dispersion positive at rational point')
