# 対象ラベル: cosh_sinh_coefficient_conversion_for_check
# 主張 (h1.z)・(h1.y)・(h2.z)・(h2.y) の奇数・偶数の場合の鎖の全行と主張そのものを、M_col = 2..5、全 μ、n = 0..N_MAX で厳密に確かめる。
# (K_1)_C・(K_2^*)_C は円分体 L = QQ(ζ_{4M}) 上の多項式環の不定元 k1・k2、位相 e_∓ = exp(∓i(θ̃_μ)_C) は 1 の冪根（_shared/half_integer_check_operators.sage）。
# 左辺は Sage の演算の再帰（ad_power_sage）で生成子 (i/2)((K_1)_C H_1^(+))・i((K_2^*)_C H_2) から直接作り、鎖の「記法」の行は
# def_ad_X_matrix の交換子（comm_body。積・差は本文の成分の式）の再帰で作る。以降の各行は、その行の式どおりにスカラー（ℂ の積）を
# 組み、本文の成分の式のスカラー倍で行列に掛けて作る。冪は冪の約束どおり右から 1 つずつ掛けて作る。
# nesting_of_commutator_of_H_and_check_Z を代入する行は、その主張の右辺の式から作り、代入前の行（ad^n_{kH}(W)）と一致することで
# 代入を確かめる。l は (n-1)/2・n/2 を QQ で作り、ZZ_{≥0} に属することと n = 2l+1・n = 2l・(n+1)/2 = l+1 を確かめてから使う。
import sys
load("_prelude.sage")

N_MAX = 7
Ms = [int(a) for a in sys.argv[1:]] or [2, 3, 4, 5]


def half_index(n):
    """奇数なら l = (n-1)/2、偶数なら l = n/2（QQ で作り ZZ_{≥0} を確かめる）。"""
    l = QQ(n - 1) / 2 if n % 2 == 1 else QQ(n) / 2
    assert l.denominator() == 1 and l >= 0
    l = ZZ(l)
    if n % 2 == 1:
        assert n == 2 * l + 1 and QQ(n + 1) / 2 == l + 1
    else:
        assert n == 2 * l
    return l


class AdCache:
    def __init__(self, X, W, use_body):
        self.X, self.vals, self.body = X, [W], use_body

    def __getitem__(self, m):
        while len(self.vals) <= m:
            prev = self.vals[-1]
            self.vals.append(comm_body(self.X, prev) if self.body else comm_sage(self.X, prev))
        return self.vals[m]


for M in Ms:
    S = Setting(M)
    P = S.P
    k1, k2 = S.k1, S.k2
    iP = P(S.iL)
    two = P(2)
    ihalf = iP * two.inverse_of_unit() if hasattr(two, 'inverse_of_unit') else iP * P(QQ(1) / 2)
    report(ihalf * two == iP, f"M={M}: (i/2)·2 = i")
    m1 = P(-1)
    minus_i = m1 * iP
    for mu in range(1, M + 1):
        Zc, Yc = S.checkZ(mu), S.checkY(mu)
        em, ep = S.ph(mu, -1), S.ph(mu, 1)
        X1 = body_scalar(k1, S.H1)          # (K_1)_C H_1^(+)
        X2 = body_scalar(k2, S.H2)          # (K_2^*)_C H_2
        G1 = body_scalar(ihalf, X1)         # (i/2)((K_1)_C H_1^(+))
        G2 = body_scalar(iP, X2)            # i((K_2^*)_C H_2)
        G1s = (ihalf * k1) * S.H1           # 比べる側: Sage の演算で作った生成子
        G2s = (iP * k2) * S.H2
        report(G1 == G1s and G2 == G2s, f"M={M} mu={mu}: 生成子のスカラー倍が Sage の積と一致")
        cache = {
            ('G1', 'Z', 'body'): AdCache(G1, Zc, True), ('G1', 'Y', 'body'): AdCache(G1, Yc, True),
            ('G2', 'Z', 'body'): AdCache(G2, Zc, True), ('G2', 'Y', 'body'): AdCache(G2, Yc, True),
            ('G1', 'Z', 'sage'): AdCache(G1s, Zc, False), ('G1', 'Y', 'sage'): AdCache(G1s, Yc, False),
            ('G2', 'Z', 'sage'): AdCache(G2s, Zc, False), ('G2', 'Y', 'sage'): AdCache(G2s, Yc, False),
            ('X1', 'Z', 'body'): AdCache(X1, Zc, True), ('X1', 'Y', 'body'): AdCache(X1, Yc, True),
            ('X2', 'Z', 'body'): AdCache(X2, Zc, True), ('X2', 'Y', 'body'): AdCache(X2, Yc, True),
        }
        Wmat = {'Z': Zc, 'Y': Yc}
        for n in range(0, N_MAX + 1):
            l = half_index(n)
            tag = f"M={M} mu={mu} n={n}"
            odd = (n % 2 == 1)
            for w in ('Z', 'Y'):
                W = Wmat[w]
                other = Yc if w == 'Z' else Zc
                # ---- (h1.w) ----
                lhs = cache[('G1', w, 'sage')][n]
                head = [
                    ("左辺（Sage の再帰）", lhs),
                    ("ad^n_{(i/2)(k1H1)}(W)", cache[('G1', w, 'body')][n]),
                    ("(i/2)^n ad^n_{k1H1}(W)", body_scalar(pw(ihalf, n), cache[('X1', w, 'body')][n])),
                ]
                if odd and w == 'Z':
                    c = pw(m1, l) * pw(2 * k1, n) * em
                    nest = body_scalar(c, other)
                    rest = [
                        ("(i/2)^n(((-1)^l(2k1)^n e-)Y)", body_scalar(pw(ihalf, n), nest)),
                        ("((i/2)^n((-1)^l(2k1)^n e-))Y", body_scalar(pw(ihalf, n) * c, other)),
                        ("(((i/2)^n(2k1)^n)((-1)^l e-))Y", body_scalar((pw(ihalf, n) * pw(2 * k1, n)) * (pw(m1, l) * em), other)),
                        ("((i^n k1^n)((-1)^l e-))Y", body_scalar((pw(iP, n) * pw(k1, n)) * (pw(m1, l) * em), other)),
                        ("((i^{2l+1}k1^n)((-1)^l e-))Y", body_scalar((pw(iP, 2 * l + 1) * pw(k1, n)) * (pw(m1, l) * em), other)),
                        ("(((i^{2l} i)k1^n)((-1)^l e-))Y", body_scalar(((pw(iP, 2 * l) * iP) * pw(k1, n)) * (pw(m1, l) * em), other)),
                        ("((i^{2l}(-1)^l)(i k1^n e-))Y", body_scalar((pw(iP, 2 * l) * pw(m1, l)) * (iP * pw(k1, n) * em), other)),
                        ("(1(i k1^n e-))Y", body_scalar(P(1) * (iP * pw(k1, n) * em), other)),
                        ("(i k1^n e-)Y", body_scalar(iP * pw(k1, n) * em, other)),
                    ]
                    claim = body_scalar(iP * pw(k1, n) * em, Yc)
                elif odd and w == 'Y':
                    c = pw(m1, l + 1) * pw(2 * k1, n) * ep
                    nest = body_scalar(c, other)
                    rest = [
                        ("(i/2)^n(((-1)^{l+1}(2k1)^n e+)Z)", body_scalar(pw(ihalf, n), nest)),
                        ("((i/2)^n((-1)^{l+1}(2k1)^n e+))Z", body_scalar(pw(ihalf, n) * c, other)),
                        ("(((i/2)^n(2k1)^n)((-1)^{l+1} e+))Z", body_scalar((pw(ihalf, n) * pw(2 * k1, n)) * (pw(m1, l + 1) * ep), other)),
                        ("((i^n k1^n)((-1)^{l+1} e+))Z", body_scalar((pw(iP, n) * pw(k1, n)) * (pw(m1, l + 1) * ep), other)),
                        ("((i^{2l+1}k1^n)((-1)^{l+1} e+))Z", body_scalar((pw(iP, 2 * l + 1) * pw(k1, n)) * (pw(m1, l + 1) * ep), other)),
                        ("(((i^{2l} i)k1^n)(((-1)^l(-1)) e+))Z", body_scalar(((pw(iP, 2 * l) * iP) * pw(k1, n)) * ((pw(m1, l) * m1) * ep), other)),
                        ("((i^{2l}(-1)^l)(((-1)i)k1^n e+))Z", body_scalar((pw(iP, 2 * l) * pw(m1, l)) * ((m1 * iP) * pw(k1, n) * ep), other)),
                        ("(1(((-1)i)k1^n e+))Z", body_scalar(P(1) * ((m1 * iP) * pw(k1, n) * ep), other)),
                        ("(1((-i)k1^n e+))Z", body_scalar(P(1) * (minus_i * pw(k1, n) * ep), other)),
                        ("((-i)k1^n e+)Z", body_scalar(minus_i * pw(k1, n) * ep, other)),
                    ]
                    claim = body_scalar(minus_i * pw(k1, n) * ep, Zc)
                else:
                    c = pw(m1, l) * pw(2 * k1, n)
                    nest = body_scalar(c, W)
                    rest = [
                        ("(i/2)^n(((-1)^l(2k1)^n)W)", body_scalar(pw(ihalf, n), nest)),
                        ("((i/2)^n((-1)^l(2k1)^n))W", body_scalar(pw(ihalf, n) * c, W)),
                        ("(((i/2)^n(2k1)^n)(-1)^l)W", body_scalar((pw(ihalf, n) * pw(2 * k1, n)) * pw(m1, l), W)),
                        ("((i^n k1^n)(-1)^l)W", body_scalar((pw(iP, n) * pw(k1, n)) * pw(m1, l), W)),
                        ("((i^{2l}k1^n)(-1)^l)W", body_scalar((pw(iP, 2 * l) * pw(k1, n)) * pw(m1, l), W)),
                        ("((i^{2l}(-1)^l)k1^n)W", body_scalar((pw(iP, 2 * l) * pw(m1, l)) * pw(k1, n), W)),
                        ("(1 k1^n)W", body_scalar(P(1) * pw(k1, n), W)),
                        ("k1^n W", body_scalar(pw(k1, n), W)),
                    ]
                    claim = body_scalar(pw(k1, n), W)
                report(cache[('X1', w, 'body')][n] == nest, f"{tag} (h1.{w.lower()}): 代入する nesting の右辺が ad^n_{{k1H1}}(W) に等しい")
                run_chain(head + rest, f"{tag} (h1.{w.lower()})")
                report(rest[-1][1] == claim and lhs == claim, f"{tag} (h1.{w.lower()}): 最後の行が主張の右辺")
                # ---- (h2.w) ----
                lhs = cache[('G2', w, 'sage')][n]
                head = [
                    ("左辺（Sage の再帰）", lhs),
                    ("ad^n_{i(k2H2)}(W)", cache[('G2', w, 'body')][n]),
                    ("i^n ad^n_{k2H2}(W)", body_scalar(pw(iP, n), cache[('X2', w, 'body')][n])),
                ]
                if odd and w == 'Z':
                    c = pw(m1, l + 1) * pw(2 * k2, n)
                    nest = body_scalar(c, other)
                    rest = [
                        ("i^n(((-1)^{l+1}(2k2)^n)Y)", body_scalar(pw(iP, n), nest)),
                        ("(i^n((-1)^{l+1}(2k2)^n))Y", body_scalar(pw(iP, n) * c, other)),
                        ("(i^{2l+1}((-1)^{l+1}(2k2)^n))Y", body_scalar(pw(iP, 2 * l + 1) * (pw(m1, l + 1) * pw(2 * k2, n)), other)),
                        ("((i^{2l} i)(((-1)^l(-1))(2k2)^n))Y", body_scalar((pw(iP, 2 * l) * iP) * ((pw(m1, l) * m1) * pw(2 * k2, n)), other)),
                        ("((i^{2l}(-1)^l)(((-1)i)(2k2)^n))Y", body_scalar((pw(iP, 2 * l) * pw(m1, l)) * ((m1 * iP) * pw(2 * k2, n)), other)),
                        ("(1(((-1)i)(2k2)^n))Y", body_scalar(P(1) * ((m1 * iP) * pw(2 * k2, n)), other)),
                        ("(1((-i)(2k2)^n))Y", body_scalar(P(1) * (minus_i * pw(2 * k2, n)), other)),
                        ("((-i)(2k2)^n)Y", body_scalar(minus_i * pw(2 * k2, n), other)),
                    ]
                    claim = body_scalar(minus_i * pw(2 * k2, n), Yc)
                elif odd and w == 'Y':
                    c = pw(m1, l) * pw(2 * k2, n)
                    nest = body_scalar(c, other)
                    rest = [
                        ("i^n(((-1)^l(2k2)^n)Z)", body_scalar(pw(iP, n), nest)),
                        ("(i^n((-1)^l(2k2)^n))Z", body_scalar(pw(iP, n) * c, other)),
                        ("(i^{2l+1}((-1)^l(2k2)^n))Z", body_scalar(pw(iP, 2 * l + 1) * (pw(m1, l) * pw(2 * k2, n)), other)),
                        ("((i^{2l} i)((-1)^l(2k2)^n))Z", body_scalar((pw(iP, 2 * l) * iP) * (pw(m1, l) * pw(2 * k2, n)), other)),
                        ("((i^{2l}(-1)^l)(i(2k2)^n))Z", body_scalar((pw(iP, 2 * l) * pw(m1, l)) * (iP * pw(2 * k2, n)), other)),
                        ("(1(i(2k2)^n))Z", body_scalar(P(1) * (iP * pw(2 * k2, n)), other)),
                        ("(i(2k2)^n)Z", body_scalar(iP * pw(2 * k2, n), other)),
                    ]
                    claim = body_scalar(iP * pw(2 * k2, n), Zc)
                else:
                    c = pw(m1, l) * pw(2 * k2, n)
                    nest = body_scalar(c, W)
                    rest = [
                        ("i^n(((-1)^l(2k2)^n)W)", body_scalar(pw(iP, n), nest)),
                        ("(i^n((-1)^l(2k2)^n))W", body_scalar(pw(iP, n) * c, W)),
                        ("(i^{2l}((-1)^l(2k2)^n))W", body_scalar(pw(iP, 2 * l) * c, W)),
                        ("((i^{2l}(-1)^l)(2k2)^n)W", body_scalar((pw(iP, 2 * l) * pw(m1, l)) * pw(2 * k2, n), W)),
                        ("(1(2k2)^n)W", body_scalar(P(1) * pw(2 * k2, n), W)),
                        ("(2k2)^n W", body_scalar(pw(2 * k2, n), W)),
                    ]
                    claim = body_scalar(pw(2 * k2, n), W)
                report(cache[('X2', w, 'body')][n] == nest, f"{tag} (h2.{w.lower()}): 代入する nesting の右辺が ad^n_{{k2H2}}(W) に等しい")
                run_chain(head + rest, f"{tag} (h2.{w.lower()})")
                report(rest[-1][1] == claim and lhs == claim, f"{tag} (h2.{w.lower()}): 最後の行が主張の右辺")
        # 対照（n = 1）: (h1.y) の奇数側の符号を逆にした式、(h1.z) の位相を逆にした式、(h2.z) の奇数側の符号を逆にした式は一致しない
        report(cache[('G1', 'Y', 'sage')][1] != body_scalar(iP * k1 * ep, Zc), f"M={M} mu={mu}: 対照 (h1.y) n=1 の符号を逆にすると一致しない")
        report(cache[('G2', 'Z', 'sage')][1] != body_scalar(iP * 2 * k2, Yc), f"M={M} mu={mu}: 対照 (h2.z) n=1 の符号を逆にすると一致しない")
        if em != ep:
            report(cache[('G1', 'Z', 'sage')][1] != body_scalar(iP * k1 * ep, Yc), f"M={M} mu={mu}: 対照 (h1.z) n=1 の位相を逆にすると一致しない")
    print(f"M={M}: done")

print("RESULT: PASS")
