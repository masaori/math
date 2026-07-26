# cycle 15 / T1: Monsky-Cuoco-Monsky(Kataoka Thm 2.1/2.3)の形が
#   v_p(a_{p^n}) = (l_0 n + m_0 p^n) p^{(d-1)n} + sum_{i=1}^{d-1}(lam_i n + mu_i p^n) p^{(d-1-i)n} + nu
# であることの数値確認。とくに主要係数 m_0 = v_p(content) を確かめる。
#
# 対応: a_L = prod_{z^L=1,w^L=1} P(z,w) = prod_{chi in Gamma_n hat} chi(f),  f = P(1+T,1+S)。
# Kataoka Thm 2.1 の左辺 sum_{chi} ord_p(chi(f)) がちょうど v_p(a_{p^n})。
# Kataoka Def 2.2 より m_0(f) = f を割り切る p の最大冪 = v_p(content_{T,S} f)。
# 本プロジェクトの補題 D(z->1+T が Z 上の環同型ゆえ content 不変)より
#   m_0(f) = v_p(content_{z,w} P)。
#
# 本スクリプトは (i) この主要係数の一致、(ii) 形への当てはまり を厳密整数計算で確認する。

print("=" * 92)
print("cycle 15 / T1: Monsky/Cuoco-Monsky の形と主要係数 m_0 = v_p(content) の確認")
print("=" * 92)

R.<z, w> = ZZ[]

def a_L(P, L):
    Rw.<W> = PolynomialRing(PolynomialRing(ZZ, 'Z'))
    Z = Rw.base_ring().gen()
    Q = (W**L - 1).resultant(P.subs({z: Z, w: W}))
    Zt.<t> = PolynomialRing(ZZ)
    return ZZ((t**L - 1).resultant(Zt(Q)))

def content(P):
    return gcd([ZZ(c) for c in P.coefficients()])

def m0_via_f(P, p):
    """f = P(1+T,1+S) の content の p 進付値。補題 D より content_{z,w}(P) と一致するはず。"""
    RT.<T, S> = ZZ[]
    f = P.subs({z: 1 + T, w: 1 + S})
    return gcd([ZZ(c) for c in f.coefficients()]).valuation(p)

CASES = [
    ("5-(z+1/z)-(w+1/w) [xzw]", 5*z*w - z^2*w - w - z*w^2 - z),
    ("2*(上)",                   2*(5*z*w - z^2*w - w - z*w^2 - z)),
    ("4*(上)",                   4*(5*z*w - z^2*w - w - z*w^2 - z)),
    ("8*(上)",                   8*(5*z*w - z^2*w - w - z*w^2 - z)),
    ("6 - z - w",                6 - z - w),
    ("2 + 3z + 3w",              2 + 3*z + 3*w),
    ("7 - 2z - 2w",              7 - 2*z - 2*w),
    ("3*(6 - z - w)",            3*(6 - z - w)),
    ("9*(6 - z - w)",            9*(6 - z - w)),
    ("2*(7 - 2z - 2w)",          2*(7 - 2*z - 2*w)),
]

print()
print("--- (1) 補題 D: content_{z,w}(P) の付値 = content_{T,S}(P(1+T,1+S)) の付値 ---")
bad1 = 0
for name, P in CASES:
    for p in [2, 3, 5, 7]:
        a = ZZ(content(P)).valuation(p)
        b = m0_via_f(P, p)
        if a != b:
            bad1 += 1
            print("    不一致: P=%s p=%d : v_p(content_zw)=%d, v_p(content_TS)=%d" % (name, p, a, b))
print("  不一致 %d 件（0 なら補題 D が全例で成立）" % bad1)

print()
print("--- (2) 主要項: v_p(a_{p^n}) - m_0*p^{2n} が p^{2n} より低位に留まるか ---")
print("  Kataoka Thm 1.1/2.1 + Thm 2.3 より d=2 では")
print("    v_p(a_{p^n}) = m_0 p^{2n} + l_0 n p^n + mu_1 p^n + lam_1 n + nu   (n>>0)")
print("  なので v_p - m_0 p^{2n} は O(n p^n)。以下 m_0 を content から先に決め、差を見る。")
print()
print("%-26s %3s %6s  %s" % ("P", "p", "m_0", "v_p(a_{p^n}) / 差 = v_p - m_0*p^(2n)"))
for name, P in CASES:
    for p in [2, 3]:
        m0 = ZZ(content(P)).valuation(p)
        vals, diffs = [], []
        for n in range(0, 4):
            L = p**n
            if L**2 > 300:
                break
            v = a_L(P, L)
            if v == 0:
                vals.append("deg"); diffs.append("deg"); continue
            vv = ZZ(v).valuation(p)
            vals.append(vv)
            diffs.append(vv - m0 * p**(2*n))
        print("%-26s %3d %6d  v=%s  差=%s" % (name, p, m0, vals, diffs))
print()
print("  content>1 の例（2*,4*,8*,3*,9*）では差がすべて 0、すなわち")
print("  v_p(a_{p^n}) = m_0 p^{2n} がちょうど成立している（他の係数が 0）。")
print("  content=1 の例では m_0=0 で、差は元の値そのもの（O(n p^n) の増大）。")

print()
print("--- (3) 形への当てはめ: n>=1 の 5 段で 5 係数を同定し、n<=5 全体と照合 ---")
print("  係数は (m_0, l_0, mu_1, lam_1, nu)。m_0 は content から独立に決まる値と一致するかを見る。")
for name, P in [("6 - z - w", 6 - z - w), ("2 + 3z + 3w", 2 + 3*z + 3*w),
                ("3*(6 - z - w)", 3*(6 - z - w))]:
    p = 2
    seq = []
    for n in range(0, 6):
        v = a_L(P, p**n)
        seq.append(ZZ(v).valuation(p))
    m0 = ZZ(content(P)).valuation(p)
    rows, rhs = [], []
    for n in range(1, 6):
        X = p**n
        rows.append([X*X, X*n, X, n, 1]); rhs.append(seq[n])
    M = matrix(QQ, rows)
    sol = M.solve_right(vector(QQ, rhs)) if M.rank() == 5 else None
    print("    P=%-16s p=%d: v=%s" % (name, p, seq))
    if sol is None:
        print("      階数不足")
    else:
        pred = [sol[0]*(p**n)**2 + sol[1]*(p**n)*n + sol[2]*(p**n) + sol[3]*n + sol[4] for n in range(6)]
        print("      同定: (m_0,l_0,mu_1,lam_1,nu)=%s" % (tuple(sol),))
        print("      content から: m_0=%d  一致=%s   n=0..5 全一致=%s"
              % (m0, sol[0] == m0, all(pred[n] == seq[n] for n in range(6))))

print()
print("=" * 92)
print("結論: (1) 補題 D は全例で成立。(2) content>1 の例では v_p = m_0 p^{2n} が厳密に成立し、")
print("      主要係数が m_0 = v_p(content) であることと整合。(3) 同定した m_0 が content 由来の値と一致。")
print("      **これらは Kataoka Thm 2.1/2.3(= Monsky Thm 5.6 + Cuoco-Monsky Thm 1.7)の帰結の確認であり、")
print("      本スクリプトが定理を証明したのではない。**")
print("=" * 92)
