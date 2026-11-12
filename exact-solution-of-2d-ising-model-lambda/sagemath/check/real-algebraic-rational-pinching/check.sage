# 対象ラベル: claim_real_algebraic_rational_pinching
# 本文の証明の各行を、実代数的数（AA）の有限例について厳密に確かめる。
# <_R は「差が零でない平方」（def_real_algebraic_strict_order）、<=_R は「<_R または等しい」
# （def_real_algebraic_nonstrict_order）として AA の中で判定する。
R.<X> = PolynomialRing(QQ)

def lt_R(u, v):
    d = AA(v) - AA(u)
    if d <= 0:
        return False
    w = d.sqrt()
    assert w != 0 and w * w == d
    return True

def le_R(u, v):
    return lt_R(u, v) or AA(u) == AA(v)

examples = [
    (X^2 - 2, QQ(1)),
    (3*X^3 - 7*X + 1, QQ(1)/7),
    (5*X - 3, QQ(1)/100),
    (5*X - 3, QQ(3)/5),
    (X^4 - 10*X^2 + 1, QQ(2)/3),
    (7*X^2 + 100*X - 3, QQ(1)/10),
]
count = 0
negative_controls = 0
for p, epsilon in examples:
    d = p.degree()
    S = sum(abs(p[j] / p[d]) for j in range(d))
    B = 1 + S
    M = B.numerator() + 1           # claim_real_algebraic_archimedean の N
    e, f = epsilon.numerator(), epsilon.denominator()
    n = 2*f + 1
    # 有理数の順序の鎖 0 < 2/n = 2/(2f+1) < 1/f <= e/f = ε
    assert 0 < QQ(2)/n; count += 1
    assert QQ(2)/n == QQ(2)/(2*f + 1); count += 1
    assert QQ(2)/(2*f + 1) < QQ(1)/f; count += 1
    assert QQ(1)/f <= QQ(e)/f; count += 1
    assert QQ(e)/f == epsilon; count += 1
    for a, _ in p.roots(AA):
        assert lt_R(-M, a) and lt_R(a, M); count += 1          # Archimedes 性
        J = [j for j in range(-M*n, M*n + 1) if le_R(QQ(j)/n, a)]
        assert QQ(-M*n)/n == -M and (-M*n) in J; count += 1     # −Mn ∈ J
        j0 = max(J)
        # j0 ≠ Mn（j0 = Mn なら M <=_R a <_R M）
        assert j0 != M*n and not le_R(M, a); count += 1
        assert -M*n <= j0 < j0 + 1 <= M*n; count += 1
        r, s = QQ(j0 - 1)/n, QQ(j0 + 1)/n
        assert (j0 + 1) not in J and not le_R(s, a); count += 1  # 最大性
        assert lt_R(a, s); count += 1                            # 三分法
        assert lt_R(0, QQ(1)/n); count += 1                      # 正の有理数の正値性
        assert QQ(1)/n == QQ(j0)/n - r; count += 1
        assert lt_R(r, QQ(j0)/n); count += 1                     # 狭義順序の定義
        assert le_R(QQ(j0)/n, a); count += 1                     # j0 ∈ J
        assert lt_R(r, a); count += 1                            # 推移律
        assert s - r == QQ(2)/n; count += 1
        assert s - r < epsilon and 0 < s - r; count += 1
        # 否定の対照: s の代わりに j0/n を取ると a <_R s が成り立たない（+1 が要る）
        if not lt_R(a, QQ(j0)/n):
            negative_controls += 1
assert negative_controls > 0
print('checks:', count, 'negative controls:', negative_controls)
print('RESULT: PASS')
