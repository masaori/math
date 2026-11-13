# 対象ラベル: claim_dispersion_minimum_self_dual_point
# 本文の証明の式鎖を一行ずつ検算する。実閉部分体 R の元は AA（実代数的数）で厳密に扱い、
# 実現写像 ρ_{R→ℝ} は AA の元をそのまま実数として読む（有理数上の一致と四則の保存の検算に使う）。
# 角の余弦は 1 の冪根の実部として AA で厳密に扱う。浮動小数点は使わない。
count = 0
def check(cond, label):
    global count
    assert cond, label
    count += 1

s = AA(2).sqrt()
xc = -1 + s
check(s * s == 2, 's*s=2')

# 第一の事実・第二の事実: 0 < r < 1、c = 2r(1-r^2) = 2r((1-r)(1+r)) > 0
samples = [AA(1)/7, AA(1)/4, AA(1)/2, AA(2)/3, AA(9)/10, xc, AA(3).sqrt()/2, (AA(5).sqrt()-1)/2, AA(2).nth_root(3) - 1]
Pr = PolynomialRing(QQ, 'r'); rr = Pr.gen()
check(2*rr*(1-rr**2) == 2*rr*((1-rr)*(1+rr)), 'c factor')
for xi in samples:
    check(0 < xi < 1, '0<xi<1 (R order)')
    r = xi
    check(0 == AA(0) and AA(0) < r and r < AA(1) and AA(1) == 1, 'first fact chain')
    c = 2*r*(1-r**2)
    check(c == 2*r*((1-r)*(1+r)), 'c line2')
    check(0 < 1 - r and 0 < 1 + r and c > 0, 'c > 0')

# 第三の事実の七行（ξ を不定元とし、ρ を恒等とした多項式恒等式）
Px = PolynomialRing(QQ, 'xi'); X = Px.gen()
p = 1 - 2*X - X*X
r = X
lines = [p,
         p + (2*r + r*r) - (2*r + r*r),
         p + (2*r + r*r) - (2*r + r*r),
         p + (2*X + X*X) - (2*r + r*r),
         p + (2*X + X*X) - (2*r + r*r),
         (p + (2*X + X*X)) - (2*r + r*r),
         1 - (2*r + r*r),
         1 - 2*r - r**2]
for a, b in zip(lines, lines[1:]):
    check(a == b, 'third fact line')
check(p + (2*X + X*X) == 1, 'p + (2xi + xi xi) = 1')
check(X*X + 2*X - 1 == -p, 'quadratic = -p')
# 否定の対照
check(p + (2*X + X*X) + X != 1, 'neg control third')

# 第四の事実: s≠0、(-2)-(-1-s) = -1+s = xc = xc-0 = w*w、0-(-2) = 2 = s*s、-1-s < -2 < 0
check(s != 0, 's != 0')
check(AA(0) * AA(0) == 0 and AA(2) != 0, 's=0 contradiction lines')
w = xc.sqrt()
check(w != 0 and xc > 0, 'xc > 0')
check((-2) - (-1 - s) == -1 + s, 'fourth line1')
check(-1 + s == xc and xc - 0 == xc and xc - 0 == w*w, 'fourth line2-4')
check(0 - (-2) == 2 and 2 == s*s, 'fourth line5-6')
check(-1 - s < -2 and -2 < 0 and -1 - s < 0, 'fourth order')

# 第五の事実: ξ = -1-s は 0 <_R ξ を満たさない。0 <_R 0 なら v*v = 0 - 0 = 0
check(not (0 < -1 - s), 'fifth fact')
check(all(v*v != 0 for v in [AA(1), s, w, AA(-3)/5]), 'no zero divisors')

# 最小値の六行（r, c1, c2 を不定元とする多項式恒等式）
P = PolynomialRing(QQ, names=('r', 'c1', 'c2')); R_, c1, c2 = P.gens()
cc = 2*R_*(1-R_**2)
B = (1+R_**2)**2 - 2*R_*(1-R_**2)*(c1+c2)
gap = (1-2*R_-R_**2)**2
L1 = (1+R_**2)**2 - cc*(c1+c2) - (1-2*R_-R_**2)**2
L2 = ((1+R_**2)-(1-2*R_-R_**2))*((1+R_**2)+(1-2*R_-R_**2)) - cc*(c1+c2)
L3 = (2*R_+2*R_**2)*(2-2*R_) - cc*(c1+c2)
L4 = 4*R_*(1-R_**2) - cc*(c1+c2)
L5 = cc*((1-c1)+(1-c2))
check(B - gap == L1, 'six line1'); check(L1 == L2, 'six line2'); check(L2 == L3, 'six line3')
check(L3 == L4, 'six line4'); check(L4 == L5, 'six line5')
for wrong in (L2 + R_, L3 + 2*R_*c1, 3*R_*(1-R_**2) - cc*(c1+c2), cc*((1-c1)+(2-c2))):
    check(wrong != L1, 'negative control six')
# B(0,0) の四行
B00 = B(c1=1, c2=1)
M1 = (B00 - gap) + gap
M2 = cc*((1-1)+(1-1)) + gap
check(B00 == M1 and M1 == (L5(c1=1, c2=1) + gap) and L5(c1=1, c2=1) + gap == M2 and M2 == gap, 'B(0,0) four lines')
check(gap == (R_**2 + 2*R_ - 1)**2, 'gap symmetric form')

# 角での下界（1 の冪根の実部で角を表す）と (0,0) での達成
for L in range(1, 6):
    cosines = [AA((z + z**(-1))/2) for z in [QQbar.zeta(2*L)**k for k in range(2*L)]]
    check(max(cosines) == 1, 'cos 0 = 1 attained')
    for xi in samples:
        r = xi
        g = (1-2*r-r**2)**2
        for a in cosines:
            check(a <= 1, 'cos<=1')
            for b in cosines:
                Bv = (1+r**2)**2 - 2*r*(1-r**2)*(a+b)
                check(Bv - g == 2*r*(1-r**2)*((1-a)+(1-b)), 'diff identity')
                check(Bv >= g, 'B >= gap')
        check((1+r**2)**2 - 2*r*(1-r**2)*(1+1) == g, 'B(0,0) = gap')

# 零条件の七行の同値
for xi in samples:
    r = xi
    g = (1-2*r-r**2)**2
    pv = 1 - 2*xi - xi*xi
    chain = [g == 0, 1-2*r-r**2 == 0, pv == 0, xi*xi + 2*xi - 1 == 0,
             (xi == -1 + s or xi == -1 - s), xi == -1 + s, xi == xc]
    check(len(set(chain)) == 1, 'equivalence chain')
check(samples.count(xc) == 1, 'xc in samples')
# 二根
Pq = PolynomialRing(AA, 'y'); y = Pq.gen()
check(set(root for root, _ in (y**2 + 2*y - 1).roots()) == {-1 + s, -1 - s}, 'roots')
# 否定の対照: ξ = -1-s は二次方程式を満たすが正でない
check((-1-s)**2 + 2*(-1-s) - 1 == 0 and (-1 - s) < 0, 'negative root excluded')

# 双対性: 1 + x_c = 1 + (-1+s) = s ≠ 0、x_c は二次方程式の根、KW(x_c) = x_c
check(1 + xc == 1 + (-1 + s) and 1 + (-1 + s) == s and s != 0, 'domain lines')
check(xc*xc + 2*xc - 1 == 0, 'xc quadratic')
check((1 - xc) / (1 + xc) == xc, 'KW(xc) = xc')
check((1 - AA(1)/2) / (1 + AA(1)/2) != AA(1)/2, 'negative control KW')
print('checks:', count)
print('RESULT: PASS')
