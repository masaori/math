# 対象ラベル: claim_onsager_hyperbolic_integral_form
# 積分に入る有理式と、一定項の積分係数を厳密に検算する。
P.<q,u,v> = PolynomialRing(QQ)
F = P.fraction_field()
C = (1 + q^2)/(2*q)
S = (1 - q^2)/(2*q)
H = C^2 - S*(u+v)
B = (1+q^2)^2 - 2*q*(1-q^2)*(u+v)
assert F(B - 4*q^2*H) == 0
assert QQ(4)/8 == QQ(1)/2
# log(4q^2)/2 = log(2)+log(q) は q>0 の積法則から従う。
R = RealField(180)
for a in (QQ(1)/5, QQ(1)/2, QQ(4)/5):
    k = -R(a).log()/2
    assert abs((k*2).cosh()-R(C(q=a))) < R(10)^(-45)
    assert abs((k*2).sinh()-R(S(q=a))) < R(10)^(-45)
    assert abs(R(4*a*a).log()/2-R(2).log()-R(a).log()) < R(10)^(-45)
print('RESULT: PASS')
