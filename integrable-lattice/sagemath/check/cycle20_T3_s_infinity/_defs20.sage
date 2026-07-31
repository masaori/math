# cycle 20 / T3: S_infinity の判定手続き（一般の塔）のための共有定義。
#
# cycle 19 step 2 の _defs19.sage（そのさらに土台は cycle 18 / cycle 16）を load したうえで、
# 本サイクルの中心的な道具を追加する。
#
# 対応する証明本体: outputs/reports/cycle20_T3_s_infinity_decision.md
#
# 追加するもの:
#   (1) bar tilde E in F_ell[z,w] そのもの（cycle 19 は係数 dict しか持っていなかった）
#   (2) S_infinity の判定手続き（3 通りの独立実装。互いに照合する）
#         T1 = 系 J10 の形（指数 gamma = p a + q b の類ごとの係数和が消えるか）
#         T2 = 命題 2 の形（(chi^{u^perp} - 1) が bar tilde E を割るか）
#         T3 = cycle 19 step 2 の stage_data（内容の ell 付値 lam >= 1 か）
#   (3) 二項式因子の重複度 m_u = max{ m : (chi^{u^perp} - 1)^m | bar tilde E }
#   (4) e_j / j^*(P)（cycle 19 step 1 定義。基点 P を S_infinity の点に取る）
#   (5) hat theta_M(a,b) の **厳密な**計算（整数終結式による。円分体の元の演算を使わない）
#   (6) Theta_M = sum_{P in P^1(Z/ell^M)} hat theta_M(P)
#
# (5) の原理: ell は Q(zeta_{ell^M})/Q で完全分岐（e = phi(ell^M), f = 1）なので、
#   x in Z[zeta] に対し v_p(x) = v_ell(Norm(x)) であり、hat theta_M = phi(ell^M) v_ell(x) = v_p(x)。
#   Norm(R(g)) = Res_y(Psi_{ell^M}(y), R(y))（Psi は monic な円分多項式）。
#   よって hat theta_M(a,b) = v_ell(Res(Psi_{ell^M}, R_{(a,b)}))。整数の終結式だけで閉じる。
#   **最小点の一意性のような仮定を一切置かない**（定理 B' を使わない）ので、
#   本サイクルの理論から独立な実測値である。

load('../cycle19_T3_theta_infinity/_defs19.sage')


# ==========================================================================
# (1) bar tilde E in F_ell[z,w]
# ==========================================================================

_EBAR_CACHE = {}

def ebar(Ev, ell):
    """bar tilde E in F_ell[z,w]（Ev = E = ell^{-mu} D は Laurent）。"""
    key = (str(Ev), ell)
    if key in _EBAR_CACHE:
        return _EBAR_CACHE[key]
    Fl = GF(ell)
    Rl = PolynomialRing(Fl, ['z', 'w'])
    cs = tilde_coeffs(Ev)
    out = Rl({(ZZ(p), ZZ(q)): Fl(c) for ((p, q), c) in cs.items()})
    _EBAR_CACHE[key] = out
    return out


def ebar_support(Ev, ell):
    """S = supp(bar tilde E) subset N^2。"""
    Eb = ebar(Ev, ell)
    return sorted(tuple(ZZ(t) for t in e) for (e, c) in Eb.dict().items() if c != 0)


def normalize_primitive(u):
    """原始ベクトルの符号を正規化（+-1 を同一視するための代表）。"""
    (a, b) = (ZZ(u[0]), ZZ(u[1]))
    g = gcd(a, b)
    a, b = a // g, b // g
    if a < 0 or (a == 0 and b < 0):
        a, b = -a, -b
    return (a, b)


def candidate_directions(Ev, ell):
    """系 J10 (5.9) / 命題 3 の候補集合。
       S = supp(bar tilde E) の相異なる 2 点の差 (dp,dq) に対し u = (dq, -dp) を原始化したもの。"""
    S = ebar_support(Ev, ell)
    cand = set()
    for (p1, q1) in S:
        for (p2, q2) in S:
            if (p1, q1) == (p2, q2):
                continue
            dp, dq = p1 - p2, q1 - q2
            cand.add(normalize_primitive((dq, -dp)))
    return sorted(cand)


# ==========================================================================
# (2) 判定手続き（3 通りの独立実装）
# ==========================================================================

def test_T1_classes(Ev, ell, u):
    """系 J10 (5.8): gamma = p a + q b の類ごとの係数和が全て 0 か。"""
    (a, b) = (ZZ(u[0]), ZZ(u[1]))
    Fl = GF(ell)
    Eb = ebar(Ev, ell)
    acc = {}
    for (e, c) in Eb.dict().items():
        if c == 0:
            continue
        g = ZZ(e[0]) * a + ZZ(e[1]) * b
        acc[g] = acc.get(g, Fl(0)) + Fl(c)
    return all(v == 0 for v in acc.values())


def binom_multiplicity(Ev, ell, v):
    """m_v = max{ m : (chi^v - 1)^m | bar tilde E } in F_ell[z^{+-1}, w^{+-1}]。
       chi^v - 1 は chi^{v_-} を掛けて多項式 f = chi^{v_+} - chi^{v_-} にする（同伴）。
       f は z にも w にも割り切れないので、Laurent での割り切りと多項式での割り切りは一致する。"""
    Fl = GF(ell)
    Rl = PolynomialRing(Fl, ['z', 'w'])
    Eb = Rl(ebar(Ev, ell))
    if Eb == 0:
        return Infinity
    (p, q) = (ZZ(v[0]), ZZ(v[1]))
    f = Rl({(max(0, p), max(0, q)): Fl(1), (max(0, -p), max(0, -q)): Fl(-1)})
    m = 0
    cur = Eb
    while True:
        (qt, rm) = cur.quo_rem(f)
        if rm != 0:
            return m
        cur = qt
        m += 1
        if m > 200:
            raise RuntimeError('binom_multiplicity did not terminate')


def test_T2_divides(Ev, ell, u):
    """命題 2: (chi^{u^perp} - 1) | bar tilde E か。"""
    return binom_multiplicity(Ev, ell, perp(u)) >= 1


def test_T3_stage(Ev, ell, u):
    """cycle 19 step 2 補題 2.2: theta(u) = infinity <=> lam(u) >= 1。"""
    (lam, th, m1) = stage_data(Ev, ell, ZZ(u[0]), ZZ(u[1]))
    return (lam is Infinity) or (lam >= 1)


def s_infinity(Ev, ell):
    """S_infinity の完全決定。
       戻り値 list of dict(u, lam, thstar, mult, jstar, ej)。
       u は原始整数ベクトル（+-1 同一視の代表）で、P^1(Z_ell) の有理点そのものを表す。"""
    out = []
    for u in candidate_directions(Ev, ell):
        t1 = test_T1_classes(Ev, ell, u)
        t2 = test_T2_divides(Ev, ell, u)
        t3 = test_T3_stage(Ev, ell, u)
        if not (t1 == t2 == t3):
            raise RuntimeError('decision tests disagree: u=%s T1=%s T2=%s T3=%s'
                               % (u, t1, t2, t3))
        if not t1:
            continue
        (lam, th, m1) = stage_data(Ev, ell, ZZ(u[0]), ZZ(u[1]))
        mult = binom_multiplicity(Ev, ell, perp(u))
        (ej, jstar) = e_profile(Ev, ell, u)
        out.append(dict(u=u, lam=lam, thstar=th, m1=m1, mult=mult, jstar=jstar, ej=ej))
    return out


# ==========================================================================
# (4) e_j と j^*
# ==========================================================================

def _ord_at_one(pairs, ell):
    """{exponent: coeff in F_ell} で表される sum c_e y^e in F_ell[y^{+-1}] について、
       y = 1 + x と置いたときの ord_{x=0}。恒等的に 0 なら +Infinity。"""
    Fl = GF(ell)
    items = [(ZZ(e), Fl(c)) for (e, c) in pairs.items() if Fl(c) != 0]
    if not items:
        return Infinity
    lo = min(e for (e, c) in items)
    Rx = PolynomialRing(Fl, 'x')
    xg = Rx.gen()
    F = sum(c * (1 + xg)**(e - lo) for (e, c) in items)
    if F == 0:
        return Infinity
    return ZZ(F.valuation())


def e_profile(Ev, ell, u):
    """基点 P = (a:b)（u = (a,b) 原始整数ベクトル）での e_j の list と j^* を返す。

       cycle 19 step 1 §3.1: bar tilde E(z, w(1+t)) = sum_j D_j(z,w) t^j,
       D_j = sum bar c_{pq} binomial(q,j) z^p w^q,  psi_j(x) = D_j((1+x)^a, (1+x)^b),
       e_j = ord_{x=0} psi_j,  j^* = min{ j >= 1 : e_j < infinity }。

       ell | a のときは chart を取り替え、動かす座標を z にする（binomial(p,j)）。
       scale 不変性（補題 4）より (1,c) 代表へ直さず (a,b) のまま計算してよい
       （ell が割らない側の指数で rho(x) = (1+x)^{a or b} - 1 の位数がちょうど 1）。"""
    (a, b) = (ZZ(u[0]), ZZ(u[1]))
    Eb = ebar(Ev, ell)
    terms = [((ZZ(e[0]), ZZ(e[1])), c) for (e, c) in Eb.dict().items() if c != 0]
    if not terms:
        return ([], None)
    use_w = (a % ell != 0)          # z を固定し w を動かす chart
    jmax = max((q if use_w else p) for ((p, q), c) in terms)
    ej = []
    for j in range(jmax + 1):
        pairs = {}
        for ((p, q), c) in terms:
            bc = binomial(q, j) if use_w else binomial(p, j)
            if bc % ell == 0:
                continue
            g = p * a + q * b
            pairs[g] = pairs.get(g, 0) + ZZ(bc) * ZZ(c)
        ej.append(_ord_at_one(pairs, ell))
    jstar = None
    for j in range(1, len(ej)):
        if ej[j] is not Infinity:
            jstar = j
            break
    return (ej, jstar)


# ==========================================================================
# (5)(6) hat theta_M と Theta_M の厳密計算（整数終結式）
# ==========================================================================

_CYCPOLY_CACHE = {}

def cyc_poly(ell, M):
    key = (ell, M)
    if key not in _CYCPOLY_CACHE:
        Ry = PolynomialRing(ZZ, 'y')
        _CYCPOLY_CACHE[key] = Ry(cyclotomic_polynomial(ell**M))
    return _CYCPOLY_CACHE[key]


def hat_theta_exact(Ev, ell, M, a, b):
    """hat theta_M(a,b) = phi(ell^M) * v_ell(E(g^a, g^b))（g は原始 ell^M 乗根）を厳密に返す。
       E(g^a,g^b) = 0 なら None。仮定を一切置かない実測値。"""
    Ry = PolynomialRing(ZZ, 'y')
    yv = Ry.gen()
    N = ell**M
    acc = {}
    for ((p, q), c) in tilde_coeffs(Ev).items():
        g = (ZZ(p) * ZZ(a) + ZZ(q) * ZZ(b)) % N
        acc[g] = acc.get(g, ZZ(0)) + ZZ(c)
    R = Ry({int(e): ZZ(c) for (e, c) in acc.items() if c != 0})
    if R == 0:
        return None
    Psi = cyc_poly(ell, M)
    R = R % Psi
    if R == 0:
        return None
    nrm = ZZ(Psi.resultant(R))
    if nrm == 0:
        return None
    return ZZ(nrm).valuation(ell)


def p1_reps(ell, M):
    """P^1(Z/ell^M) の代表 (a,b) の list（(1,c) が ell^{M-1}*? ... 標準の (ell+1)ell^{M-1} 点）。"""
    N = ell**M
    out = [(ZZ(1), ZZ(c)) for c in range(N)]
    out += [(ZZ(ell) * ZZ(c), ZZ(1)) for c in range(N // ell)]
    return out


def Theta_level(Ev, ell, M):
    """Theta_M = sum_{P in P^1(Z/ell^M)} hat theta_M(P)。
       どこかで E(zeta,xi) = 0（(H) の破れ）なら None。"""
    tot = ZZ(0)
    for (a, b) in p1_reps(ell, M):
        v = hat_theta_exact(Ev, ell, M, a, b)
        if v is None:
            return None
        tot += v
    return tot


# ==========================================================================
# b の実測（Theta_M の当てはめ）
# ==========================================================================

def fit_b(thetas, ell, levels):
    """Theta_M = A*M*ell^M + B*ell^M + C*M + D を levels（4 個）で解き、b = A*ell/(ell-1) を返す。
       thetas は {M: Theta_M}。戻り値 (b, (A,B,C,D))。解けなければ None。"""
    rows, rhs = [], []
    for M in levels:
        rows.append([QQ(M) * ell**M, QQ(ell**M), QQ(M), QQ(1)])
        rhs.append(QQ(thetas[M]))
    Mx = matrix(QQ, rows)
    if Mx.det() == 0:
        return None
    sol = Mx.solve_right(vector(QQ, rhs))
    A = sol[0]
    return (A * ell / (ell - 1), tuple(sol))


def predict_theta(coef, ell, M):
    (A, B, C, D) = coef
    return A * M * ell**M + B * ell**M + C * M + D
