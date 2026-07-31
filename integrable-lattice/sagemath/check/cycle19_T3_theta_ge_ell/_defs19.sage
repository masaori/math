# cycle 19 / T3: theta >= ell+1 の領域を扱うための共有定義。
#
# cycle 18 の _defs18.sage（pi 展開係数 A_m、方向、theta）を土台にし、本サイクルの
# 中心的な道具を追加する。
#
# 対応する証明本体: outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md
#
# 追加する道具（report の記号）:
#
#   Phi_{(a,b)}(x) = tilde E((1+x)^a, (1+x)^b) = sum_m A_m(a,b) x^m  in ZZ[x]
#       cycle 18 補題 A5 の 1 変数多項式そのもの。ZZ 上で作れば A_m は係数として一度に出る。
#
#   theta(a,b) = ord_{x=0} of (Phi mod ell)                （消滅深度。cycle 18 の定義）
#
#   hat theta_M(a,b) = phi(ell^M) * v_ell(E(g^a, g^b))     （実測される深さ）
#       定理 B'（本サイクル）: min_m ( phi(ell^M) v_ell(A_m) + m ) が一意に達成されるなら
#       hat theta_M(a,b) はその最小値に等しい。これは Phi の「2 つの付値に関する
#       Newton 多角形」の最小点であって、塔の値も円分体の計算も使わない。
#
#   psi_j(x) = D_j((1+x)^{a0}, (1+x)^{b0}) mod ell, e_j = ord psi_j
#       D_j は tilde E の（乗法的な）第 j Hasse 微分。ファイバー上の Newton 公式に使う。
#
#   Lambda(r) = min_j ( e_j + j ell^r )
#       方向 P0 のファイバーの点 beta（v_ell(beta) = r-1）での theta の下界。
#
# 単位の約束: v_ell は v_ell(ell) = 1 と正規化する。hat theta は phi(ell^M) 倍した整数。

load('../cycle18_T3_general_degenerate/_defs18.sage')

Zx = PolynomialRing(ZZ, 'x')
xZ = Zx.gen()

_FX = {}
def Fx(ell):
    if ell not in _FX:
        _FX[ell] = PolynomialRing(GF(ell), 'x')
    return _FX[ell]

# ==========================================================================
# Phi と theta
# ==========================================================================

def Phi_ZZ(coeffs, a, b):
    """Phi_{(a,b)}(x) = sum_{(p,q)} c_{pq} (1+x)^{p a + q b}  in ZZ[x]。
       係数がそのまま A_m(a,b)（cycle 18 補題 A1・A5）。"""
    f = Zx(0)
    one_plus = Zx(1 + xZ)
    for ((p, q), c) in coeffs.items():
        f += ZZ(c) * one_plus**(ZZ(p) * ZZ(a) + ZZ(q) * ZZ(b))
    return f

def Phi_bar(coeffs, ell, a, b):
    """Phi_{(a,b)} mod ell  in F_ell[x]。"""
    R = Fx(ell); x = R.gen()
    f = R(0)
    one_plus = R(1 + x)
    for ((p, q), c) in coeffs.items():
        cc = GF(ell)(c)
        if cc != 0:
            f += cc * one_plus**(ZZ(p) * ZZ(a) + ZZ(q) * ZZ(b))
    return f

def theta_of(coeffs, ell, a, b):
    """theta(a,b) = ord_{x=0}(Phi mod ell)。恒等的に消えるなら +Infinity。"""
    f = Phi_bar(coeffs, ell, a, b)
    return oo if f == 0 else ZZ(f.valuation())

# ==========================================================================
# 定理 B'（Phi の 2 付値 Newton 多角形）
# ==========================================================================

def hat_theta_predicted(coeffs, ell, M, a, b):
    """min_m ( phi(ell^M) v_ell(A_m) + m ) と、その最小点が一意かどうか。

       返り値 (value, unique, argmin_list)。Phi = 0（E がその点で消える）なら
       (None, False, [])。定理 B' により unique なら value = hat theta_M(a,b)。"""
    f = Phi_ZZ(coeffs, a, b)
    if f == 0:
        return (None, False, [])
    ph = ZZ(euler_phi(ell**M))
    best = None; arg = []
    for m in range(f.degree() + 1):
        if best is not None and m > best:
            break                      # v_ell >= 0 なので m > best の項は最小になれない
        Am = ZZ(f[m])
        if Am == 0:
            continue
        val = ph * Am.valuation(ell) + m
        if best is None or val < best:
            best = val; arg = [m]
        elif val == best:
            arg.append(m)
    return (best, len(arg) == 1, arg)

# ==========================================================================
# ファイバー上の Newton 公式（psi_j, e_j, Lambda(r)）
# ==========================================================================

def theta_signed(coeffs, ell, a, b):
    """theta(a,b) を **符号つき整数** a,b に対して計算する。

       方向 (1:c) の mod ell 代表 c in {0..ell-1} と、Z_ell の点 -1 は**別の点**である。
       theta = oo になるのはしばしば b = -1 のような負の整数点なので、
       負の指数を扱えるようにしておく必要がある（本サイクルで踏んだ落とし穴）。
       (1+x)^T（T > 0）は単元なので、全指数を非負へずらしても位数は変わらない。"""
    R = Fx(ell); x = R.gen()
    one_plus = R(1 + x)
    exps = [ZZ(p) * ZZ(a) + ZZ(q) * ZZ(b) for (p, q) in coeffs.keys()]
    sh = -min(exps) if min(exps) < 0 else 0
    f = R(0)
    for (((p, q), c), e) in zip(coeffs.items(), exps):
        cc = GF(ell)(c)
        if cc != 0:
            f += cc * one_plus**(e + sh)
    return oo if f == 0 else ZZ(f.valuation())

def psi_data(coeffs, ell, a0, b0, pert):
    """psi_j(x) = D_j((1+x)^{a0},(1+x)^{b0}) mod ell の (e_j, 最低次係数) の list。

       pert = 'w' なら w を摂動する（D_j = sum c_{pq} binom(q,j) z^p w^q）、
       pert = 'z' なら z を摂動する（binom(p,j)）。
       方向 (1:c) のファイバーは (1, c + ell*beta) なので 'w'、
       方向 (0:1) のファイバーは (ell*beta, 1) なので 'z' を使う。"""
    R = Fx(ell); x = R.gen()
    one_plus = R(1 + x)
    idx = 1 if pert == 'w' else 0
    jmax = max(e[idx] for e in coeffs.keys())
    exps = [ZZ(p) * ZZ(a0) + ZZ(q) * ZZ(b0) for (p, q) in coeffs.keys()]
    sh = -min(exps) if min(exps) < 0 else 0    # 基点が負整数でもよいようにずらす
    out = []
    for j in range(jmax + 1):
        f = R(0)
        for (((p, q), c), e) in zip(coeffs.items(), exps):
            cc = GF(ell)(c) * GF(ell)(binomial((q if pert == 'w' else p), j))
            if cc != 0:
                f += cc * one_plus**(e + sh)
        if f == 0:
            out.append((oo, None))
        else:
            v = ZZ(f.valuation())
            out.append((v, f[v]))
    return out

def Lambda_at(es, ell, r, jmin=0):
    """Lambda(r) = min_{j >= jmin} ( e_j + j ell^r ) と argmin の list。"""
    vals = [(e + j * ell**r, j) for (j, (e, lc)) in enumerate(es)
            if e is not oo and j >= jmin]
    if not vals:
        return (oo, [])
    mv = min(v for (v, j) in vals)
    return (mv, [j for (v, j) in vals if v == mv])

def newton_criterion(es, ell):
    """系 J5 の判定条件: e_0 < oo かつ 全ての j >= 1 で e_j + j*ell > e_0。
       成立するとき theta はそのファイバー上で定数 e_0 である。"""
    (e0, _) = es[0]
    if e0 is oo:
        return False
    for (j, (e, lc)) in enumerate(es):
        if j == 0 or e is oo:
            continue
        if e + j * ell <= e0:
            return False
    return True

# ==========================================================================
# P^1(Z/ell^m) の代表と、レベルごとの Theta
# ==========================================================================

def P1_reps(ell, m):
    """P^1(Z/ell^m) の代表 (a,b) の list（個数 (ell+1) ell^{m-1}）。"""
    q = ell**m
    out = [(ZZ(1), ZZ(b)) for b in range(q)]
    out += [(ZZ(ell) * ZZ(a), ZZ(1)) for a in range(ell**(m - 1))]
    return out

def Theta_level(coeffs, ell, Mp):
    """Theta_{M'} = sum_{P in P^1(Z/ell^{M'})} hat theta_{M'}(P)。

       返り値 (Theta, ok)。ok は「全ての点で定理 B' の最小点が一意」だったか。
       一意でない点が 1 つでもあれば ok = False（値は最小値の和なので下界にすぎない）。"""
    tot = ZZ(0); ok = True
    for (a, b) in P1_reps(ell, Mp):
        (v, uniq, arg) = hat_theta_predicted(coeffs, ell, Mp, a, b)
        if v is None:
            return (None, False)
        if not uniq:
            ok = False
        tot += v
    return (tot, ok)

def predicted_ord_K(m, edges, ell, nmax):
    """定理 K の予言: ord_ell(kappa_n) = mu(ell^{2n}-1) - 2n + v_ell(kappa_X)
       + sum_{M'=1}^{n} Theta_{M'}。塔の値を一切使わない。

       返り値 (list of (n, pred, ok), inv)。"""
    D = detL(m, edges)
    mu = mu_content(D, ell)
    Ev = E_of(D, ell, mu)
    coeffs = cleared_coeffs(Ev)
    vkX = ZZ(kappa_derived(m, edges, 1, 1)).valuation(ell)
    out = []; acc = ZZ(0); allok = True
    for n in range(nmax + 1):
        if n >= 1:
            (th, ok) = Theta_level(coeffs, ell, n)
            if th is None:
                return (out, {'mu': mu, 'vkX': vkX, 'coeffs': coeffs, 'dead': True})
            acc += th; allok = allok and ok
        out.append((n, mu * (ell**(2 * n) - 1) + acc - 2 * n + vkX, allok))
    return (out, {'mu': mu, 'vkX': vkX, 'coeffs': coeffs, 'dead': False})

# ==========================================================================
# 方向ごとのデータ（e_j, 判定条件, j*）
# ==========================================================================

def direction_data(coeffs, ell):
    """P^1(F_ell) の各方向 P0 について (label, es, e0, criterion, jstar) を返す。
       jstar は e0 = oo のときの min{ j >= 1 : e_j < oo }（それ以外は None）。"""
    out = []
    for (a0, b0) in directions(ell):
        pert = 'w' if a0 == 1 else 'z'
        es = psi_data(coeffs, ell, a0, b0, pert)
        (e0, _) = es[0]
        crit = newton_criterion(es, ell)
        jstar = None
        if e0 is oo:
            cand = [j for (j, (e, lc)) in enumerate(es) if j >= 1 and e is not oo]
            jstar = min(cand) if cand else None
        out.append((dir_label((a0, b0)), es, e0, crit, jstar))
    return out
