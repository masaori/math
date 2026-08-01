# cycle 22 / T3 Pure: 係数 d, e の構造と「mod ell の切れ目」のための共有定義。
#
# 対応する証明本体: outputs/reports/cycle22_T3_coefficients_d_e.md
#
# 前提（すでに証明済みで、ここでは道具として使うだけのもの）:
#   cycle21 定理 G2  捻り段データ (Lambda_k, theta^sharp_k)
#   cycle21 定理 G3  飽和深度 K(P0)
#   cycle21 定理 G4  alpha, beta, gamma の閉じた式（したがって a,b,c,d,e が D の係数から決まる）
#
# 本サイクルで新たに導入する量（report の番号）:
#   L(P0) := Lambda_0 + sum_{k=1}^{K} phi(ell^k) Lambda_k     （付値側の局所量。整数）
#   T(P0) := theta^sharp_0 + sum_{k=1}^{K} phi(ell^k) theta^sharp_k （位置側の局所量。整数）
#   Tdef  := sum_{M>=1} ( Theta_M - (alpha M ell^M + beta ell^M + gamma) )   （過渡欠損。M* に依らない）
#
# すべて有限計算（ZZ, F_ell, Z[zeta_{ell^k}] の整数演算）だけで閉じる。R へは脱出しない。

load('../cycle21_T3_general_closed_form/_defs21.sage')


# ==========================================================================
# (1) 局所量 L(P0), T(P0) と、c, d の局所形（report 定理 D1）
# ==========================================================================

def local_LT(dd, ell):
    """1 点 P0 の detail レコードから (L(P0), T(P0)) を返す。どちらも整数。"""
    Lsum = QQ(0); Tsum = QQ(0)
    for (k, Lam, ths, m1k, mult) in dd['tw']:
        Lsum += mult * Lam
        Tsum += mult * ths
    return (Lsum, Tsum)


def d_local(P, ell):
    """定理 D1: d = sum_{P0 in S_inf} ( T(P0) - e_{j*} ell^{K} ) - 2。
       A_gen も過渡も使わない、S_infinity だけの局所式。"""
    g = QQ(0)
    for dd in P['detail']:
        (Ls, Ts) = local_LT(dd, ell)
        g += Ts - QQ(dd['ejs']) * ell**dd['K']
    return g - 2


def c_local(P, ell):
    """定理 D1: c = ell/(ell-1) A_gen
                 + sum_{P0} [ e_{j*} ell^{1-r#}/(ell-1) - j*(K + r# + 1/(ell-1)) + L(P0) ]。
       (5.3)+(2.2) を整理しただけだが、Lambda 側が c に、theta^sharp 側が d に
       分かれて入ることがこの形で見える。"""
    rs = P['rsharp']
    val = QQ(ell) / (ell - 1) * P['Agen']
    for dd in P['detail']:
        (Ls, Ts) = local_LT(dd, ell)
        js = QQ(dd['jstar']); ejs = QQ(dd['ejs'])
        val += ejs * QQ(ell)**(1 - rs) / (ell - 1) \
               - js * (QQ(dd['K']) + rs + QQ(1) / (ell - 1)) + Ls
    return val


# ==========================================================================
# (2) 過渡欠損 Tdef と 5 係数（report 定理 D2）
# ==========================================================================

def transient(P, ell, Ms):
    """Tdef = sum_{M=1}^{Ms-1} ( Theta_M - (alpha M ell^M + beta ell^M + gamma) )。
       Ms >= 実際の漸近開始段 なら Ms に依らない（定理 D2）。"""
    al, be, ga = P['alpha'], P['beta'], P['gamma']
    acc = QQ(0)
    for M in range(1, Ms):
        t = Theta_level(P['Ev'], ell, M)
        if t is None:
            return None
        acc += t - (al * M * ell**M + be * ell**M + ga)
    return acc


def coeffs5(P, ell, Ms):
    """(a, b, c, d, e, Tdef) を返す。e は定理 D2 の形
           e = v_ell(kappa(X)) - a - c + Tdef
       ではなく、cycle21 (2.3) の形で独立に計算する（両者の一致は検証で見る）。"""
    al, be, ga = P['alpha'], P['beta'], P['gamma']
    acc = QQ(0)
    for M in range(1, Ms):
        t = Theta_level(P['Ev'], ell, M)
        if t is None:
            return None
        acc += t

    def SM(nn):
        return (ell - (nn + 1) * ell**(nn + 1) + nn * ell**(nn + 2)) / QQ((ell - 1)**2)

    def SE(nn):
        return (ell**(nn + 1) - ell) / QQ(ell - 1)

    const = acc - al * SM(Ms - 1) - be * SE(Ms - 1) - ga * (Ms - 1)
    a = QQ(P['mu'])
    b = al * ell / (ell - 1)
    c = be * ell / (ell - 1) - al * ell / (ell - 1)**2
    d = ga - 2
    e = -P['mu'] + P['vkX'] + const + al * ell / (ell - 1)**2 - be * ell / (ell - 1)
    tdef = acc - al * SM(Ms - 1) - be * SE(Ms - 1) - ga * (Ms - 1)
    return (a, b, c, d, e, tdef)


# ==========================================================================
# (3) K を水増ししても c, d が変わらないこと（report 命題 D1a）の再計算
# ==========================================================================

def recompute_bump(P, ell, bump):
    """飽和深度を K -> K + bump として (alpha, beta, gamma) を作り直す。
       cycle21 注 4.2 が「K は上界でよい」と言っているので、値は変わらないはず。"""
    Ev = P['Ev']; rs = P['rsharp']
    alpha = QQ(0); beta = QQ(P['Agen']); gamma = QQ(0)
    for dd in P['detail']:
        js = ZZ(dd['jstar']); ejs = ZZ(dd['ejs']); K = ZZ(dd['K']) + bump
        alpha += QQ((ell - 1) * js) / ell
        sumL = QQ(0); sumT = QQ(0)
        for k in range(K + 1):
            (Lam, ths, m1k) = twisted_stage(Ev, ell, dd['u'], k)
            if Lam is Infinity:
                return None
            mult = ZZ(1) if k == 0 else euler_phi(ell**k)
            sumL += mult * Lam
            sumT += mult * ths
        beta += QQ(ejs) / ell**rs - QQ(js * (K + rs) * (ell - 1)) / ell \
                + QQ(ell - 1) / ell * sumL
        gamma += -QQ(ejs) * ell**K + sumT
    c = beta * ell / (ell - 1) - alpha * ell / (ell - 1)**2
    return (alpha, beta, gamma, c, gamma - 2)


# ==========================================================================
# (4) 生の D から閉形式を作る（摂動実験用）
# ==========================================================================
# closed_form() は voltage グラフを受け取り、(H)（全段連結）を系 C2' で確認する。
# 摂動 tilde E -> tilde E + ell^N g はグラフとして実現できるとは限らないので、
# ここでは D と v_ell(kappa(X)) を直接受け取る版を用意する。
# **(H) の確認をしない**ので、この版の出力は「(Lambda_k, theta^sharp_k) と、
# それから形式的に作った c, d」の比較にのみ使う（report §5 の但し書き）。

def closed_form_D(D, ell, vkX=0, Lmax=4):
    mu = mu_content(D, ell)
    Ev = E_of(D, ell, mu)
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
        if ell**L >= tm:
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
            sumL += mult * Lam; sumT += mult * ths
            tw.append((k, Lam, ths, m1k, mult))
        beta += QQ(ejs) / ell**rsharp - QQ(js * (K + rsharp) * (ell - 1)) / ell \
                + QQ(ell - 1) / ell * sumL
        gamma += -QQ(ejs) * ell**K + sumT
        detail.append(dict(u=rec['u'], jstar=js, ejs=ejs, K=K, tw=tw,
                           lam=rec['lam'], thstar=rec['thstar']))
    b = alpha * ell / (ell - 1)
    c = beta * ell / (ell - 1) - alpha * ell / (ell - 1)**2
    return dict(inv=None, Ev=Ev, S=S, r0=r0, rsharp=rsharp, Agen=Agen, Luse=Luse,
                thmaxU=thmaxU, alpha=alpha, beta=beta, gamma=gamma,
                a=QQ(mu), b=b, c=c, d=gamma - 2, detail=detail,
                mu=ZZ(mu), vkX=ZZ(vkX))


# ==========================================================================
# (5) report §6 の族 X_t（1 頂点 bouquet: (1,0), (0,1), (1,-1) を t 本）
# ==========================================================================

def X_t(t):
    return [(0, 0, (1, 0)), (0, 0, (0, 1))] + [(0, 0, (1, -1))] * t


def max_Lambda(P):
    """max over P0, k<=K of Lambda_k。定理 D4 の精度しきい値。"""
    best = QQ(0)
    for dd in P['detail']:
        for (k, Lam, ths, m1k, mult) in dd['tw']:
            best = max(best, QQ(Lam))
    return best
