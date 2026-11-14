# 対象ラベル: nesting_of_commutator_of_H_and_check_Z
# (h1.z)・(h1.y)・(h2.z)・(h2.y) の帰納法の基底段階と二つの帰納段階の鎖の全行、および主張そのものを、
# (K_1)_C・(K_2^*)_C を不定元 k1・k2 にして厳密に確かめる（M_col = 2..5、μ ∈ {1,…,M_col}、n = 0..N_MAX）。
# 鎖の各行は、その行の式どおりにスカラー（ℂ の積）を組んでから本文の成分の式のスカラー倍で行列に掛けて作る。
# 鎖の先頭 C_{n+1} は ad^{n+1} を Sage の演算で直接作った値（ad_power_sage）と比べ、
# 「= [X, C_n]」「= [X, 仮定の式]」の行は本文の交換子（comm_body）で作る。
# 冪の指数の等式（n/2 = ((n+1)-1)/2 など）は、各 n で ZZ の等式として、また QQ[n] の多項式の等式として確かめる。
import sys
load("_prelude.sage")

N_MAX = 7
Qn = PolynomialRing(QQ, 'n')
nn = Qn.gen()
# 指数の等式（偶奇によらず多項式として成り立つ）
report(nn / 2 == ((nn + 1) - 1) / 2, "QQ[n]: n/2 = ((n+1)-1)/2")
report(nn / 2 + 1 == ((nn + 1) + 1) / 2, "QQ[n]: n/2 + 1 = ((n+1)+1)/2")
report((nn - 1) / 2 + 1 == (nn + 1) / 2, "QQ[n]: (n-1)/2 + 1 = (n+1)/2")


def sgn(e):
    """(-1)^e（e ∈ ZZ_{≥0}）。冪の約束 x^0 := 1、x^{m+1} := x^m x のとおりに右から 1 つずつ掛けて作る。"""
    e = QQ(e)
    assert e.denominator() == 1 and e >= 0, f"指数 {e} が ZZ_{{>=0}} に無い"
    out = 1
    for _ in range(ZZ(e)):
        out = out * (-1)
    return out


def pw(x, e):
    out = x.parent()(1)
    for _ in range(e):
        out = out * x
    return out


def run_chain(lines, label):
    for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
        report(v0 == v1, f"{label}: 「{n0}」=「{n1}」")


def check_claim(S, mu, name, k, H, start, other, comm_start, comm_other, formula):
    """一つの主張の帰納法を確かめる。
    k: (K_1)_C か (K_2^*)_C の不定元、H: H_1^(+) か H_2、start: Ž か Y̌（C_0）、other: もう一方、
    comm_start = [H, start] の右辺の (係数, 行列)、comm_other = [H, other] の右辺の (係数, 行列)、
    formula(n) = 主張の右辺の (係数, 行列)。"""
    X = body_scalar(k, H)
    two_k = 2 * k
    # 基底段階
    c0, B0 = formula(0)
    run_chain([
        ("C_0", ad_power_sage(X, start, 0)),
        ("start", start),
        ("1_C start", body_scalar(1, start)),
        ("(1_C 1_C) start", body_scalar(S.P(1) * S.P(1), start)),
        ("((-1)^0(2k)^0) start", body_scalar(sgn(0) * pw(two_k, 0), start)),
    ], f"M={S.M} mu={mu} {name} 基底")
    report(body_scalar(c0, B0) == start, f"M={S.M} mu={mu} {name}: 基底の最後の行が主張の n=0 の右辺")
    for n in range(0, N_MAX):
        Cn = ad_power_sage(X, start, n)
        cn, Bn = formula(n)
        hyp = body_scalar(cn, Bn)
        report(Cn == hyp, f"M={S.M} mu={mu} {name}: 主張 n={n}（帰納法の仮定）")
        Cn1 = ad_power_sage(X, start, n + 1)
        # 帰納段階の頭の 3 行: C_{n+1} = [X, C_n] = [X, 仮定の式] = (k c_n)[H, B_n]
        head = [
            ("C_{n+1}", Cn1),
            ("[kH, C_n]", comm_body(X, Cn)),
            ("[kH, (c_n)B_n]", comm_body(X, hyp)),
            ("(k c_n)[H, B_n]", body_scalar(k * cn, comm_body(H, Bn))),
        ]
        # [H, B_n] を (A)〜(D) で置き換えた行と、その後の係数の行
        if Bn == start:
            a, T = comm_start
        else:
            a, T = comm_other
        cn1, Bn1 = formula(n + 1)
        report(T == Bn1, f"M={S.M} mu={mu} {name} n={n}: 置き換え後の行列が主張 n+1 の行列")
        rest = [
            ("(k c_n)((a)T)", body_scalar(k * cn, body_scalar(a, T))),
            ("(k c_n a)T", body_scalar(k * cn * a, T)),
        ]
        run_chain(head + rest, f"M={S.M} mu={mu} {name} n={n}→{n+1}")
        return_lines = step_tail(name, n, k, two_k, S.ph(mu, -1), S.ph(mu, 1), T)
        run_chain([rest[-1]] + return_lines, f"M={S.M} mu={mu} {name} n={n}→{n+1} 係数の鎖")
        report(return_lines[-1][1] == body_scalar(cn1, Bn1), f"M={S.M} mu={mu} {name} n={n}: 鎖の最後の行が主張 n+1 の右辺")
        report(Cn1 == body_scalar(cn1, Bn1), f"M={S.M} mu={mu} {name}: 主張 n={n+1}")


def step_tail(name, n, k, two_k, em, ep, T):
    """係数の鎖の (k c_n a)T の次の行から最後の行まで（人手証明の行どおり）。em = exp(-iθ̃)、ep = exp(iθ̃)。"""
    one = k.parent()(1)
    if name == 'h1.z' and n % 2 == 0:
        sg, p, two = sgn(QQ(n) / 2), pw(two_k, n), k.parent()(2)
        # 積の結合律・可換律を 1 行に 1 つずつ当てる 5 行（括弧は行の式どおり）
        return [
            ("(((k(sp))2)e)Y̌", body_scalar(((k * (sg * p)) * two) * em, T)),
            ("((2(k(sp)))e)Y̌", body_scalar((two * (k * (sg * p))) * em, T)),
            ("(((2k)(sp))e)Y̌", body_scalar(((two * k) * (sg * p)) * em, T)),
            ("(((sp)(2k))e)Y̌", body_scalar(((sg * p) * (two * k)) * em, T)),
            ("((s(p(2k)))e)Y̌", body_scalar((sg * (p * (two * k))) * em, T)),
            ("((-1)^{n/2}(2k)^{n+1}exp(-iθ̃))Y̌", body_scalar(sgn(QQ(n) / 2) * pw(two_k, n + 1) * em, T)),
            ("((-1)^{((n+1)-1)/2}(2k)^{n+1}exp(-iθ̃))Y̌", body_scalar(sgn(QQ((n + 1) - 1) / 2) * pw(two_k, n + 1) * em, T)),
        ]
    if name == 'h1.z':
        e = QQ(n - 1) / 2
        sg, p, two, m = sgn(e), pw(two_k, n), k.parent()(2), k.parent()(-1)
        A = (sg * p) * em
        # multiply_by_minus_one の 1 行と、積の結合律・可換律を 1 行に 1 つずつ当てる 11 行（括弧は行の式どおり）
        return [
            ("((k((sp)e))((m2)f))Ž", body_scalar((k * A) * ((m * two) * ep), T)),
            ("(((k((sp)e))(m2))f)Ž", body_scalar(((k * A) * (m * two)) * ep, T)),
            ("(((m2)(k((sp)e)))f)Ž", body_scalar(((m * two) * (k * A)) * ep, T)),
            ("((m(2(k((sp)e))))f)Ž", body_scalar((m * (two * (k * A))) * ep, T)),
            ("((m((2k)((sp)e)))f)Ž", body_scalar((m * ((two * k) * A)) * ep, T)),
            ("((m(((2k)(sp))e))f)Ž", body_scalar((m * (((two * k) * (sg * p)) * em)) * ep, T)),
            ("(((m((2k)(sp)))e)f)Ž", body_scalar(((m * ((two * k) * (sg * p))) * em) * ep, T)),
            ("((m((2k)(sp)))(ef))Ž", body_scalar((m * ((two * k) * (sg * p))) * (em * ep), T)),
            ("((m((sp)(2k)))(ef))Ž", body_scalar((m * ((sg * p) * (two * k))) * (em * ep), T)),
            ("((m(s(p(2k))))(ef))Ž", body_scalar((m * (sg * (p * (two * k)))) * (em * ep), T)),
            ("(((ms)(p(2k)))(ef))Ž", body_scalar(((m * sg) * (p * (two * k))) * (em * ep), T)),
            ("(((sm)(p(2k)))(ef))Ž", body_scalar(((sg * m) * (p * (two * k))) * (em * ep), T)),
            ("(((-1)^{(n-1)/2+1}(2k)^{n+1})(exp(-iθ̃)exp(iθ̃)))Ž", body_scalar((sgn(e + 1) * pw(two_k, n + 1)) * (em * ep), T)),
            ("(((-1)^{(n-1)/2+1}(2k)^{n+1})1_C)Ž", body_scalar((sgn(e + 1) * pw(two_k, n + 1)) * one, T)),
            ("((-1)^{(n-1)/2+1}(2k)^{n+1})Ž", body_scalar(sgn(e + 1) * pw(two_k, n + 1), T)),
            ("((-1)^{(n+1)/2}(2k)^{n+1})Ž", body_scalar(sgn(QQ(n + 1) / 2) * pw(two_k, n + 1), T)),
        ]
    if name == 'h1.y' and n % 2 == 0:
        return [
            ("((-1)^{n/2}(-1)(2k)^n(2k)exp(iθ̃))Ž", body_scalar(sgn(QQ(n) / 2) * (-1) * pw(two_k, n) * two_k * ep, T)),
            ("((-1)^{n/2+1}(2k)^{n+1}exp(iθ̃))Ž", body_scalar(sgn(QQ(n) / 2 + 1) * pw(two_k, n + 1) * ep, T)),
            ("((-1)^{((n+1)+1)/2}(2k)^{n+1}exp(iθ̃))Ž", body_scalar(sgn(QQ((n + 1) + 1) / 2) * pw(two_k, n + 1) * ep, T)),
        ]
    if name == 'h1.y':
        e = QQ(n + 1) / 2
        return [
            ("((-1)^{(n+1)/2}(2k)^n(2k)exp(-iθ̃)exp(iθ̃))Y̌", body_scalar(sgn(e) * pw(two_k, n) * two_k * em * ep, T)),
            ("((-1)^{(n+1)/2}(2k)^{n+1}exp(-iθ̃)exp(iθ̃))Y̌", body_scalar(sgn(e) * pw(two_k, n + 1) * em * ep, T)),
            ("((-1)^{(n+1)/2}(2k)^{n+1}1_C)Y̌", body_scalar(sgn(e) * pw(two_k, n + 1) * one, T)),
            ("((-1)^{(n+1)/2}(2k)^{n+1})Y̌", body_scalar(sgn(e) * pw(two_k, n + 1), T)),
        ]
    if name == 'h2.z' and n % 2 == 0:
        return [
            ("((-1)^{n/2}(-1)(2k)^n(2k))Y̌", body_scalar(sgn(QQ(n) / 2) * (-1) * pw(two_k, n) * two_k, T)),
            ("((-1)^{n/2+1}(2k)^{n+1})Y̌", body_scalar(sgn(QQ(n) / 2 + 1) * pw(two_k, n + 1), T)),
            ("((-1)^{((n+1)+1)/2}(2k)^{n+1})Y̌", body_scalar(sgn(QQ((n + 1) + 1) / 2) * pw(two_k, n + 1), T)),
        ]
    if name == 'h2.z':
        e = QQ(n + 1) / 2
        return [
            ("((-1)^{(n+1)/2}(2k)^n(2k))Ž", body_scalar(sgn(e) * pw(two_k, n) * two_k, T)),
            ("((-1)^{(n+1)/2}(2k)^{n+1})Ž", body_scalar(sgn(e) * pw(two_k, n + 1), T)),
        ]
    if name == 'h2.y' and n % 2 == 0:
        return [
            ("((-1)^{n/2}(2k)^n(2k))Ž", body_scalar(sgn(QQ(n) / 2) * pw(two_k, n) * two_k, T)),
            ("((-1)^{n/2}(2k)^{n+1})Ž", body_scalar(sgn(QQ(n) / 2) * pw(two_k, n + 1), T)),
            ("((-1)^{((n+1)-1)/2}(2k)^{n+1})Ž", body_scalar(sgn(QQ((n + 1) - 1) / 2) * pw(two_k, n + 1), T)),
        ]
    if name == 'h2.y':
        e = QQ(n - 1) / 2
        return [
            ("((-1)^{(n-1)/2}(-1)(2k)^n(2k))Y̌", body_scalar(sgn(e) * (-1) * pw(two_k, n) * two_k, T)),
            ("((-1)^{(n-1)/2+1}(2k)^{n+1})Y̌", body_scalar(sgn(e + 1) * pw(two_k, n + 1), T)),
            ("((-1)^{(n+1)/2}(2k)^{n+1})Y̌", body_scalar(sgn(QQ(n + 1) / 2) * pw(two_k, n + 1), T)),
        ]
    raise ValueError(name)


M_LIST = [int(a) for a in sys.argv[1:]] or [2, 3, 4, 5]
for M in M_LIST:
    S = Setting(M)
    k1, k2 = S.k1, S.k2
    for mu in range(1, M + 1):
        Zc, Yc = S.checkZ(mu), S.checkY(mu)
        em, ep = S.ph(mu, -1), S.ph(mu, 1)
        # 主張の右辺（係数, 行列）
        h1z = lambda n: ((sgn(QQ(n - 1) / 2) * pw(2 * k1, n) * em, Yc) if n % 2 else (sgn(QQ(n) / 2) * pw(2 * k1, n), Zc))
        h1y = lambda n: ((sgn(QQ(n + 1) / 2) * pw(2 * k1, n) * ep, Zc) if n % 2 else (sgn(QQ(n) / 2) * pw(2 * k1, n), Yc))
        h2z = lambda n: ((sgn(QQ(n + 1) / 2) * pw(2 * k2, n), Yc) if n % 2 else (sgn(QQ(n) / 2) * pw(2 * k2, n), Zc))
        h2y = lambda n: ((sgn(QQ(n - 1) / 2) * pw(2 * k2, n), Zc) if n % 2 else (sgn(QQ(n) / 2) * pw(2 * k2, n), Yc))
        # (A)〜(D) の右辺（係数, 行列）
        A, B, C, D = (2 * em, Yc), (-2 * ep, Zc), (S.P(-2), Yc), (S.P(2), Zc)
        check_claim(S, mu, 'h1.z', k1, S.H1, Zc, Yc, A, B, h1z)
        check_claim(S, mu, 'h1.y', k1, S.H1, Yc, Zc, B, A, h1y)
        check_claim(S, mu, 'h2.z', k2, S.H2, Zc, Yc, C, D, h2z)
        check_claim(S, mu, 'h2.y', k2, S.H2, Yc, Zc, D, C, h2y)
        # 対照: (h1.z) の奇数側の位相を exp(+iθ̃) にした式は、θ̃ ≠ π の μ では n = 1 で一致しない
        if 2 * mu - 1 != M:
            X1 = body_scalar(k1, S.H1)
            report(ad_power_sage(X1, Zc, 1) != body_scalar(2 * k1 * ep, Yc), f"M={M} mu={mu}: 対照 (h1.z) の位相を逆にすると n=1 で一致しない")
        # 対照: (h2.z) の奇数側の符号を逆にすると n=1 で一致しない
        X2 = body_scalar(k2, S.H2)
        report(ad_power_sage(X2, Zc, 1) != body_scalar(2 * k2, Yc), f"M={M} mu={mu}: 対照 (h2.z) の符号を逆にすると n=1 で一致しない")
    print(f"M={M}: done")

print("RESULT: PASS")
