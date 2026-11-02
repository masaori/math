# 対象ラベル: arcsinh_derivative
# r' の鎖 r'(y) = (id·id)'(y)+0 = 1·y+y·1 = 2y、s' の鎖の四行 s'(y) = (√)'(r(y))·r'(y) = r'(y)/(2√r(y)) = 2y/(2√(y²+1)) = y/√(y²+1)、arcsinh' の鎖の六行
# arcsinh'(y) = log'(p(y))·p'(y) = (1+s'(y))/(y+√(y²+1)) = … = 1/√(y²+1) を確かめる。
# 帰属:
# - 関数体 L = QQ(y)[s]/(s²-y²-1) の y についての微分 d（Sage の FunctionField の derivation。s² = y²+1 から
#   2s·d(s) = 2y で d(s) が決まる）で、d(r) = 2y、d(s) が鎖の値 y/s に等しいこと、d(p) = 1 + d(s)、
#   arcsinh' の鎖の 2〜5 行目の等号を厳密に確かめる。log' = 1/w と合成の公式は本文が外部から持ち込む事実で、
#   1 行目はそれを当てはめた形 d(p)/p として置く。
# - 独立な経路として、SR の記号微分 diff(log(y+√(y²+1)), y) を y の 6 点で QQbar へ送り、1/√(y²+1) と厳密に比べる。
load("../../_shared/hyperbolic_by_definition.sage")
Fy.<y> = FunctionField(QQ); Rs.<S> = Fy[]; L.<s> = Fy.extension(S^2 - y^2 - 1)
d = L.derivation()
r = L(y^2 + 1)
Py.<yy0> = PolynomialRing(QQ)
assert (yy0 * yy0).derivative() + 0 == 1 * yy0 + yy0 * 1 == 2 * yy0      # r' の鎖（積の公式と恒等関数の導関数 1）
assert d(r) == 2 * y
s_prime_line0 = d(s)                         # (√)'(r(y))·r'(y)：合成。関数体の微分は s² = r から 2s·d(s) = d(r) で決まる
assert 2 * s * s_prime_line0 == d(r)
s_prime_line1 = (1 / (2 * s)) * d(r)
s_prime_line2 = (1 / (2 * s)) * (2 * y)
s_prime_line3 = y / s
assert s_prime_line0 == s_prime_line1 == s_prime_line2 == s_prime_line3
p = y + s
assert d(p) == 1 + d(s)
a1 = (1 / p) * d(p)                      # 1・2 行目: log'(p)·p'、log'(w) = 1/w
a2 = (1 / (y + s)) * (1 + d(s))          # 3 行目: p = id + s
a3 = (1 / (y + s)) * (1 + y / s)
a4 = (1 / (y + s)) * ((s + y) / s)
a5 = 1 / s
assert a1 == a2 == a3 == a4 == a5
assert a5 != 1 / p                       # 対照: 外側の微分だけでは 1/√(y²+1) にならない
print("r' の鎖、s' の鎖の四行、arcsinh' の鎖の六行が QQ(y)[s]/(s²-y²-1) の微分で厳密に一致する")
yy = SR.var('yy')
expr = log(yy + sqrt(yy^2 + 1)).diff(yy)
for y0 in [QQ(0), QQ(1), QQ(-1), QQ(-3)/7, QQ(25), QQ(1)/10^6]:
    assert QQbar(expr.subs(yy=y0)) == 1 / QQbar(y0^2 + 1).sqrt()
print("SR の記号微分の値が 6 点で 1/√(y²+1) と QQbar で厳密に一致する")
print("RESULT: PASS")
