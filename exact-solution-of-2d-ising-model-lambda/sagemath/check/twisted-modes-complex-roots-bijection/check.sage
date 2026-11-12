# 対象ラベル: claim_twisted_modes_complex_roots_bijection
# 本文の証明の各行を、辺長 1 から 8 と c ∈ {0, 1} で厳密に検算する。
# exp(2πi r)（r ∈ Q）は、QQbar の中の 1 の冪根 ζ_d^m（r = m/d）で厳密に表す。
# 代数的数の複素実現 ρ_{Q̄→C} は、QQbar の標準の複素埋め込みで代える（固定した原始根の像を指定しない本文に対し、
# 一つの埋め込みでの検算である）。
from sage.all import QQbar, QQ, ZZ, PolynomialRing

def exp_two_pi_i(r):
    r = QQ(r)
    return QQbar.zeta(r.denominator()) ** r.numerator()

lines = 0
negatives = 0
for L in range(1, 9):
    for c in (0, 1):
        sign = QQbar((-1) ** c)
        e = [exp_two_pi_i(QQ(k + QQ(c) / 2) / L) for k in range(L)]
        # e_{L,c,k}^L の四行
        for k in range(L):
            line0 = e[k] ** L
            line1 = exp_two_pi_i(QQ(k) + QQ(c) / 2)          # exp(2πi(k+c/2))
            line2 = exp_two_pi_i(k) * exp_two_pi_i(QQ(c) / 2)  # exp(2πik)exp(πic)
            line3 = exp_two_pi_i(QQ(c) / 2)                   # exp(πic)
            assert line0 == line1 == line2 == line3 == sign
            lines += 4
            # 否定の対照: e_{L,c,k} は反対の符号の方程式を満たさない
            assert e[k] ** L != -sign
            negatives += 1
        # 周期性からの j = k + nL と、範囲による n = 0
        for j in range(L):
            for k in range(L):
                if e[j] == e[k]:
                    # 指数の差 (j - k)/L は整数 n
                    n = QQ(j - k) / L
                    assert n in ZZ
                    assert j == k + n * L
                    assert -L < j - k < L
                    assert n == 0 and j == k
                    lines += 3
                else:
                    assert j != k
                    negatives += 1
        # 根の個数の上界と E_{L,c} = {e_k}
        X = PolynomialRing(QQbar, 'X').gen()
        roots = [z for z, multiplicity in (X ** L - sign).roots(ring=QQbar)]
        assert len(roots) <= L
        assert set(e) <= set(roots)
        assert len(set(e)) == L
        assert set(e) == set(roots) and len(set(roots)) == L
        lines += 4
        # モード集合 U（Q̄ の中の z^L = (-1)^c の解）の複素実現の像
        primitive = QQbar.zeta(2 * L)
        modes = [primitive ** k for k in range(2 * L) if (primitive ** k) ** L == sign]
        assert len(modes) == L                       # claim_twisted_mode_sets_card
        image = [m for m in modes]                    # 標準の埋め込みでの ρ_{Q̄→C}
        assert all(z ** L == sign for z in image)     # 像は E に含まれる
        assert len(set(image)) == len(modes)          # 単射
        assert set(image) == set(roots)               # 像は E に一致（全射）
        lines += 4
print('lines checked:', lines, 'negative controls:', negatives)
print('RESULT: PASS')
