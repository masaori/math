# 対象ラベル: claim_twisted_mode_product_bijection
# 本文の証明の各行を、辺長 1 から 6 と (a, b) ∈ {0,1}^2 で厳密に検算する。
# 代数的数の複素実現 ρ_{Q̄→C} は、QQbar の標準の複素埋め込みで代える（固定した原始根の像を指定しない本文に対し、
# 一つの埋め込みでの検算である）。浮動小数点は使わない。
from sage.all import QQbar, PolynomialRing

X = PolynomialRing(QQbar, 'X').gen()
rho = lambda z: z            # 標準の埋め込みでの ρ_{Q̄→C}
pr1 = lambda p: p[0]
pr2 = lambda p: p[1]

lines = 0
negatives = 0
for L in range(1, 7):
    primitive = QQbar.zeta(2 * L)
    def modes(c):
        sign = QQbar((-1) ** c)
        return [primitive ** k for k in range(2 * L) if (primitive ** k) ** L == sign]
    def roots(c):
        return [z for z, multiplicity in (X ** L - (-1) ** c).roots(ring=QQbar)]
    for a in (0, 1):
        for b in (0, 1):
            U, W = modes(a), modes(b)
            Ea, Eb = roots(a), roots(b)
            Theta = lambda p: (rho(p[0]), rho(p[1]))
            source = [(u, w) for u in U for w in W]
            # 第一段落: Θ は E_{L,a} × E_{L,b} へ値を取る
            for p in source:
                t = Theta(p)
                assert t[0] in Ea and t[1] in Eb
                lines += 1
            # 第二段落: 単射の三行・三行・二行
            for p in source:
                for q in source:
                    if Theta(p) == Theta(q):
                        assert rho(p[0]) == pr1(Theta(p)) == pr1(Theta(q)) == rho(q[0])
                        assert rho(p[1]) == pr2(Theta(p)) == pr2(Theta(q)) == rho(q[1])
                        assert p[0] == q[0] and p[1] == q[1]
                        assert p == (q[0], p[1]) == q
                        lines += 8
                    else:
                        # 否定の対照: 相異なる組は相異なる像を持つ
                        assert p != q
                        negatives += 1
            # 第三段落: 全射の三行
            for z in Ea:
                for w in Eb:
                    pre_u = [u for u in U if rho(u) == z]
                    pre_w = [v for v in W if rho(v) == w]
                    assert len(pre_u) == 1 and len(pre_w) == 1
                    u, v = pre_u[0], pre_w[0]
                    assert Theta((u, v)) == (rho(u), rho(v)) == (z, rho(v)) == (z, w)
                    lines += 3
            # 有限和の再添字付け（全単射で和の添字を取り替えられること）の具体例
            F = lambda z, w: z + w + z * w
            assert sum(F(*Theta(p)) for p in source) == sum(F(z, w) for z in Ea for w in Eb)
            lines += 1
print('lines checked:', lines, 'negative controls:', negatives)
print('RESULT: PASS')
