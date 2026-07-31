# cycle 20 / T3 Pure: ell = 2 の退化塔（ell_equals_2）のための共有定義。
#
# 対応する証明本体: outputs/reports/cycle20_T3_ell_equals_2.md
#
# 土台として cycle 19 の 2 本の定義ファイルを load する。
#   ../cycle19_T3_theta_ge_ell/_defs19.sage   … psi_data / Lambda_at / P1_reps / hat_theta_predicted
#   ../cycle19_T3_theta_infinity/_defs19.sage … stage_data / exceptional_lines / newton_difference_body
# どちらも土台は cycle 18 _defs18.sage → cycle 16 _defs.sage（detL / point_val / tower_ords / kappa_derived）。
#
# **本ファイルで定義する量は、すべて cycle 20 の理論とは独立な計算経路である。**
# 検証対象（定理 Y / Y'）の予言と突き合わせるための「実測側」をここに置く。

load('../cycle19_T3_theta_ge_ell/_defs19.sage')
load('../cycle19_T3_theta_infinity/_defs19.sage')


# ==========================================================================
# 族 X(p,q) = 1 頂点 bouquet（voltage (1,0) の loop p 本、(0,1) の loop q 本）
# ==========================================================================

def fam(p, q):
    """族 X(p,q) の (頂点数, 辺 list)。"""
    return (1, [(0, 0, (1, 0))] * ZZ(p) + [(0, 0, (0, 1))] * ZZ(q))


def fam_invariants(p, q):
    """(mu, p', q', case, par) を返す。
       case in {'A', 'B'}:
         'A' … p', q' がともに奇（例外直線 (1,1),(1,-1)、Lambda = 2 lam0）
               par = (lam0, lamminus)。lam0 = v_2(p'+q')、lamminus = v_2(p'-q')。
         'B' … p' か q' の一方が偶（例外直線 1 本、Lambda = lam1）
               par = (lam1, w, swapped)。w = v_2(偶数側/2 + 奇数側)。
    """
    p = ZZ(p); q = ZZ(q)
    mu = gcd(p, q).valuation(2)
    pp = p // 2**mu
    qq = q // 2**mu
    if pp % 2 == 1 and qq % 2 == 1:
        lam0 = (pp + qq).valuation(2)
        lamm = Infinity if pp == qq else (pp - qq).valuation(2)
        return (mu, pp, qq, 'A', (lam0, lamm))
    if pp % 2 == 0:
        (pe, qo, swapped) = (pp, qq, False)
    else:
        (pe, qo, swapped) = (qq, pp, True)
    lam1 = pe.valuation(2)
    w = (pe // 2 + qo).valuation(2)
    return (mu, pp, qq, 'B', (lam1, w, swapped))


def nu2(x, mod):
    """v_2(x mod `mod`)。x = 0 mod `mod` なら +Infinity。"""
    x = ZZ(x) % ZZ(mod)
    return Infinity if x == 0 else x.valuation(2)


# --------------------------------------------------------------------------
# 定理 Y（ell = 2・族の点ごとの付値）の予言。**report §4 の主張そのもの**。
# --------------------------------------------------------------------------

def Y_pointwise(p, q, n, a, b, want_branch=False):
    """v_2(E(g^a, g^b))（g は原始 2^n 乗根）の定理 Y による予言値（QQ）。
       (a,b) = (0,0) のときは None。
       want_branch=True なら (値, 枝の名前) を返す。"""
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    N = 2**n
    if ZZ(a) % N == 0 and ZZ(b) % N == 0:
        return (None, 'trivial') if want_branch else None

    if case == 'A':
        (lam0, lamm) = par
        e = min(nu2(a, N), nu2(b, N))
        e = n if e is Infinity else min(e, n)
        m = n - e
        ap = (ZZ(a) // 2**e) % 2**m
        bp = (ZZ(b) // 2**e) % 2**m
        phim = 2**(m - 1)
        if m == 1:
            # 点は (1,0), (0,1), (1,1) の 3 つ。phi(2)=1。
            if ap % 2 == 1 and bp % 2 == 1:
                out = (QQ(2 + lam0), 'A/m=1/both-odd')
            else:
                out = (QQ(2), 'A/m=1/one-odd')
            return out if want_branch else out[0]
        if ap % 2 == 0 or bp % 2 == 0:
            out = (QQ(2) / phim, 'A/one-odd')
            return out if want_branch else out[0]
        s = nu2(ap - bp, 2**m)
        t = nu2(ap + bp, 2**m)
        r = max(s, t)
        if r is Infinity or r >= m:
            out = (QQ(lam0 * phim + 2) / phim, 'A/on-line')          # a' = +-b'（例外直線上）
        elif lam0 == 1 and r == m - 1:
            out = (QQ(2**m) / phim, 'A/saturated')                    # 4 による飽和（ell=2 固有）
        else:
            out = (QQ(2 + 2**r) / phim, 'A/generic')                  # 一般の深い点
        return out if want_branch else out[0]

    # case B
    (lam1, w, swapped) = par
    (A, B) = (b, a) if swapped else (a, b)   # A = 偶数側の指数、B = 奇数側の指数
    phin = 2**(n - 1)
    na = nu2(A, N)
    nb = nu2(B, N)
    Ua = Infinity if na is Infinity else lam1 * phin + 2**(na + 1)
    Ub = Infinity if nb is Infinity else 2**(nb + 1)
    if Ua is Infinity and Ub is Infinity:
        return (None, 'trivial') if want_branch else None
    if Ua == Ub:
        out = (QQ(2 + w), 'B/tie')                                     # 打ち消し。次の 2 進桁 w が効く
    elif Ua is Infinity or (Ub is not Infinity and Ub < Ua):
        out = (QQ(Ub) / phin, 'B/odd-side')
    else:
        out = (QQ(Ua) / phin, 'B/even-side')
    return out if want_branch else out[0]


# --------------------------------------------------------------------------
# 定理 Y'（ell = 2・族の閉形式）の予言。
# --------------------------------------------------------------------------

def Y_closed(p, q, n):
    """ord_2(kappa_n) の定理 Y' による予言（n >= 1）。n = 0 は 0。"""
    if n == 0:
        return ZZ(0)
    (mu, pp, qq, case, par) = fam_invariants(p, q)
    base = mu * (4**n - 1)
    if case == 'A':
        (lam0, lamm) = par
        if lam0 == 1:
            return base + 2 * n * 2**n + 4 * 2**n - 6 * n - 1
        return base + 2 * n * 2**n + 2 * lam0 * 2**n - 2 * n - 3 * lam0 + 2
    (lam1, w, swapped) = par
    if lam1 >= 2 or n == 1:
        return base + 2 * n * 2**n + lam1 * (2**n - 1)
    return base + 2 * n * 2**n + 2 * n - 1 + 2 * w


def X_prime_closed(p, q, ell, n):
    """cycle 19 step 2 定理 X'（ell 奇で証明済み）の閉形式を、そのまま ell に当てた値。
       ell = 2 でどこが合いどこが合わないかを見るために使う。"""
    p = ZZ(p); q = ZZ(q); ell = ZZ(ell)
    mu = gcd(p, q).valuation(ell)
    pp = p // ell**mu
    qq = q // ell**mu
    if (pp + qq) % ell == 0:
        Lam = 2 * (pp + qq).valuation(ell)
    elif pp % ell == 0:
        Lam = pp.valuation(ell)
    elif qq % ell == 0:
        Lam = qq.valuation(ell)
    else:
        return None       # 例外直線なし。定理 X' の対象外
    return mu * (ell**(2 * n) - 1) + 2 * n * ell**n + Lam * (ell**n - 1)


# ==========================================================================
# 実測側（cycle 20 の理論から独立な計算経路）
# ==========================================================================

def theta_levels(Ev, ell, nmax, budget=None):
    """Theta_m = sum_{P in P^1(Z/ell^m)} phi(ell^m) * v_ell(E(P))（m = 1..nmax）。
       補題 J1（cycle 19 step 1）: Sigma_n = sum_{m<=n} Theta_m。
       円分体での付値計算のみを使う（塔の値も本サイクルの理論も使わない）。
       塔が非連結（v = oo が出る）なら None。
       budget（秒）を渡すと、超えた時点で得られている m までを返す。"""
    import time as _t
    t0 = _t.time()
    out = []
    for m in range(1, nmax + 1):
        if budget is not None and _t.time() - t0 > budget:
            break
        ph = euler_phi(ell**m)
        tot = QQ(0)
        for (a, b) in P1_reps(ell, m):
            v = point_val(Ev, ell, m, a, b)
            if v is oo:
                return None
            tot += ph * v
        out.append(tot)
    return out


def ords_via_sigma(m, edges, ell, nmax, budget=None):
    """cycle 14 (1.1) を通した ord_ell(kappa_n)（n = 0..）。
       塔の値（Matrix-Tree / 終結式）を使わない独立経路。到達できた n までの list。"""
    D = detL(m, edges)
    mu = mu_content(D, ell)
    Ev = E_of(D, ell, mu)
    vk = ZZ(kappa_derived(m, edges, 1, 1)).valuation(ell)
    th = theta_levels(Ev, ell, nmax, budget=budget)
    if th is None:
        return None
    acc = QQ(0)
    out = [ZZ(0)]
    for n in range(1, len(th) + 1):
        acc += th[n - 1]
        out.append(mu * (ell**(2 * n) - 1) - 2 * n + vk + acc)
    return out


def jstar_of(coeffs, ell, u):
    """S_infty の点 u = (a0:b0)（原始整数ベクトル）での j*(u)。

       **チャートの取り方に注意**（本サイクルで実際に踏んだ誤り。report §8.1）:
       a0 が ell の単元なら (1:c) 型なので w を摂動する。
       a0 が ell で割れるなら (ell*beta:1) 型なので z を摂動する。
       a0 != 0 かどうかで分けると誤った j* が出る。"""
    (a0, b0) = (ZZ(u[0]), ZZ(u[1]))
    pert = 'w' if a0 % ell != 0 else 'z'
    es = psi_data(coeffs, ell, a0, b0, pert)
    cand = [j for (j, (e, lc)) in enumerate(es) if j >= 1 and e is not oo]
    return min(cand) if cand else None


def jstar_sum(Ev, ell):
    """(sum_{P in S_infty} j*(P), S_infty の詳細 list)。S_infty は
       cycle 19 step 2 の exceptional_lines（= 系 J10 の候補集合を判定したもの）で取る。"""
    coeffs = cleared_coeffs(Ev)
    lines = exceptional_lines(Ev, ell)
    det = []
    tot = ZZ(0)
    for (u, lam, th) in lines:
        js = jstar_of(coeffs, ell, u)
        if js is None:
            return (None, det)
        tot += js
        det.append((u, lam, th, js))
    return (tot, det)


def sinf_brute(Ev, ell, B=6):
    """S_infty の総当たり（原始整数ベクトル |a|,|b| <= B）。
       exceptional_lines（Newton 差体からの有限候補）が取りこぼしていないかの独立確認用。"""
    out = []
    for a in range(-B, B + 1):
        for b in range(0, B + 1):
            if (a, b) == (0, 0) or gcd(ZZ(a), ZZ(b)) != 1:
                continue
            if b == 0 and a != 1:
                continue
            (lam, th, m1) = stage_data(Ev, ell, a, b)
            if lam is Infinity or lam >= 1:
                out.append((a, b))
    return out


def fit_shape(ords, mu, ns):
    """ord_n = mu(ell^{2n}-1) + b n 2^n + c 2^n + d n + e を ns の 4 点で解く。
       解が一意でなければ None。返り値 (b, c, d, e)。"""
    M = Matrix(QQ, [[n * 2**n, 2**n, n, 1] for n in ns])
    if M.rank() < 4:
        return None
    rhs = vector(QQ, [ords[n] - mu * (4**n - 1) for n in ns])
    return tuple(M.solve_right(rhs))
