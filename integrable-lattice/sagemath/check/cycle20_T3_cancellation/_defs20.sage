# cycle 20 / T3: 打ち消し（cycle 19 定理 J4 の |J(r)| >= 2）を潰すための共有定義。
#
# 対応する証明本体: outputs/reports/cycle20_T3_cancellation_recursion.md
#
# 中心となる 2 つの道具:
#
#   (1) 定理 L1（桁枝再帰）。
#       bar Phi_{(a,b)}(x) = sum_{(p,q)} bar c_{pq} (1+x)^{p a + q b}  in F_ell[[x]]
#       を「指数 gamma = p a + q b の mod ell の値 c」で枝分けすると
#           bar Phi(x) = sum_{c=0}^{ell-1} (1+x)^c * g_c(x^ell),
#       g_c は枝 c の測度の Amice 変換。ord は
#           theta = ell * min_c ord(g_c) + s*,
#           s* = min{ s >= 0 : sum_{c in C} lc(g_c) binom(c,s) != 0 }  (<= ell-1)
#       で**必ず**決まる（binom(c,s) の ell x ell 行列が下三角単位行列で可逆だから）。
#       定理 J4 の打ち消しはここでは起きない。
#
#   (2) 定理 L4（終結式公式）。
#       hat theta_M(a,b) = phi(ell^M) v_ell(E(zeta^a, zeta^b))
#                        = v_ell( Res_x( Psi_M(x), Phi_{(a,b)}(x) ) ),
#       Psi_M(x) = Phi_{ell^M}(1+x)（pi = zeta - 1 の最小多項式、モニック）。
#       ell は Q(zeta_{ell^M}) で完全分岐（e = phi, f = 1）なので
#       v_ell(N(alpha)) = phi * v_ell(alpha)。**整数の終結式ひとつ**で決まるので、
#       定理 B' の「最小点が一意」という仮定が要らない。
#
# 単位の約束は cycle 19 と同じ（v_ell(ell) = 1、hat theta は phi(ell^M) 倍した整数）。

load('../cycle19_T3_theta_ge_ell/_defs19.sage')

# ==========================================================================
# (1) 定理 L1: 桁枝再帰
# ==========================================================================

def collapsed_measure(coeffs, ell, a, b):
    """指数 gamma = p a + q b で項をまとめ、係数和が 0 でない類だけ残す。

       返り値 dict {gamma(int) -> mu(F_ell, nonzero)}。
       空 dict は「bar Phi = 0」すなわち theta = oo を意味する（cycle 19 系 J10 の (5.8)）。
       a, b は符号つき整数でよい（gamma も整数のまま扱う）。"""
    F = GF(ell)
    acc = {}
    for ((p, q), c) in coeffs.items():
        cc = F(c)
        if cc == 0:
            continue
        g = ZZ(p) * ZZ(a) + ZZ(q) * ZZ(b)
        acc[g] = acc.get(g, F(0)) + cc
    return dict((g, v) for (g, v) in acc.items() if v != 0)

def theta_lc_L1(meas, ell):
    """定理 L1 の再帰。meas は collapsed_measure の返り値。

       返り値 (theta, lc)。meas が空なら (oo, None)。
       lc は x^theta の係数（F_ell の非零元）。"""
    if not meas:
        return (oo, None)
    if len(meas) == 1:
        for (g, mu) in meas.items():
            return (ZZ(0), mu)
    F = GF(ell)
    branches = {}
    for (g, mu) in meas.items():
        c = ZZ(g) % ell
        branches.setdefault(ZZ(c), {})[(ZZ(g) - ZZ(c)) // ell] = mu
    sub = dict((c, theta_lc_L1(bm, ell)) for (c, bm) in branches.items())
    d = min(t for (t, lc) in sub.values())
    C = [c for c in sub if sub[c][0] == d]
    for s in range(ell):
        sig = F(0)
        for c in C:
            sig += sub[c][1] * F(binomial(ZZ(c), ZZ(s)))
        if sig != 0:
            return (ell * d + s, sig)
    raise RuntimeError("定理 L1 に反して s* が存在しない（binom 行列が可逆でない？）")

def theta_L1(coeffs, ell, a, b):
    """theta(a,b) を定理 L1 の再帰で計算する（仮定なし・打ち切りなし）。"""
    return theta_lc_L1(collapsed_measure(coeffs, ell, a, b), ell)[0]

def sep_of(meas, ell):
    """sep(nu) = min{ t >= 0 : gamma たちが mod ell^t で相異なる }。"""
    gs = sorted(meas.keys())
    if len(gs) <= 1:
        return ZZ(0)
    t = ZZ(0)
    for i in range(len(gs)):
        for j in range(i + 1, len(gs)):
            t = max(t, ZZ(gs[i] - gs[j]).valuation(ell))
    return t + 1

def J4_tie_data(coeffs, ell, a0, b0, r, pert='w'):
    """cycle 19 定理 J4 の Lambda(r) と argmin J(r)。|J(r)| >= 2 が打ち消しの可能性。"""
    es = psi_data(coeffs, ell, a0, b0, pert)
    return Lambda_at(es, ell, r)

# ==========================================================================
# (2) 定理 L4: hat theta の終結式公式
# ==========================================================================

_PSI = {}
def Psi_M(ell, M):
    """Psi_M(x) = Phi_{ell^M}(1+x) in ZZ[x]（pi = zeta_{ell^M} - 1 の最小多項式）。"""
    key = (ell, M)
    if key not in _PSI:
        _PSI[key] = Zx(cyclotomic_polynomial(ell**M)(1 + xZ))
    return _PSI[key]

def hat_theta_resultant(coeffs, ell, M, a, b):
    """定理 L4: hat theta_M(a,b) = v_ell( Res_x( Psi_M, Phi_{(a,b)} ) )。

       返り値 (value, exact_flag)。E(zeta^a,zeta^b) = 0（Res = 0）なら (None, True)。
       exact_flag は常に True（仮定を使っていないことの明示）。"""
    f = Phi_ZZ(coeffs, a, b)
    if f == 0:
        return (None, True)
    psi = Psi_M(ell, M)
    r = f % psi                      # psi はモニックなので ZZ[x] の中で割れる
    if r == 0:
        return (None, True)
    R = ZZ(psi.resultant(r))
    if R == 0:
        return (None, True)
    return (ZZ(R.valuation(ell)), True)

def Theta_level_exact(coeffs, ell, Mp):
    """Theta_{M'} = sum_{P in P^1(Z/ell^{M'})} hat theta_{M'}(P) を終結式で厳密に出す。

       返り値 (Theta, ok)。ある点で E が消えれば (None, False)。"""
    tot = ZZ(0)
    for (a, b) in P1_reps(ell, Mp):
        (v, _) = hat_theta_resultant(coeffs, ell, Mp, a, b)
        if v is None:
            return (None, False)
        tot += v
    return (tot, True)

def predicted_ord_K_exact(m, edges, ell, nmax):
    """定理 K′（無仮定版）: ord_ell(kappa_n) = mu(ell^{2n}-1) - 2n + v_ell(kappa_X)
       + sum_{M'=1}^{n} Theta_{M'}、Theta は終結式で厳密に計算する。

       返り値 (list of (n, pred), inv)。"""
    D = detL(m, edges)
    mu = mu_content(D, ell)
    Ev = E_of(D, ell, mu)
    coeffs = cleared_coeffs(Ev)
    vkX = ZZ(kappa_derived(m, edges, 1, 1)).valuation(ell)
    out = []
    acc = ZZ(0)
    for n in range(nmax + 1):
        if n >= 1:
            (th, ok) = Theta_level_exact(coeffs, ell, n)
            if th is None:
                return (out, {'mu': mu, 'vkX': vkX, 'coeffs': coeffs, 'dead': True})
            acc += th
        out.append((n, mu * (ell**(2 * n) - 1) + acc - 2 * n + vkX))
    return (out, {'mu': mu, 'vkX': vkX, 'coeffs': coeffs, 'dead': False})

# ==========================================================================
# 系 L3: S_oo 候補集合と、theta の距離による上界
# ==========================================================================

def sinf_candidates(coeffs, ell):
    """cycle 19 系 J10 (5.9) の候補集合。原始的な (a,b) の list（重複除去）。"""
    S = [k for (k, c) in coeffs.items() if GF(ell)(c) != 0]
    out = set()
    for i in range(len(S)):
        for j in range(len(S)):
            if i == j:
                continue
            (p, q) = S[i]; (pp, qq) = S[j]
            (dp, dq) = (ZZ(p - pp), ZZ(q - qq))
            (aa, bb) = (dq, -dp)
            g = gcd(aa, bb)
            if g == 0:
                continue
            (aa, bb) = (aa // g, bb // g)
            if aa < 0 or (aa == 0 and bb < 0):
                (aa, bb) = (-aa, -bb)
            out.add((aa, bb))
    return sorted(out)

def pair_val(ell, P, Q):
    """P=(a:b), Q=(p:q)（ともに原始的な整数ベクトル）の ell 進距離指数 v_ell(aq - bp)。"""
    (a, b) = P; (p, q) = Q
    d = ZZ(a) * ZZ(q) - ZZ(b) * ZZ(p)
    return oo if d == 0 else ZZ(d).valuation(ell)

def L3_bound(coeffs, ell, a, b):
    """系 L3 の上界 ell^{1 + max_delta v_ell(delta.(a,b))} - 1。

       max は supp(bar tilde E) の差ベクトル delta で、delta.(a,b) != 0 のものを走る。
       すべての差で delta.(a,b) = 0 なら oo（theta = oo の候補）。"""
    S = [k for (k, c) in coeffs.items() if GF(ell)(c) != 0]
    best = None
    allzero = True
    for i in range(len(S)):
        for j in range(i + 1, len(S)):
            (p, q) = S[i]; (pp, qq) = S[j]
            d = (ZZ(p) - ZZ(pp)) * ZZ(a) + (ZZ(q) - ZZ(qq)) * ZZ(b)
            if d == 0:
                continue
            allzero = False
            v = ZZ(d).valuation(ell)
            best = v if best is None else max(best, v)
    if allzero:
        return ZZ(0)                 # 全指数が一致 → theta = 0（または oo）
    if best is None:
        return ZZ(0)                 # |S| = 1（指数が 1 つ）なら theta = 0
    return ell**(1 + best) - 1

def gmax_of(coeffs, ell):
    """系 L3 の g^max = max_delta v_ell(gcd(delta))（delta は supp の差ベクトル）。"""
    S = [k for (k, c) in coeffs.items() if GF(ell)(c) != 0]
    best = ZZ(0)
    for i in range(len(S)):
        for j in range(i + 1, len(S)):
            (p, q) = S[i]; (pp, qq) = S[j]
            g = gcd(ZZ(p - pp), ZZ(q - qq))
            if g != 0:
                best = max(best, ZZ(g).valuation(ell))
    return best

def L3prime_bound(coeffs, ell):
    """系 L3′: S_oo = 空（候補点すべてで theta 有限）のときの **一様な** 上界。

       返り値 (bound, tmax, L0, gmax)。候補点のどれかで theta = oo なら None を返す
       （そのときは theta は一様に有界でない）。"""
    U = sinf_candidates(coeffs, ell)
    if not U:
        return None
    ths = [theta_L1(coeffs, ell, a, b) for (a, b) in U]
    if any(t is oo for t in ths):
        return None
    tmax = max(ths)
    L0 = ZZ(0)
    while ell**L0 < tmax:
        L0 += 1
    gm = gmax_of(coeffs, ell)
    return (max(tmax, ell**(gm + L0) - 1), tmax, L0, gm)
