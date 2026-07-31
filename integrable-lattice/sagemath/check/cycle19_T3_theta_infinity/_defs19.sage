# cycle 19 / T3: theta = infinity（方向上で bar E が恒等的に消える）の処理のための共有定義。
#
# cycle 18 の _defs18.sage（そのさらに土台は cycle 16 の _defs.sage）を load したうえで、
# 本サイクルの中心的な道具である「1 変数への制限」を追加する。
#
# 対応する証明本体: outputs/reports/cycle19_T3_theta_infinity.md
#
# 中心となる構成（report 定義 1.1・定理 S）:
#   tilde E in Z[z,w]（単項式で正規化した E）と (a,b) in Z^2 \ {0} に対し、
#   環準同型 psi_{(a,b)}: Z[z^{+-1}, w^{+-1}] -> Z[y^{+-1}], z |-> y^a, w |-> y^b を取り、
#       R_{(a,b)} := psi_{(a,b)}(tilde E) in Z[y^{+-1}]   （1 変数！）
#   と置く。単項式因子を落として y = 1 + x と書き直したものを Phi_{(a,b)}(x) in Z[x] とする。
#   これは cycle 18 補題 A5 の Phi と同じもので、Phi = sum_m A_m(a,b) x^m。
#
#   lam(a,b)   := v_ell(content Phi_{(a,b)})            （段数。cycle 18 の theta = infinity <=> lam >= 1）
#   thstar(a,b):= ord_{x=0} の (ell^{-lam} Phi) mod ell  （段階的処理のあとの消滅深度。常に有限）
#   m1(a,b)    := min{ m < thstar : B_m != 0 }（B = ell^{-lam} Phi の係数。無ければ +Infinity）
#
# 注意（report §2.3）: lam, thstar, m1 は「点 (zeta, xi)」ではなく「整数ベクトル (a,b)」の関数である。
# 同じ点は複数の (a,b) で代表され、値は代表に依る。定理 S は「ある代表で仮定が成り立てば」使える。

load('../cycle18_T3_general_degenerate/_defs18.sage')

Ly19 = LaurentPolynomialRing(ZZ, 'y'); yL19 = Ly19.gen()
Rx19 = PolynomialRing(ZZ, 'x'); xg19 = Rx19.gen()


def tilde_coeffs(D):
    """tilde E の係数 dict {(p,q): c}（p,q >= 0）。cleared_coeffs と同じ。"""
    return cleared_coeffs(D)


def restrict_laurent(D, a, b):
    """R_{(a,b)} = psi_{(a,b)}(tilde E) in Z[y^{+-1}]。a, b は任意の整数（負も可）。"""
    R = Ly19(0)
    for ((p, q), c) in tilde_coeffs(D).items():
        R += ZZ(c) * yL19**(ZZ(p) * ZZ(a) + ZZ(q) * ZZ(b))
    return R


def restrict_phi(D, a, b):
    """Phi_{(a,b)}(x) in Z[x]（単項式因子 y^{lo} を落として y = 1 + x と書いたもの）。
       R = 0 のときは 0 を返す。"""
    R = restrict_laurent(D, a, b)
    if R == 0:
        return Rx19(0)
    ex = R.exponents()
    lo = min(ex)
    return sum(ZZ(R[e]) * (1 + xg19)**(e - lo) for e in ex)


def stage_data(D, ell, a, b):
    """(lam, thstar, m1) を返す。Phi = 0（tilde E が恒等的に消える）なら (Infinity, None, None)。"""
    F = restrict_phi(D, a, b)
    if F == 0:
        return (Infinity, None, None)
    cs = [ZZ(c) for c in F.coefficients(sparse=False)]
    lam = min(ZZ(c).valuation(ell) for c in cs if c != 0)
    B = [ZZ(c) // ell**lam for c in cs]
    th = min(m for m in range(len(B)) if B[m] % ell != 0)
    lows = [m for m in range(th) if B[m] != 0]
    m1 = min(lows) if lows else Infinity
    return (lam, th, m1)


def theta_of(D, ell, a, b):
    """cycle 18 の消滅深度 theta（lam >= 1 なら +Infinity）。"""
    (lam, th, m1) = stage_data(D, ell, a, b)
    if lam is Infinity or lam >= 1:
        return Infinity
    return th


def staged_prediction(D, ell, M, a, b):
    """定理 S の予言値 lam + thstar/phi(ell^M) と、仮定 thstar - m1 < phi(ell^M) の成否。
       戻り値 (pred, hypothesis_holds)。"""
    (lam, th, m1) = stage_data(D, ell, a, b)
    if lam is Infinity:
        return (None, False)
    ph = euler_phi(ell**M)
    ok = (m1 is Infinity) or (th - m1 < ph)
    return (QQ(lam) + QQ(th) / ph, ok)


# --------------------------------------------------------------------------
# 例外直線（theta = infinity の軌跡）
# --------------------------------------------------------------------------

def newton_difference_body(D):
    """Newt(tilde E) - Newt(tilde E) に含まれる格子点の list（原点を除く）。
       report 命題 3 の有限性の根拠。"""
    pts = list(tilde_coeffs(D).keys())
    out = set()
    for (p1, q1) in pts:
        for (p2, q2) in pts:
            v = (ZZ(p1) - ZZ(p2), ZZ(q1) - ZZ(q2))
            if v != (0, 0):
                out.add(v)
    return sorted(out)


def primitive(v):
    (p, q) = v
    g = gcd(ZZ(p), ZZ(q))
    return (ZZ(p) // g, ZZ(q) // g)


def perp(u):
    """u = (a,b) に対する u^perp = (b,-a)。ker(Z^2 -> Z, (p,q) |-> pa+qb) の生成元。"""
    (a, b) = u
    return (ZZ(b), -ZZ(a))


def exceptional_lines(D, ell):
    """lam(u) >= 1 となる原始ベクトル u = (a,b) の代表（+-1 倍を同一視）の list。
       探索範囲は Newton 差体 から出る有限領域（report 命題 3）。"""
    cand = set()
    for v in newton_difference_body(D):
        u = primitive((-v[1], v[0]))   # v = u^perp = (b,-a) <=> u = (-v_1, v_0)
        if u[0] < 0 or (u[0] == 0 and u[1] < 0):
            u = (-u[0], -u[1])
        cand.add(u)
    out = []
    for u in sorted(cand):
        (lam, th, m1) = stage_data(D, ell, u[0], u[1])
        if lam is Infinity or lam >= 1:
            out.append((u, lam, th))
    return out


def binomial_divides(D, ell, v):
    """(chi^v - 1) が bar tilde E を F_ell[z^{+-1}, w^{+-1}] で割るか。
       単項式を掛けて F_ell[z,w] の割り算に落として判定する。"""
    Fl = GF(ell)
    Rl = PolynomialRing(Fl, ['z', 'w']); zl, wl = Rl.gens()
    cs = tilde_coeffs(D)
    Ebar = Rl({(ZZ(p), ZZ(q)): Fl(c) for ((p, q), c) in cs.items()})
    if Ebar == 0:
        return True
    (p, q) = (ZZ(v[0]), ZZ(v[1]))
    # chi^v - 1 = z^p w^q - 1 に z^{max(0,-p)} w^{max(0,-q)} を掛けて多項式にする
    f = Rl({(max(0, p), max(0, q)): Fl(1), (max(0, -p), max(0, -q)): Fl(-1)})
    # 単項式因子を除いた本体で割り切れるかを見る（単項式は F_ell[z^{+-1},w^{+-1}] の単元）
    return f.divides(Ebar)
