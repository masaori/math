# cycle 18 / T3: 一般の退化塔のための共有定義。
#
# cycle 16 の _defs.sage（voltage グラフ・終結式による塔の値・円分体での付値）を土台にし、
# 本サイクルの中心的な道具である「pi 展開係数 A_m(a,b)」を追加する。
#
# 対応する証明本体: outputs/reports/cycle18_T3_general_degenerate_tower.md
#
# 中心となる恒等式（report 補題 A1）:
#   tilde E(z,w) = sum_{(p,q)} c_{pq} z^p w^q  （p,q >= 0 に単項式で正規化した E）とすると、
#   g = 1 + pi を原始 ell^M 乗根、zeta = g^a, xi = g^b（a,b >= 0 の整数代表）として
#       tilde E(zeta, xi) = sum_{(p,q)} c_{pq} (1+pi)^{p a + q b}
#                         = sum_{m >= 0} A_m(a,b) pi^m,
#       A_m(a,b) = sum_{(p,q)} c_{pq} binomial(p a + q b, m)  in ZZ.
#   割り算も収束も現れない、整数の有限和である。

load('../cycle16_T3_lower_order/_defs.sage')

# ==========================================================================
# pi 展開係数 A_m(a,b)
# ==========================================================================

def cleared_coeffs(D):
    """E（Laurent）を単項式で正規化した tilde E の係数 dict {(p,q): c}（p,q >= 0）。"""
    (r, s, P) = clear_monomial(D)
    return {(ZZ(e[0]), ZZ(e[1])): ZZ(c) for (e, c) in P.dict().items() if c != 0}

def A_m_at(coeffs, a, b, m):
    """A_m(a,b) = sum c_{pq} binomial(p a + q b, m)。a,b は非負整数代表。"""
    tot = ZZ(0)
    for ((p, q), c) in coeffs.items():
        tot += c * binomial(ZZ(p) * ZZ(a) + ZZ(q) * ZZ(b), m)
    return tot

def A_vector_at(coeffs, a, b, mmax):
    return [A_m_at(coeffs, a, b, m) for m in range(mmax + 1)]

def delta_at(coeffs, ell, a, b, mmax):
    """delta(a,b) = min{ m <= mmax : ell does not divide A_m(a,b) }。
       見つからなければ None（mmax まででは決まらない）。"""
    for m in range(mmax + 1):
        if A_m_at(coeffs, a, b, m) % ell != 0:
            return m
    return None

def directions(ell):
    """P^1(F_ell) の代表 (a0,b0) の list。"""
    return [(ZZ(1), ZZ(c)) for c in range(ell)] + [(ZZ(0), ZZ(1))]

def dir_label(ab):
    (a, b) = ab
    return '(0:1)' if a == 0 else '(1:%s)' % b

def delta_profile(D, ell, mu, mmax=None):
    """各方向 P in P^1(F_ell) の theta(P)。mmax の既定は ell（digit 安定域）。
       m <= ell-1 は Lucas から、m = ell は A_1 = 0 から digit 安定。
       返り値 {label: theta or None}（None は「mmax までで決まらない」）。"""
    if mmax is None:
        mmax = ell
    Ev = E_of(D, ell, mu)
    coeffs = cleared_coeffs(Ev)
    out = {}
    for ab in directions(ell):
        out[dir_label(ab)] = delta_at(coeffs, ell, ab[0], ab[1], mmax)
    return out

def delta_sum(prof):
    """Delta_tot = sum_P delta(P)。どれか一つでも None なら None。"""
    if any(v is None for v in prof.values()):
        return None
    return sum(prof.values())

def predicted_ord_general(inv, ell, Dtot, n):
    """report 定理 G2 の予言値（フィットパラメータ 0 個）。
       ord_ell(kappa_n) = mu (ell^{2n}-1) + Dtot/(ell-1) (ell^n - 1) - 2n + v_ell(kappa(X))。"""
    mu = inv['mu']
    return (mu * (ell**(2 * n) - 1) + QQ(Dtot) / (ell - 1) * (ell**n - 1)
            - 2 * n + inv['vkX'])

# --------------------------------------------------------------------------
# 点ごとの付値の実測（delta の実測値 = v_ell(E) * phi(ell^M)）
# --------------------------------------------------------------------------

def delta_measured(D, ell, mu, M, a, b):
    """v_ell(E(g^a, g^b)) * phi(ell^M) の実測値。g は原始 ell^M 乗根。
       E(g^a,g^b) = 0 なら None。"""
    Ev = E_of(D, ell, mu)
    v = point_val(Ev, ell, M, a, b)
    if v is oo:
        return None
    return QQ(v) * euler_phi(ell**M)
