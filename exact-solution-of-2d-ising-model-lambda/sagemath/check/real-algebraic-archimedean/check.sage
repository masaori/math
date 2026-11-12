# 対象ラベル: claim_real_algebraic_archimedean
# 本文の証明の各行を、実代数的数（AA）の有限例について厳密に確かめる。
# <_R は「差が零でない平方」（def_real_algebraic_strict_order）として AA の中で判定する。
R.<X> = PolynomialRing(QQ)

def lt_R(u, v):
    # v - u = w*w、w != 0 となる w が AA にあるか（実閉部分体の狭義順序の定義）
    d = AA(v) - AA(u)
    if d <= 0:
        return False
    w = d.sqrt()
    assert w != 0 and w * w == d
    return True

examples = [X^2 - 2, 3*X^3 - 7*X + 1, 5*X - 3, X^4 - 10*X^2 + 1, 7*X^2 + 100*X - 3]
count = 0
negative_controls = 0
for p in examples:
    d = p.degree()
    S = sum(abs(p[j] / p[d]) for j in range(d))
    B = 1 + S                       # claim_real_algebraic_rational_bounds の B
    h, k = B.numerator(), B.denominator()
    N = h + 1
    assert h > 0 and k > 0 and N > 0
    # 有理数の順序: B = h/k <= h < N
    assert B == QQ(h) / k; count += 1
    assert QQ(h) / k <= h; count += 1
    assert h < N; count += 1
    # 0 <_R N - B
    assert N - B > 0 and lt_R(0, N - B); count += 1
    # (-B) - (-N) = N - B
    assert (-B) - (-N) == N - B; count += 1
    # 否定の対照: N の代わりに h を取ると、k = 1 のとき B <_R h が成り立たない（+1 が要る）
    if not lt_R(B, h):
        negative_controls += 1
    for a, _ in p.roots(AA):
        assert lt_R(-N, -B); count += 1      # 狭義順序の定義
        assert lt_R(-B, a); count += 1       # 有理上下界
        assert lt_R(a, B); count += 1        # 有理上下界
        assert lt_R(B, N); count += 1        # 狭義順序の定義
        assert lt_R(-N, a) and lt_R(a, N); count += 1   # 推移律
assert negative_controls > 0
print('checks:', count, 'negative controls:', negative_controls)
print('RESULT: PASS')
