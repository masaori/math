# cycle 21 / T3 Pure: 一般の塔の閉形式（5 係数すべて）のための共有定義。
#
# 対応する証明本体: outputs/reports/cycle21_T3_general_closed_form.md
#
# 中心となる道具（report の番号）:
#   定理 G1  Theta_M = alpha*M*ell^M + beta*ell^M + gamma （M >= M*）から
#            ord_ell(kappa_n) = a*ell^{2n} + b*n*ell^n + c*ell^n + d*n + e への変換
#   定理 G2  捻り段データ (Lambda_k, theta^sharp_k)：S_infinity の点 P0 のまわりの
#            「深さ k の層」（P = u + ell^{M-k} t e、eta = zeta^{ell^{M-k}} は位数 ell^k）で
#            hat theta_M = phi(ell^M) Lambda_k + theta^sharp_k
#   定理 G3  飽和深度 K(P0) = max{ k >= 0 : 深さ k の層が飽和する } は j^* から明示に決まる
#   定理 G4  alpha, beta, gamma の閉じた式（したがって b, c, d, e が D の係数から決まる）
#
# すべて有限計算（ZZ, F_ell, Z[zeta_{ell^k}] の整数演算）だけで閉じる。R へは脱出しない。

load('../cycle20_T3_s_infinity/_defs20.sage')

# ==========================================================================
# (1) S_infinity の幾何：球が互いに素になる r_0、j^* が argmin を取る R'
# ==========================================================================

def sinf_r0(S, ell):
    """系 W5 の r_0 = 1 + max_{P != P'} v_ell(det(u,u'))（|S| <= 1 なら 1）。"""
    if len(S) <= 1:
        return ZZ(1)
    best = ZZ(0)
    for i in range(len(S)):
        for j in range(i + 1, len(S)):
            (a, b) = S[i]['u']; (p, q) = S[j]['u']
            d = ZZ(a) * ZZ(q) - ZZ(b) * ZZ(p)
            best = max(best, ZZ(d).valuation(ell))
    return best + 1


def Rprime(rec, ell, r0):
    """r >= R' で Lambda(r) = min_j (e_j + j ell^r) の argmin が j^* だけになる最小の R'（>= r0）。"""
    ej = rec['ej']; js = rec['jstar']
    r = max(ZZ(r0), ZZ(1))
    while True:
        vals = [(ej[j] + j * ell**r, j) for j in range(len(ej)) if ej[j] is not Infinity]
        m = min(v for (v, j) in vals)
        if [j for (v, j) in vals if v == m] == [js]:
            return r
        r += 1
        if r > 60:
            raise RuntimeError('Rprime が収束しない（j^* の仮定が壊れている）')


# ==========================================================================
# (2) 定理 G3: 飽和深度 K(P0)
# ==========================================================================

def sat_depth(rec, ell):
    """K(P0) = max{ k >= 0 : 深さ k の層で定理 B' の最小点が m = theta で一意にならない }。

       深さ k の層では theta = e_{j*} + j* ell^{M-k}、phi(ell^M) = (ell-1) ell^{M-1} なので、
       非飽和（argmin が m = theta で一意）⇔ e_{j*} + j* ell^{M-k} - m_1 < (ell-1) ell^{M-1}。
       M について漸近的には j* ell^{1-k} < ell-1、等号のときだけ e_{j*} < m_1 で決まる。
       k = 0（P0 自身を含む最内球）は常に飽和側（そこでは theta = oo）。"""
    js = ZZ(rec['jstar']); ejs = rec['ej'][js]; m1 = rec['m1']
    m1v = Infinity if m1 is Infinity else ZZ(m1)
    K = ZZ(0)
    k = ZZ(1)
    while True:
        # j* ell^{1-k} vs ell-1  を分母を払って比較
        lhs = js * ell           # j* ell^{1-k} * ell^k = j* ell
        rhs = (ell - 1) * ell**k
        if lhs > rhs:
            sat = True
        elif lhs == rhs:
            sat = not (m1v is not Infinity and ZZ(ejs) < m1v)
        else:
            sat = False
        if not sat:
            return K
        K = k
        k += 1
        if k > 40:
            raise RuntimeError('sat_depth が収束しない')


# ==========================================================================
# (3) 定理 G2: 捻り段データ (Lambda_k, theta^sharp_k)
# ==========================================================================

def _complete_basis(u):
    """det(u, e) = 1 となる整数ベクトル e を返す（u は原始）。"""
    (a, b) = (ZZ(u[0]), ZZ(u[1]))
    g, s, t = xgcd(a, b)      # s a + t b = 1
    assert g == 1
    return (-t, s)            # det(u, e) = a*s - b*(-t) = a s + b t = 1


def twisted_stage(Ev, ell, u, k):
    """深さ k の層での段データ (Lambda_k, theta^sharp_k, m1_k) を返す。

       P = u + ell^{M-k} e（e は det(u,e)=1）に対し zeta^{ell^{M-k}} = eta（位数 ell^k）だから
           E(zeta^a, zeta^b) = Phi^{[k]}(pi),
           Phi^{[k]}(x) := tilde E( (1+x)^{u_1} eta^{e_1}, (1+x)^{u_2} eta^{e_2} ) in Z[eta][x].
       Lambda_k = min_m v_ell(A_m)、theta^sharp_k = min{ m : v_ell(A_m) = Lambda_k }、
       m1_k = min{ m < theta^sharp : A_m != 0 }（の v_ell は Lambda より真に大きい）。
       v_ell は v_ell(ell) = 1 に正規化（ell は Q(eta)/Q で完全分岐、f = 1 なので
       v_ell(alpha) = v_ell(Norm(alpha)) / phi(ell^k)）。

       k = 0 では eta = 1 で、cycle 19 step 2 の stage_data と一致する。"""
    if k == 0:
        (lam, th, m1) = stage_data(Ev, ell, ZZ(u[0]), ZZ(u[1]))
        return (QQ(lam), ZZ(th), m1)
    N = ell**k
    F = CyclotomicField(N, 'eta')
    eta = F.gen()
    ph = euler_phi(N)
    e = _complete_basis(u)
    Rx = PolynomialRing(F, 'x')
    xg = Rx.gen()
    terms = []
    for ((p, q), c) in tilde_coeffs(Ev).items():
        expo = ZZ(p) * ZZ(u[0]) + ZZ(q) * ZZ(u[1])
        tw = (ZZ(p) * ZZ(e[0]) + ZZ(q) * ZZ(e[1])) % N
        terms.append((expo, tw, ZZ(c)))
    lo = min(t[0] for t in terms)
    Phi = Rx(0)
    for (expo, tw, c) in terms:
        Phi += c * eta**tw * (1 + xg)**(expo - lo)
    if Phi == 0:
        return (Infinity, None, None)
    cs = Phi.coefficients(sparse=False)

    def vv(alpha):
        if alpha == 0:
            return Infinity
        return QQ(ZZ(F(alpha).norm()).valuation(ell)) / ph

    vs = [vv(c) for c in cs]
    Lam = min(v for v in vs if v is not Infinity)
    th = min(m for m in range(len(vs)) if vs[m] == Lam)
    lows = [m for m in range(th) if cs[m] != 0]
    m1 = min(lows) if lows else Infinity
    return (Lam, ZZ(th), m1)


# ==========================================================================
# (4) 定理 G4: alpha, beta, gamma と 5 係数
# ==========================================================================

def gen_sum(Ev, ell, S, rsharp, L):
    """sum over P in P^1(Z/ell^L) with dist(P, S_inf) > ell^{-rsharp} of theta(P)。
       S_infinity の球に入る点は除く。theta = oo が出たら None（起きないはず）。"""
    tot = ZZ(0)
    N = ell**rsharp
    for (a, b) in p1_reps(ell, L):
        skip = False
        for rec in S:
            (u1, u2) = rec['u']
            if (ZZ(a) * ZZ(u2) - ZZ(b) * ZZ(u1)) % N == 0:
                skip = True
                break
        if skip:
            continue
        t = theta_of(Ev, ell, ZZ(a), ZZ(b))
        if t is Infinity:
            return None
        tot += t
    return tot


def closed_form(m, edges, ell, Lmax=4):
    """定理 G4 の予言。塔の値も Theta_M の実測も一切使わない（D の係数だけから決める）。

       返り値 dict または None（(H) が破れる等）。"""
    inv = invariants(m, edges, ell)
    if inv is None:
        return None
    Ev = E_of(inv['D'], ell, inv['mu'])
    if ebar(Ev, ell) == 0:
        return None
    S = s_infinity(Ev, ell)
    for rec in S:
        if rec['jstar'] is None:
            return None
    r0 = sinf_r0(S, ell)
    rsharp = r0
    for rec in S:
        rsharp = max(rsharp, Rprime(rec, ell, r0))
    # A_gen: theta|_U が経由するレベル L（系 J2a より ell^L >= theta^max_U で十分）まで L を上げる。
    # 「2 段一致で打ち切る」だけでは十分条件にならない（report §8.3）ので、
    # 実測した theta^max_U で L の妥当性を必ず事後確認する。
    Agen = None; Luse = None; thmaxU = ZZ(0)
    for L in range(max(rsharp, 1), max(rsharp, 1) + Lmax):
        g = gen_sum(Ev, ell, S, rsharp, L)
        if g is None:
            return None
        tm = ZZ(0)
        for (a, b) in p1_reps(ell, L):
            skip = False
            for rec in S:
                (u1, u2) = rec['u']
                if (ZZ(a) * ZZ(u2) - ZZ(b) * ZZ(u1)) % ell**rsharp == 0:
                    skip = True; break
            if not skip:
                tm = max(tm, ZZ(theta_of(Ev, ell, ZZ(a), ZZ(b))))
        if ell**L >= tm:                      # 系 J2a の十分条件
            Agen = QQ(g) / ell**L; Luse = ZZ(L); thmaxU = tm
            break
    if Agen is None:
        return None

    alpha = QQ(0); beta = QQ(Agen); gamma = QQ(0)
    detail = []
    for rec in S:
        js = ZZ(rec['jstar']); ejs = ZZ(rec['ej'][js])
        K = sat_depth(rec, ell)
        alpha += QQ((ell - 1) * js) / ell
        sumL = QQ(0); sumT = QQ(0); tw = []
        for k in range(K + 1):
            (Lam, ths, m1k) = twisted_stage(Ev, ell, rec['u'], k)
            if Lam is Infinity:
                return None
            mult = ZZ(1) if k == 0 else euler_phi(ell**k)
            sumL += mult * Lam
            sumT += mult * ths
            tw.append((k, Lam, ths, m1k, mult))
        beta += QQ(ejs) / ell**rsharp - QQ(js * (K + rsharp) * (ell - 1)) / ell \
                + QQ(ell - 1) / ell * sumL
        gamma += -QQ(ejs) * ell**K + sumT
        detail.append(dict(u=rec['u'], jstar=js, ejs=ejs, K=K, tw=tw,
                           lam=rec['lam'], thstar=rec['thstar']))
    b = alpha * ell / (ell - 1)
    c = beta * ell / (ell - 1) - alpha * ell / (ell - 1)**2
    d = gamma - 2
    return dict(inv=inv, Ev=Ev, S=S, r0=r0, rsharp=rsharp, Agen=Agen, Luse=Luse,
                thmaxU=thmaxU, alpha=alpha, beta=beta, gamma=gamma,
                a=QQ(inv['mu']), b=b, c=c, d=d, detail=detail,
                mu=ZZ(inv['mu']), vkX=ZZ(inv['vkX']))


def Mstar(P, ell):
    """定理 G4 が Theta_M について成り立つ最小レベル M*（十分条件の明示形）。"""
    rsharp = P['rsharp']
    Kmax = max([dd['K'] for dd in P['detail']], default=ZZ(0))
    need = [ZZ(P['Luse']), rsharp + Kmax + 1]
    # 一般領域 U: phi(ell^M) > theta^max_U - 2
    M = ZZ(1)
    while euler_phi(ell**M) <= ZZ(P['thmaxU']) - 2:
        M += 1
    need.append(M)
    # 各 P0 の非飽和層・捻り段: phi(ell^M) > (theta^sharp - m1) * phi(ell^k) 相当
    for dd in P['detail']:
        for (k, Lam, ths, m1k, mult) in dd['tw']:
            gap = ZZ(0) if m1k is Infinity else ZZ(ths) - ZZ(m1k)
            M = ZZ(max(k, 1))
            while euler_phi(ell**M) <= gap * euler_phi(ell**k):
                M += 1
            need.append(M)
        M = ZZ(1)
        while euler_phi(ell**M) <= ZZ(dd['ejs']) + ZZ(dd['jstar']) * ell**(M - dd['K'] - 1) - 2:
            M += 1
            if M > 40:
                break
        need.append(M)
    return max(need)


def theta_pred(P, ell, M):
    return P['alpha'] * M * ell**M + P['beta'] * ell**M + P['gamma']


def ord_pred(P, ell, n, Ms):
    """閉形式の値（n >= Ms - 1）。Theta_M の実測は使わず、M < Ms の分だけ厳密に足す。"""
    ell = ZZ(ell)
    acc = QQ(0)
    for M in range(1, Ms):
        t = Theta_level(P['Ev'], ell, M)
        if t is None:
            return None
        acc += t
    # M = Ms..n の閉形式和
    al, be, ga = P['alpha'], P['beta'], P['gamma']
    def SM(nn):
        return (ell - (nn + 1) * ell**(nn + 1) + nn * ell**(nn + 2)) / QQ((ell - 1)**2)
    def SE(nn):
        return (ell**(nn + 1) - ell) / QQ(ell - 1)
    tail = al * (SM(n) - SM(Ms - 1)) + be * (SE(n) - SE(Ms - 1)) + ga * (n - Ms + 1)
    Sig = acc + tail
    return P['mu'] * (ell**(2 * n) - 1) - 2 * n + P['vkX'] + Sig
