# 対象ラベル: claim_dispersion_angle_log_continuous
# 本文の証明の式鎖を一行ずつ検算する。連続性は有限検算で証明できないので、
# 被対数の正値性に至る等式・不等式の各行だけを確かめる。浮動小数点は使わない。
count = 0
def check(cond, label):
    global count
    assert cond, label
    count += 1

# p ≠ 0 の式鎖（q を不定元として恒等式、p = 0 の代入行は p を消去して確認）
Pq = PolynomialRing(QQ, 'q'); q = Pq.gen()
p = q**2 + 2*q - 1
check((q+1)*(q+1) == q**2 + 2*q + 1, 'pchain1')
check(q**2 + 2*q + 1 == (q**2 + 2*q - 1) + 2, 'pchain2')
check(((q+1)*(q+1) - (p + 2)) == 0, 'pchain3')
# p は有理根を持たない（√2 の無理性と同値な内容の検算: 判別式 8 は有理数の平方でない）
check(not QQ(8).is_square(), 'no rational root')
check(len(p.roots(QQ)) == 0, 'p has no rational root')

# B − (r²+2r−1)² の五行（r, c1, c2 を不定元とする多項式恒等式）
P = PolynomialRing(QQ, names=('r', 'c1', 'c2')); r, c1, c2 = P.gens()
B = (1+r**2)**2 - 2*r*(1-r**2)*(c1+c2)
low = (r**2 + 2*r - 1)**2
L1 = (1+r**2)**2 - 2*r*(1-r**2)*(c1+c2) - (r**2+2*r-1)**2
L2 = ((1+r**2)-(r**2+2*r-1))*((1+r**2)+(r**2+2*r-1)) - 2*r*(1-r**2)*(c1+c2)
L3 = (2-2*r)*(2*r**2+2*r) - 2*r*(1-r**2)*(c1+c2)
L4 = 4*r*(1-r**2) - 2*r*(1-r**2)*(c1+c2)
L5 = 2*r*(1-r**2)*((1-c1)+(1-c2))
check(B - low == L1, 'line1'); check(L1 == L2, 'line2'); check(L2 == L3, 'line3')
check(L3 == L4, 'line4'); check(L4 == L5, 'line5')
check(1 - r**2 == (1-r)*(1+r), '1-r^2')
check(B == (B - low) + low, 'B split')

# 否定の対照: 各行の係数を一つずらすと等号が崩れる
for wrong in (L2 + r, L3 + 2*r*c1, 3*r*(1-r**2) - 2*r*(1-r**2)*(c1+c2), 2*r*(1-r**2)*((1-c1)+(2-c2))):
    check(wrong != L1, 'negative control')

# 有理点・代数的な角での不等式の行（cos は AA で厳密に）
for L in range(1, 6):
    root = QQbar.zeta(2*L)
    cosines = []
    for k in range(2*L):
        z = root**k
        c = AA((z + z**(-1))/2)
        check(c <= 1, 'cos<=1')
        cosines.append(c)
    for value in (QQ(1)/7, QQ(1)/4, QQ(1)/2, QQ(2)/3, QQ(9)/10):
        rv = AA(value)
        check(0 < rv < 1, '0<r<1')
        check(rv**2 + 2*rv - 1 != 0, 'p_r != 0')
        check((rv**2 + 2*rv - 1)**2 > 0, 'low > 0')
        check(2*rv*(1 - rv**2) > 0, 'coef > 0')
        for a in cosines:
            for b in cosines:
                Bv = (1+rv**2)**2 - 2*rv*(1-rv**2)*(a+b)
                diff = 2*rv*(1-rv**2)*((1-a)+(1-b))
                check(Bv - (rv**2+2*rv-1)**2 == diff, 'diff identity')
                check(diff >= 0, 'diff >= 0')
                check(Bv >= (rv**2+2*rv-1)**2, 'B >= low')
                check(Bv > 0, 'B > 0')
# 否定の対照: r = 1 または q = √2 − 1（有理でない）では下界が零になる
check((AA(1)**2 + 2*AA(1) - 1)**2 > 0 and 2*AA(1)*(1-AA(1)**2) == 0, 'r=1 kills coef')
s2 = AA(2).sqrt() - 1
check(s2**2 + 2*s2 - 1 == 0, 'self dual irrational point has p_r = 0')
print('checks:', count)
print('RESULT: PASS')
