# cycle 21 / T3 Pure: 仮定 (B*) を落とすための共有定義。
#
# 対応する証明本体: outputs/reports/cycle21_T3_drop_assumption_B_star.md
#
# 中心となる構成（report §3 の分解）:
#   bar tilde E = c * chi^{w0} * prod_i (chi^{v_i} - 1)^{m_i} * bar G0   （cycle 20 定理 W4 の (4.1)）
#   に対し、**整数係数のまま**
#       B := prod_i (chi^{v_i} - 1)^{m_i}        in Z[z^{+-1}, w^{+-1}]
#       G := bar(tilde E)/bar(B) の任意の持ち上げ  in Z[z^{+-1}, w^{+-1}]
#       H := (tilde E - B G) / ell                in Z[z^{+-1}, w^{+-1}]   （割り切れる）
#   と置く。b = sum_i m_i。
#
# Laurent 多項式は dict {(p,q): c}（c は ZZ）で持つ。Sage の 2 変数 Laurent 環は
# quo_rem 等の扱いが面倒なので、必要な演算（積・差・スカラー倍・評価）だけ自前で持つ。
#
# 本ファイルは cycle 20 の _defs20.sage を load するので、
#   ebar / candidate_directions / binom_multiplicity / s_infinity / e_profile /
#   hat_theta_exact / p1_reps / Theta_level / invariants / E_of / tilde_coeffs / perp
# がそのまま使える。

import sys, time, itertools

load('../cycle20_T3_s_infinity/_defs20.sage')


# ==========================================================================
# Laurent 多項式（dict 表現）の最小限の算術
# ==========================================================================

def lp_from_tilde(Ev):
    """tilde E を dict {(p,q): c} で返す（p,q >= 0）。"""
    return {(ZZ(p), ZZ(q)): ZZ(c) for ((p, q), c) in tilde_coeffs(Ev).items() if ZZ(c) != 0}


def lp_clean(A):
    return {k: ZZ(v) for (k, v) in A.items() if ZZ(v) != 0}


def lp_mul(A, B):
    out = {}
    for ((p1, q1), c1) in A.items():
        for ((p2, q2), c2) in B.items():
            k = (p1 + p2, q1 + q2)
            out[k] = out.get(k, ZZ(0)) + c1 * c2
    return lp_clean(out)


def lp_sub(A, B):
    out = dict(A)
    for (k, c) in B.items():
        out[k] = out.get(k, ZZ(0)) - c
    return lp_clean(out)


def lp_divexact_scalar(A, d):
    """全係数が d で割り切れることを確かめて割る。割り切れなければ None。"""
    out = {}
    for (k, c) in A.items():
        if ZZ(c) % ZZ(d) != 0:
            return None
        out[k] = ZZ(c) // ZZ(d)
    return lp_clean(out)


def lp_one():
    return {(ZZ(0), ZZ(0)): ZZ(1)}


def lp_binom(v):
    """chi^v - 1 を dict で。"""
    (p, q) = (ZZ(v[0]), ZZ(v[1]))
    out = {(p, q): ZZ(1)}
    out[(ZZ(0), ZZ(0))] = out.get((ZZ(0), ZZ(0)), ZZ(0)) - ZZ(1)
    return lp_clean(out)


def lp_l1norm(A):
    """C_0 = sum |c|。補題 Q0（アルキメデス素点での粗い上界）で使う。"""
    return sum(abs(ZZ(c)) for c in A.values())


# ==========================================================================
# 二項式部分の抽出と、整数のままの分解 tilde E = B G + ell H
# ==========================================================================

def binomial_part(Ev, ell):
    """bar tilde E の原始二項式因子のリスト [(v, m), ...] と b = sum m を返す。
       v = u^perp（u は S_infinity の点の方向）。cycle 20 補題 W2 より
       (chi^{u^perp} - 1) | bar tilde E <=> u in S_infinity なので、
       候補集合（系 J10 (5.9)）を走査すれば尽くせる。"""
    parts = []
    for u in candidate_directions(Ev, ell):
        v = normalize_primitive(perp(u))
        m = binom_multiplicity(Ev, ell, v)
        if m >= 1:
            parts.append((v, ZZ(m), normalize_primitive(u)))
    parts.sort()
    b = sum(m for (_, m, _) in parts)
    return (parts, ZZ(b))


def _bar_laurent_dict(A, ell):
    """dict をF_ell 係数へ落とす（0 は捨てる）。"""
    Fl = GF(ell)
    return {k: Fl(c) for (k, c) in A.items() if Fl(c) != 0}


def _lift_dict(Abar):
    """F_ell 係数 dict を 0..ell-1 の代表で ZZ へ持ち上げる。"""
    return {k: ZZ(c) for (k, c) in Abar.items() if ZZ(c) != 0}


def _lp_quo_binom(Abar, v, ell):
    """F_ell 係数の Laurent dict Abar を (chi^v - 1) で割る（割り切れる前提）。
       割り切れなければ None。
       単項式 chi^{v_-} を掛けて 2 変数多項式にし、Sage の quo_rem に投げる。"""
    Fl = GF(ell)
    Rl = PolynomialRing(Fl, ['z', 'w'])
    if not Abar:
        return {}
    pmin = min(p for (p, q) in Abar)
    qmin = min(q for (p, q) in Abar)
    Apoly = Rl({(ZZ(p - pmin), ZZ(q - qmin)): c for ((p, q), c) in Abar.items()})
    (p, q) = (ZZ(v[0]), ZZ(v[1]))
    f = Rl({(max(0, p), max(0, q)): Fl(1), (max(0, -p), max(0, -q)): Fl(-1)})
    (qt, rm) = Apoly.quo_rem(f)
    if rm != 0:
        return None
    # chi^{v_-} 倍のぶんを戻す: f = chi^{v_-} (chi^v - 1) なので商に chi^{v_-} を掛け戻す
    shift = (max(0, -p), max(0, -q))
    out = {}
    for (e, c) in qt.dict().items():
        k = (ZZ(e[0]) + pmin + ZZ(shift[0]), ZZ(e[1]) + qmin + ZZ(shift[1]))
        out[k] = c
    return {k: c for (k, c) in out.items() if c != 0}


def decompose(Ev, ell):
    """tilde E = B * G + ell * H を返す。
       戻り値 dict(tE=, B=, G=, H=, parts=, b=, C0=)。
       H が整数で取れない（＝分解が破れる）場合は例外を投げる。"""
    tE = lp_from_tilde(Ev)
    (parts, b) = binomial_part(Ev, ell)
    B = lp_one()
    for (v, m, _u) in parts:
        for _ in range(m):
            B = lp_mul(B, lp_binom(v))
    # bar G = bar tilde E / bar B
    cur = _bar_laurent_dict(tE, ell)
    for (v, m, _u) in parts:
        for _ in range(m):
            cur = _lp_quo_binom(cur, v, ell)
            if cur is None:
                raise RuntimeError('bar B does not divide bar tilde E: v=%s' % (v,))
    G = _lift_dict(cur)
    H = lp_divexact_scalar(lp_sub(tE, lp_mul(B, G)), ell)
    if H is None:
        raise RuntimeError('tilde E - B G is not divisible by ell')
    return dict(tE=tE, B=B, G=G, H=H, parts=parts, b=ZZ(b), C0=lp_l1norm(tE))


def cand_dirs_dict(A, ell):
    """dict 表現の Laurent 多項式について、系 J10 (5.9) の候補方向 u を返す。"""
    Fl = GF(ell)
    S = sorted(k for (k, c) in A.items() if Fl(c) != 0)
    cand = set()
    for (p1, q1) in S:
        for (p2, q2) in S:
            if (p1, q1) == (p2, q2):
                continue
            cand.add(normalize_primitive((q1 - q2, -(p1 - p2))))
    return sorted(cand)


def binom_mult_dict(A, ell, v):
    """dict 表現について m_v = max{ m : (chi^v - 1)^m | bar A }。"""
    cur = _bar_laurent_dict(A, ell)
    if not cur:
        return Infinity
    m = 0
    while True:
        nxt = _lp_quo_binom(cur, v, ell)
        if nxt is None:
            return m
        cur = nxt
        m += 1
        if m > 200:
            raise RuntimeError('binom_mult_dict did not terminate')


# ==========================================================================
# theta（一般の整数 Laurent 多項式に対して）
# ==========================================================================

def theta_lp(A, ell, a, b):
    """theta_A(a,b) = ord_{x=0} of ( sum c_{pq} (1+x)^{p a + q b} mod ell )。
       恒等的に 0 なら +Infinity。"""
    Fl = GF(ell)
    pairs = {}
    for ((p, q), c) in A.items():
        if Fl(c) == 0:
            continue
        g = ZZ(p) * ZZ(a) + ZZ(q) * ZZ(b)
        pairs[g] = pairs.get(g, Fl(0)) + Fl(c)
    return _ord_at_one({k: ZZ(v) for (k, v) in pairs.items()}, ell)


def theta_scan(A, ell, L):
    """P^1(Z/ell^L) 上で theta_A を全走査し (最大値, 無限になった点のリスト) を返す。"""
    mx = ZZ(0)
    infs = []
    for (a, bb) in p1_reps(ell, L):
        t = theta_lp(A, ell, a, bb)
        if t is Infinity:
            infs.append((a, bb))
        elif t > mx:
            mx = ZZ(t)
    return (mx, infs)


def theta_G_max(Gd, ell, Lmax=4):
    """theta_G の上限を、レベルを上げながら安定するまで測る。
       戻り値 (theta_max, L_used, stable)。stable=False なら Lmax でも ell^L <= theta_max。"""
    prev = None
    for L in range(1, Lmax + 1):
        (mx, infs) = theta_scan(Gd, ell, L)
        if infs:
            raise RuntimeError('theta_G = infinity at %s (bar G still has a binomial factor)'
                               % (infs[:3],))
        if ell**L > mx:
            return (ZZ(mx), L, True)
        prev = mx
    return (ZZ(prev), Lmax, False)


# ==========================================================================
# rho_i, beta_P, 悪い点の集合
# ==========================================================================

def rho_of_point(v, ell, M, a, b):
    """rho = min(v_ell(<v,(a,b)>), M)。"""
    g = ZZ(v[0]) * ZZ(a) + ZZ(v[1]) * ZZ(b)
    g = ZZ(g) % ZZ(ell**M)
    if g == 0:
        return ZZ(M)
    return min(ZZ(g).valuation(ell), ZZ(M))


def beta_of_point(parts, ell, M, a, b):
    """beta_P = v_p(B(omega_P)) = sum_i m_i ell^{rho_i}。ある rho_i = M なら B(omega_P)=0 で
       beta = +Infinity（その点は悪い点）。"""
    tot = ZZ(0)
    for (v, m, _u) in parts:
        r = rho_of_point(v, ell, M, a, b)
        if r >= M:
            return Infinity
        tot += ZZ(m) * ell**r
    return tot


def hat_theta_lp(A, ell, M, a, b):
    """整数 Laurent dict A に対する v_p(A(omega_P))（p は ell の上の唯一の素点、v_p(ell)=phi）。
       A(omega_P) = 0 なら None。定理 L4 の終結式公式そのもの。"""
    Ry = PolynomialRing(ZZ, 'y')
    N = ell**M
    acc = {}
    for ((p, q), c) in A.items():
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


# ==========================================================================
# 母集団（cycle 20 s_infinity.sage と同一。再現性のため写す）
# ==========================================================================

V6 = [(1, 0), (0, 1), (1, 1), (1, -1), (2, 1), (1, 2)]
V4 = [(0, 0), (1, 0), (0, 1), (1, 1)]

POP = []
for L in (2, 3):
    for combo in itertools.combinations_with_replacement(V6, L):
        POP.append(('BQ%d %s' % (L, ','.join(str(c) for c in combo)),
                    1, [(0, 0, c) for c in combo]))
for combo in itertools.combinations_with_replacement(V4, 3):
    POP.append(('TV3 %s' % ','.join(str(c) for c in combo),
                2, [(0, 1, c) for c in combo]))
for p in range(1, 7):
    for q in range(p, 7):
        POP.append(('FAM p=%d q=%d' % (p, q), 1,
                    [(0, 0, (1, 0))] * p + [(0, 0, (0, 1))] * q))

# (B*) が破れることが cycle 20 §8.1 で確定している 2 塔を必ず含める
ADV = [
    ('ADV torus (1,0),(0,1)', 1, [(0, 0, (1, 0)), (0, 0, (0, 1))]),
    ('ADV bouquet (1,0),(0,1),(1,1),(1,-1)', 1,
     [(0, 0, c) for c in [(1, 0), (0, 1), (1, 1), (1, -1)]]),
    ('ADV bouquet (1,0),(1,-1),(1,2)', 1,
     [(0, 0, (1, 0)), (0, 0, (1, -1)), (0, 0, (1, 2))]),
    ('ADV bouquet (1,0)x3,(0,1),(1,2)', 1,
     [(0, 0, (1, 0))] * 3 + [(0, 0, (0, 1)), (0, 0, (1, 2))]),
    ('ADV bouquet (1,0)x2,(0,1),(1,1)', 1,
     [(0, 0, (1, 0))] * 2 + [(0, 0, (0, 1)), (0, 0, (1, 1))]),
    ('ADV bouquet (1,0)x3,(0,1)x3', 1,
     [(0, 0, (1, 0))] * 3 + [(0, 0, (0, 1))] * 3),
]
POP += ADV

PRIMES = [2, 3, 5, 7, 11]


def prepared(m, edges, ell):
    inv = invariants(m, edges, ell)
    if inv is None:
        return None
    Ev = E_of(inv['D'], ell, inv['mu'])
    if ebar(Ev, ell) == 0:
        return None
    return (inv, Ev)
