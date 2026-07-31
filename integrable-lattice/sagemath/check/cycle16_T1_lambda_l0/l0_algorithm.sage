# cycle 16 / T1: lambda = l_0(f) の有限手続き（アルゴリズム）とその検証
#
# 対象: P in Z[z_1^{±1},...,z_d^{±1}] \ {0}, f = P(1+T_1,...,1+T_d) in Z_p[[Gamma]], Gamma = Z_p^d。
# Kataoka Def 2.2 (= Cuoco-Monsky Def 1.1,1.2):
#   m_0(f) = f を割り切る p の最大冪、 l_0(f) = sum_Q ord_Q(bar f)、
#   Q は (gamma - 1) (gamma in Gamma \ Gamma^p) の形の F_p[[Gamma]] の素イデアルを走る。
#
# 本スクリプトが検証する主張（レポート §2 の命題 L1/L2/L3）:
#   (L1) bar P の台 supp を Z^d の有限集合とすると、(gamma_v - 1) | bar f となる gamma_v は
#        v が supp の差ベクトルの原始整数方向であるものに限る（有限個）。
#        とくに「無理方向」(v notin P^{d-1}(Q)) の素イデアルは Laurent 多項式を割らない。
#   (L2) 各 v について (gamma_v - 1) | bar f  <=>  Z^d -> Z^d/Zv の各ファイバー上で bar P の係数和が 0。
#   (L3) ord_{(gamma_v-1)}(bar f) は単項変数変換 + X 次数の最小値として有限計算できる。
#   => l_0(f) は有限手続きで計算できる（Laurent 多項式の場合）。
#
# 検証は 3 通り（実装を分ける）:
#   A: 上の有限アルゴリズム l0_algorithm()
#   B: 1 変数冪級数への引き戻し（z_i -> (1+Y)^{n_i}）の零判定。方向ごとに独立実装。
#   C: P^1(Z/p^K) の全被覆探索（有理・無理を区別せず全方向を有限精度で走査）
#   D: Kataoka Thm 2.1/2.3 の漸近形へのフィット（真の lambda との照合）
#
# すべて F_p, Z, Z^d 上の有限計算のみ。R/C へは一度も脱出しない。

import itertools

print("=" * 100)
print("cycle 16 / T1: lambda = l_0(f) の有限手続きとその検証")
print("=" * 100)


# ---------------------------------------------------------------- 基本ユーティリティ

def laurent_dict(P, gens):
    """多項式 P（Laurent でもよい）を {指数タプル: 係数(ZZ)} へ。"""
    d = len(gens)
    out = {}
    for mono, c in zip(P.monomials(), P.coefficients()):
        e = tuple(ZZ(mono.degree(g)) for g in gens)
        out[e] = out.get(e, ZZ(0)) + ZZ(c)
    return {e: c for e, c in out.items() if c != 0}


def reduce_mod_p(supp, p):
    """content を割ってから mod p 還元。(m_0, {指数: F_p 係数}) を返す。"""
    g = gcd([ZZ(c) for c in supp.values()])
    m0 = ZZ(g).valuation(p)
    F = GF(p)
    out = {}
    for e, c in supp.items():
        cc = F(ZZ(c) / p**m0)
        if cc != 0:
            out[e] = cc
    return m0, out


def primitive(v):
    """整数ベクトルを原始化し、最初の非零成分を正に正規化。"""
    g = gcd([ZZ(x) for x in v])
    if g == 0:
        return None
    v = tuple(ZZ(x) / g for x in v)
    for x in v:
        if x != 0:
            if x < 0:
                v = tuple(-y for y in v)
            break
    return v


def unimodular_sending_to_e1(v):
    """U in GL_d(Z) で U*v = e_1 となるものを返す（v は原始整数ベクトル）。"""
    d = len(v)
    M = matrix(ZZ, d, 1, list(v))
    D, U, V = M.smith_form()      # D = U*M*V
    # D は (1,0,...,0)^T（v が原始なので基本因子は 1）
    assert D[0, 0] == 1 and all(D[i, 0] == 0 for i in range(1, d))
    assert V.nrows() == 1
    # U*M = D*V^{-1};  V は 1x1 の (±1)
    s = ZZ(V[0, 0])
    U = s * U
    assert (U * M).column(0) == vector(ZZ, [1] + [0] * (d - 1))
    return U


# ---------------------------------------------------------------- A: 有限アルゴリズム

def candidate_directions(barP):
    """台の差ベクトルの原始方向（有限集合）。"""
    S = sorted(barP.keys())
    V = set()
    for e, e2 in itertools.combinations(S, 2):
        v = primitive(tuple(ZZ(a) - ZZ(b) for a, b in zip(e, e2)))
        if v is not None:
            V.add(v)
    return sorted(V)


def fiber_test(barP, v, p):
    """(L2): Z^d -> Z^d/Zv の各ファイバーで係数和が 0 か。"""
    d = len(v)
    U = unimodular_sending_to_e1(v)
    acc = {}
    for e, c in barP.items():
        k = tuple(U * vector(ZZ, e))[1:]
        acc[k] = acc.get(k, GF(p)(0)) + c
    return all(x == 0 for x in acc.values())


def ord_at_gamma(barP, v, p):
    """(L3): ord_{(gamma_v - 1)}(bar f) を X 展開の最小次数として計算。"""
    d = len(v)
    U = unimodular_sending_to_e1(v)
    news = {}
    for e, c in barP.items():
        k = tuple(U * vector(ZZ, e))
        news[k] = news.get(k, GF(p)(0)) + c
    news = {k: c for k, c in news.items() if c != 0}
    if not news:
        return Infinity
    # 単項式 (unit) を掛けて指数を非負に揃える
    shift = [min(k[i] for k in news.keys()) for i in range(d)]
    names = ['X'] + ['Y%d' % i for i in range(1, d)]
    Rp = PolynomialRing(GF(p), names)
    gensp = Rp.gens()
    poly = Rp(0)
    for k, c in news.items():
        term = Rp(c)
        for i in range(d):
            term *= (1 + gensp[i])**ZZ(k[i] - shift[i])
        poly += term
    if poly == 0:
        return Infinity
    return min(ZZ(m.degree(gensp[0])) for m in poly.monomials())


def ord_by_division(barP, v, p):
    """(L3 の独立実装) 新座標での Q(g,h_*) in F_p[h^±][g] における (g-1) の重複度を
       「g=1 での消滅 → (g-1) で割る」の反復で求める。ord_at_gamma と一致するはず。"""
    d = len(v)
    U = unimodular_sending_to_e1(v)
    news = {}
    for e, c in barP.items():
        k = tuple(U * vector(ZZ, e))
        news[k] = news.get(k, GF(p)(0)) + c
    news = {k: c for k, c in news.items() if c != 0}
    if not news:
        return Infinity
    shift = [min(k[i] for k in news.keys()) for i in range(d)]
    names = ['g'] + ['h%d' % i for i in range(1, d)]
    Rp = PolynomialRing(GF(p), names)
    gs = Rp.gens()
    poly = Rp(0)
    for k, c in news.items():
        term = Rp(c)
        for i in range(d):
            term *= gs[i]**ZZ(k[i] - shift[i])
        poly += term
    m = 0
    while poly != 0:
        q, r = poly.quo_rem(gs[0] - 1)
        if r != 0:
            break
        poly = q
        m += 1
    return m


def l0_algorithm(P, gens, p, verbose=False):
    """l_0(f), f = P(1+T_1,...,1+T_d) を有限手続きで計算する。"""
    supp = laurent_dict(P, gens)
    m0, barP = reduce_mod_p(supp, p)
    if len(barP) <= 1:
        return m0, 0, []
    total = 0
    hits = []
    for v in candidate_directions(barP):
        divides = fiber_test(barP, v, p)
        m = ord_at_gamma(barP, v, p)
        m2 = ord_by_division(barP, v, p)
        assert (m >= 1) == divides, "ファイバー判定と ord 判定が食い違った: v=%s" % (v,)
        assert m == m2, "ord の 2 実装が食い違った: v=%s (%s vs %s)" % (v, m, m2)
        if divides:
            total += m
            hits.append((v, m))
    if verbose:
        print("      候補方向 %d 個, 割り切る方向 %s" % (len(candidate_directions(barP)), hits))
    return m0, total, hits


# ---------------------------------------------------------------- B: 1 変数冪級数による独立判定

def pullback_series(barP, expo, p, prec):
    """z_i -> (1+Y)^{expo_i} を代入した F_p[[Y]] の元（prec 次で打ち切り）。
       expo_i は Z/p^K の代表（prec <= p^K であれば well-defined）。"""
    Rs = PowerSeriesRing(GF(p), 'Y', default_prec=prec)
    Y = Rs.gen()
    u = 1 + Y
    uinv = u**(-1)
    out = Rs(0)
    for e, c in barP.items():
        t = Rs(1)
        for i, ei in enumerate(e):
            n = ZZ(ei) * ZZ(expo[i])
            if n >= 0:
                t *= u**n
            else:
                t *= uinv**(-n)
        out += Rs(c) * t
    return out.add_bigoh(prec)


def quotient_exponents(v):
    """d=2 専用: Z^2 -> Z^2/Zv ≅ Z の生成子への指数 (z -> (1+Y)^{-v2}, w -> (1+Y)^{v1})。"""
    assert len(v) == 2
    return (-ZZ(v[1]), ZZ(v[0]))


# ---------------------------------------------------------------- C: P^1(Z/p^K) 全被覆探索

def sweep_P1(barP, p, K):
    """d=2。P^1(Z/p^K) の全点（= Z_p 方向のボール被覆）で
       引き戻し級数が Y^{p^K} まで 0 かどうかを走査する。
       0 でないボールは「その中のどの方向も (gamma-1) | bar f を満たさない」ことを証明する。"""
    prec = p**K
    zeros, total = [], 0
    reps = [(1, b) for b in range(p**K)] + [(a, 1) for a in range(p**K) if a % p == 0]
    for (a, b) in reps:
        total += 1
        # Gamma -> Gamma/<gamma> の生成子への指数: (z,w) -> ((1+Y)^{-b}, (1+Y)^{a})
        s = pullback_series(barP, (-ZZ(b) % prec, ZZ(a) % prec), p, prec)
        if s == 0:
            zeros.append((a, b))
    return total, zeros


# ---------------------------------------------------------------- D: 漸近形へのフィット

def sum_ord_chi(P, gens, p, n):
    """sum_{chi in Gamma_n^, chi(f) != 0} ord_p(chi(f))  (d=2)。厳密（円分体のイデアル付値）。"""
    assert len(gens) == 2
    L = p**n
    if n == 0:
        val = P.subs({gens[0]: 1, gens[1]: 1})
        return ZZ(0) if val == 0 else ZZ(val).valuation(p)
    K = CyclotomicField(L)
    zeta = K.gen()
    pr = K.primes_above(p)[0]
    e = pr.ramification_index()
    tot = QQ(0)
    for i in range(L):
        zi = zeta**i
        for j in range(L):
            val = P.subs({gens[0]: zi, gens[1]: zeta**j})
            if val == 0:
                continue
            tot += QQ(K.ideal(val).valuation(pr)) / e
    return tot


def fit_monsky(seq, p, ns):
    """v(n) = m0 p^{2n} + l0 n p^n + mu1 p^n + lam1 n + nu を ns の 5 点で同定。"""
    rows, rhs = [], []
    for n in ns:
        X = p**n
        rows.append([X * X, X * n, X, n, 1])
        rhs.append(seq[n])
    M = matrix(QQ, rows)
    if M.rank() < 5:
        return None
    return M.solve_right(vector(QQ, rhs))
