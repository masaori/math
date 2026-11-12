# 対象ラベル: claim_real_algebraic_rational_bounds
# 本文の証明の式変形を一行ずつ、有理係数の多項式の例と有理点で厳密に確かめる（QQ と QQbar）。
# 有限例の検算であり、任意の多項式に対する証明は本文の論証が担う。
P.<X> = PolynomialRing(QQ)
T.<Y> = PolynomialRing(QQ)
examples = [
    X^2 - 2,
    3*X^3 - 7*X + 1,
    -2*X^4 + X^2 - 5,
    X - QQ(3)/5,
    X^5 - X^4 + QQ(1)/3*X^2 - 4,
]
count = 0
for p in examples:
    d = p.degree()
    c = [p[j] for j in range(d + 1)]
    assert d >= 1 and c[d] != 0
    alpha = [c[j] / c[d] for j in range(d)]
    S = sum(abs(a) for a in alpha)
    B = 1 + S
    assert S >= 0 and B > 0
    # 三つの等式（記号 x のまま多項式として）
    assert Y - 1 == (Y - B) + S; count += 1
    assert Y - S == 1 + (Y - B); count += 1
    assert Y == (Y - S) + S; count += 1
    # 冪の帰納段
    for m in range(6):
        assert Y^(m + 1) - 1 == Y*(Y^m - 1) + (Y - 1); count += 1
    # 各項の分解（二行）
    for j in range(d):
        a = alpha[j]
        lhs = abs(a)*Y^(d - 1) + a*Y^j
        mid = abs(a)*Y^j*Y^(d - 1 - j) + a*Y^j
        rhs = abs(a)*Y^j*(Y^(d - 1 - j) - 1) + (abs(a) + a)*Y^j
        assert lhs == mid and mid == rhs; count += 2
        assert abs(a) >= 0 and abs(a) + a >= 0; count += 1
    # 主鎖の二つの等号
    monic = Y^d + sum(alpha[j]*Y^j for j in range(d))
    assert p.change_ring(QQ)(Y) / c[d] == monic; count += 1
    assert monic == Y^(d - 1)*(Y - S) + sum(abs(alpha[j])*Y^(d - 1) + alpha[j]*Y^j for j in range(d)); count += 1
    # B 以上の有理点で、各段の符号
    for x in [B, B + QQ(1)/7, 2*B + 1, 5*B]:
        assert x - 1 >= 0 and x - S > 0 and x > 0
        assert all(x^m - 1 >= 0 and x^m > 0 for m in range(d + 1))
        assert all(abs(alpha[j])*x^(d - 1) + alpha[j]*x^j >= 0 for j in range(d))
        assert x^(d - 1)*(x - S) > 0
        assert monic(x) > 0 and p(x) != 0; count += 1
    # 負側: p(-X) の係数と係数比の絶対値の和
    q = p(-X)
    assert all(q[j] == (-1)^j*c[j] for j in range(d + 1)) and q[d] != 0
    assert sum(abs(q[j] / q[d]) for j in range(d)) == S; count += 1
    # 実の根（QQbar）がすべて -B < z < B
    for z, mult in p.roots(QQbar):
        if z.imag() == 0:
            zr = AA(z)
            assert -B < zr < B
            assert zr - (-B) == B - (-zr); count += 1
print('等号・不等号の確認', count, '件')
print('RESULT: PASS')
