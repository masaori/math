# cycle 19 / T3 Pure: theta = infinity（方向上で bar E が恒等的に消える）の処理。
#
# 対応する証明本体: outputs/reports/cycle19_T3_theta_infinity.md
# 前提: outputs/reports/cycle18_T3_general_degenerate_tower.md（§4.5・§6.2 が本サイクルの出発点）
#
# 実行: sage theta_infinity.sage > theta_infinity.out 2>&1
#
# 検証する Step:
#   A  定理 S（段階的処理の点ごとの付値）を、円分体での独立な付値計算と照合する。
#   B  命題 2（lam >= 1 <=> 二項式 chi^{u^perp} - 1 が bar tilde E を割る）と
#      命題 3（例外直線は Newton 差体に入る有限集合）を照合する。
#   C  補題 4（スケール不変性 lam(cu) = lam(u), thstar(cu) = thstar(u), ell not| c）。
#   D  系 5（同居構造の計数）: レベルちょうど M・方向 P の点のうち例外直線に乗るものが
#      直線ごとにちょうど phi(ell^M) 個であること。
#   E  系 6（theta = infinity は cycle 18 定理 C の射程外でしか起きない）:
#      例外直線を持つ方向では一般点の theta >= ell + 1。
#   F  定理 X（族 p(1,0) + q(0,1), ell 奇 の完全閉形式）。
#      F1 点ごとの付値（全点網羅）、F2 Sigma_n、
#      F3 ord_ell(kappa_n) = mu(ell^{2n}-1) + 2n ell^n + Lam(ell^n-1)、
#      F4 例外直線の寄与 lam(ell^n - 1) + n thstar（n ell^n 項を作らないこと）、
#      F5 この族は ell 奇なら全塔が既知＋本サイクルの定理で覆われること。
#   G  母集団を網羅した分類（どの ell・どの塔で theta = infinity が起きるか）。
#   H  敵対的レビュー。
#
# **数値だけで支持している主張と、証明済み命題の照合とを report で区別してある。**
# 本ファイルの Step A-F・H は証明済み命題の照合、Step G は宣言した母集団の全走査
#（標本抽出ではないので、その母集団についての完全な判定である）。

load('_defs19.sage')

import sys
import time
from itertools import combinations_with_replacement

sys.stdout.reconfigure(line_buffering=True)

TOTAL_FAIL = 0
TOTAL_PASS = 0
CUTOFFS = []


def report(tag, ok, detail=''):
    global TOTAL_FAIL, TOTAL_PASS
    if ok:
        TOTAL_PASS += 1
    else:
        TOTAL_FAIL += 1
        print('    FAIL %s %s' % (tag, detail))


def hr(title):
    print()
    print('=' * 78)
    print(title)
    print('=' * 78)


def bouquet(spec):
    """spec = [((a,b), 本数), ...] の bouquet。"""
    edges = []
    for (v, cnt) in spec:
        edges += [(0, 0, v)] * cnt
    return (1, edges)


# theta = infinity を含む／含まない一般の例（cycle 16 の EX から取る）。
GENERAL = [
    ('bouquet 4x(1,0) + (0,1)', 1, [(0, 0, (1, 0))] * 4 + [(0, 0, (0, 1))], 5),
    ('bouquet 2x(1,0) + 3x(0,1)', 1, [(0, 0, (1, 0))] * 2 + [(0, 0, (0, 1))] * 3, 5),
    ('bouquet 2x(1,0) + (0,1)', 1, [(0, 0, (1, 0))] * 2 + [(0, 0, (0, 1))], 3),
    ('torus bouquet (1,0),(0,1)', 1, [(0, 0, (1, 0)), (0, 0, (0, 1))], 5),
    ('torus bouquet (1,0),(0,1)', 1, [(0, 0, (1, 0)), (0, 0, (0, 1))], 2),
    ('bouquet (1,0),(0,1),(1,1)', 1, [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (1, 1))], 3),
    ('bouquet (1,0),(0,1),(1,-1)', 1,
     [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (1, -1))], 5),
    ('2 vertex 3-fold (0,0),(1,0),(0,1)', 2,
     [(0, 1, (0, 0)), (0, 1, (1, 0)), (0, 1, (0, 1))], 5),
    ('2 vertex 4-fold (0,0),(1,0),(0,1),(1,1)', 2,
     [(0, 1, (0, 0)), (0, 1, (1, 0)), (0, 1, (0, 1)), (0, 1, (1, 1))], 3),
]

T0 = time.time()
def el():
    return '[%7.1fs]' % (time.time() - T0)


# ==========================================================================
hr('Step A  定理 S（段階的処理の点ごとの付値）の照合')
# ==========================================================================
print("""
定理 S: (a,b) in Z^2 \\ {0}、zeta = g^a、xi = g^b（g は原始 ell^M 乗根）とし、
  Phi = Phi_{(a,b)}、lam = v_ell(cont Phi)、B = ell^{-lam} Phi の係数、
  thstar = min{m : ell not| B_m}（**常に有限**）、m1 = min{m < thstar : B_m != 0}
と置く。thstar - m1 < phi(ell^M) ならば

    v_ell(E(zeta,xi)) = lam + thstar / phi(ell^M).

**lam, thstar は点ではなく整数ベクトル (a,b) の関数**なので、同じ点の別の代表では
値が違いうる。定理 S は「ある代表で仮定が成り立てば」使える。
以下、仮定が成り立つ (a,b) すべてについて、円分体での独立な付値計算（cycle 16 実装）と照合する。
""")

for (name, m, edges, ell) in GENERAL:
    D = detL(m, edges)
    mu = mu_content(D, ell)
    Ev = E_of(D, ell, mu)
    npass = nskip = 0
    for M in [1, 2]:
        rng = range(-ell**M, ell**M + 1)
        for a in rng:
            for b in rng:
                if a % ell**M == 0 and b % ell**M == 0:
                    continue
                (pred, ok) = staged_prediction(Ev, ell, M, a, b)
                if not ok or pred is None:
                    nskip += 1
                    continue
                v = point_val(Ev, ell, M, a, b)
                if v is oo:
                    nskip += 1
                    continue
                report('A %s ell=%s M=%s (a,b)=(%s,%s)' % (name, ell, M, a, b),
                       v == pred, 'pred=%s actual=%s' % (pred, v))
                npass += 1
    print('  %s  ell=%s  %s: 照合 %d 点、仮定不成立で対象外 %d 点'
          % (el(), ell, name, npass, nskip))

# theta = infinity の点を明示的に見る（cycle 18 §4.5 の例）
print()
print('  cycle 18 §4.5 の例（ell=5, 4x(1,0)+(0,1)）の方向 (1:1) の内訳:')
(m, edges) = bouquet([((1, 0), 4), ((0, 1), 1)])
D5 = detL(m, edges); Ev5 = E_of(D5, 5, mu_content(D5, 5))
for (a, b) in [(1, 1), (1, 6), (1, 11), (1, 16), (1, 21), (2, 2), (1, 26)]:
    (lam, th, m1) = stage_data(Ev5, 5, a, b)
    print('    (a,b)=(%2d,%2d)  lam=%s thstar=%s m1=%s   theta(cycle18)=%s'
          % (a, b, lam, th, m1, theta_of(Ev5, 5, a, b)))
print('    -> (1,1) と (2,2) は lam=1（theta=infinity）、他は lam=0。')
print('       cycle 18 §4.5 が「同居」と呼んだ現象は、整数ベクトルが例外直線 Z(1,1) に')
print('       乗るか否かで決まっている。')

# ==========================================================================
hr('Step B  命題 2（判定条件）と命題 3（有限性）の照合')
# ==========================================================================
print("""
命題 2: u = (a,b) を原始ベクトルとすると
    lam(u) >= 1  <=>  (chi^{u^perp} - 1) | bar tilde E   in F_ell[z^{+-1}, w^{+-1}]
（u^perp = (b,-a)。ker psi_u = (chi^{u^perp} - 1) から）。
命題 3: そのような u^perp は Newt(tilde E) - Newt(tilde E) に入る（Ostrowski）。
        よって例外直線は有限個で、有限探索で網羅できる。
""")

for (name, m, edges, ell) in GENERAL:
    D = detL(m, edges)
    mu = mu_content(D, ell)
    Ev = E_of(D, ell, mu)
    body = set(newton_difference_body(Ev))
    lines = exceptional_lines(Ev, ell)
    # (B1) 判定条件: 探索箱の中の全原始ベクトルで lam>=1 <=> 二項式割り切り
    nchk = 0
    for a in range(-6, 7):
        for b in range(-6, 7):
            if (a, b) == (0, 0):
                continue
            if gcd(ZZ(a), ZZ(b)) != 1:
                continue
            (lam, th, m1) = stage_data(Ev, ell, a, b)
            lhs = (lam is Infinity) or (lam >= 1)
            rhs = binomial_divides(Ev, ell, perp((a, b)))
            report('B1 %s ell=%s u=(%s,%s)' % (name, ell, a, b), lhs == rhs,
                   'lam=%s divides=%s' % (lam, rhs))
            nchk += 1
            # (B2) 有限性: 例外なら u^perp は Newton 差体に入る
            if lhs:
                report('B2 %s ell=%s u=(%s,%s)' % (name, ell, a, b),
                       perp((a, b)) in body, 'u^perp=%s not in Newton difference body' % (perp((a, b)),))
    print('  %s  ell=%2s  %-40s 例外直線 %d 本 %s（原始ベクトル %d 個を判定）'
          % (el(), ell, name, len(lines), [u for (u, l, t) in lines], nchk))

# ==========================================================================
hr('Step C  補題 4（スケール不変性）')
# ==========================================================================
print("""
補題 4: ell not| c ならば lam(ca,cb) = lam(a,b)、thstar(ca,cb) = thstar(a,b)。
""")
for (name, m, edges, ell) in GENERAL:
    D = detL(m, edges)
    Ev = E_of(D, ell, mu_content(D, ell))
    nchk = 0
    for a in range(-4, 5):
        for b in range(-4, 5):
            if (a, b) == (0, 0):
                continue
            base = stage_data(Ev, ell, a, b)
            for c in range(-4, 5):
                if c == 0 or c % ell == 0:
                    continue
                got = stage_data(Ev, ell, c * a, c * b)
                report('C %s ell=%s (a,b)=(%s,%s) c=%s' % (name, ell, a, b, c),
                       got[0] == base[0] and got[1] == base[1],
                       'base=%s got=%s' % (base, got))
                nchk += 1
    print('  %s  ell=%2s  %-40s %d 組を照合' % (el(), ell, name, nchk))

# ==========================================================================
hr('Step D  系 5（同居構造の計数）')
# ==========================================================================
print("""
系 5: 例外直線 Z u（u 原始）の上でレベルちょうど M の点は {c u mod ell^M : ell not| c} の
phi(ell^M) 個ちょうど。方向 P = u mod ell の点は全部で (ell-1) ell^{2M-2} 個なので、
例外点の割合は ell^{1-M} で M とともに 0 へ落ちる（が、各点は lam >= 1 を余分に持つ）。
""")
for (name, m, edges, ell) in GENERAL:
    D = detL(m, edges)
    Ev = E_of(D, ell, mu_content(D, ell))
    lines = exceptional_lines(Ev, ell)
    if not lines:
        print('  %s  ell=%2s  %-40s 例外直線なし' % (el(), ell, name))
        continue
    for M in [1, 2]:
        q = ell**M
        # レベルちょうど M の点のうち「ある代表が例外直線に乗る」もの
        onlines = set()
        for (u, lam, th) in lines:
            for c in range(1, q):
                if c % ell == 0:
                    continue
                onlines.add(((c * u[0]) % q, (c * u[1]) % q))
        # 直線ごとの個数
        for (u, lam, th) in lines:
            s = set()
            for c in range(1, q):
                if c % ell == 0:
                    continue
                s.add(((c * u[0]) % q, (c * u[1]) % q))
            report('D count %s ell=%s M=%s u=%s' % (name, ell, M, u),
                   len(s) == euler_phi(q), 'got %d expected %d' % (len(s), euler_phi(q)))
        # 方向ごとの総数（レベルちょうど M）
        for (u, lam, th) in lines:
            P = (u[0] % ell, u[1] % ell)
            tot = 0
            for a in range(q):
                for b in range(q):
                    if a % ell == 0 and b % ell == 0:
                        continue
                    # 方向: (a,b) mod ell の射影が P と同じか
                    if (a * P[1] - b * P[0]) % ell == 0:
                        tot += 1
            report('D dir %s ell=%s M=%s P=%s' % (name, ell, M, P),
                   tot == (ell - 1) * ell**(2 * M - 2),
                   'got %d expected %d' % (tot, (ell - 1) * ell**(2 * M - 2)))
        print('  %s  ell=%2s  %-40s M=%d: 例外点 %d 個 / レベル M の点 %d 個（割合 %s）'
              % (el(), ell, name, M, len(onlines), ell**(2 * M) - ell**(2 * M - 2),
                 QQ(len(onlines)) / (ell**(2 * M) - ell**(2 * M - 2))))

# ==========================================================================
hr('Step E  系 6（theta = infinity は cycle 18 定理 C の射程外でしか起きない）')
# ==========================================================================
print("""
系 6: 例外直線 Z u を持つ方向 P = u mod ell では、一般点の theta が ell 以下になることはない。
（cycle 18 補題 A3 の digit 安定性: theta <= ell なら theta は (a,b) mod ell だけの関数。
  例外点も同じ mod ell 類にいるので、その類の theta は一斉に <= ell か、そうでないか。
  例外点の theta は infinity なので、その方向では theta > ell。）
したがって theta = infinity の塔は cycle 18 定理 C の仮定を必ず破る。逆は成り立たない。
""")
for (name, m, edges, ell) in GENERAL:
    D = detL(m, edges)
    Ev = E_of(D, ell, mu_content(D, ell))
    lines = exceptional_lines(Ev, ell)
    for (u, lam, th) in lines:
        P = (u[0] % ell, u[1] % ell)
        # 同じ mod ell 類の一般点（例外直線に乗らない代表）の theta
        worst = 0
        for c in range(1, ell):
            for t in range(1, 4):
                (a, b) = (u[0] + t * ell * c, u[1])
                if (a % ell, b % ell) != P:
                    continue
                thv = theta_of(Ev, ell, a, b)
                if thv is Infinity:
                    worst = Infinity
                    break
                worst = max(worst, thv)
        report('E %s ell=%s P=%s' % (name, ell, P),
               worst is Infinity or worst >= ell + 1,
               'generic theta = %s (<= ell = %s)' % (worst, ell))
    if lines:
        print('  %s  ell=%2s  %-40s 例外方向 %s はすべて theta >= ell+1'
              % (el(), ell, name, [(u[0] % ell, u[1] % ell) for (u, l, t) in lines]))

# ==========================================================================
hr('Step F  定理 X（族 p(1,0) + q(0,1)、ell 奇）の完全閉形式')
# ==========================================================================
print("""
定理 X（本サイクルの主結果）:
  ell を奇素数、p, q >= 1 とし、X = 1 頂点の bouquet（voltage (1,0) の loop が p 本、
  (0,1) の loop が q 本）とする。mu := v_ell(gcd(p,q))、p' := p/ell^mu、q' := q/ell^mu と置く
  （p', q' は同時には ell で割れない）。**例外直線（theta = infinity の軌跡）は次で決まる**:

    ell | p'+q'  -> 2 本 Z(1,1), Z(1,-1)、いずれも lam = v_ell(p'+q')
    ell | p'     -> 1 本 Z(1,0)、lam = v_ell(p')
    ell | q'     -> 1 本 Z(0,1)、lam = v_ell(q')
    それ以外      -> 0 本（例外直線なし。cycle 16 定理 N1 / cycle 18 定理 C の射程）

  Lam := sum over exceptional lines of lam（上の 3 場合で 2 v_ell(p'+q') / v_ell(p') / v_ell(q')）
  と置くと、例外直線がある場合、**すべての n >= 0** で

    ord_ell(kappa_n) = mu (ell^{2n} - 1) + 2 n ell^n + Lam (ell^n - 1).

  **n ell^n 項の係数 b = 2 != 0 なので、この塔は型 III である**（cycle 16 §7 の分類）。
  cycle 14 (7.2) の 5 係数は a = mu, b = 2, c = Lam, d = 0, e = -mu - Lam, n_0 = 0。

  点ごとの付値（level n、(a,b) in (Z/ell^n)^2 \\ {0}、nu(x) := v_ell(x)（x = 0 のとき n））:
   [A] ell | p'+q' の場合: eps := min(nu(a), nu(b))、m := n - eps、a' := a/ell^eps、b' := b/ell^eps
       phi(ell^m) v_ell(E) = 2                    … a', b' の片方だけが単元
                           = lam0 phi(ell^m) + 2  … 両方単元かつ a' = +-b' mod ell^m（theta = infinity）
                           = 1 + ell^r            … 両方単元、r := max(nu(a'-b'), nu(a'+b')) < m
   [B] ell | p' の場合:
       phi(ell^n) v_ell(E) = 2 ell^{nu(b)}                  … nu(b) < n
                           = lam1 phi(ell^n) + 2 ell^{nu(a)} … b = 0（このとき a != 0）
   [B'] ell | q' の場合は [B] で a と b を入れ替えたもの。
""")

def family_lines(ell, p, q):
    """(mu, case, lam, Lam) を返す。case in {'A','B','Bp','none'}。"""
    mu = ZZ(gcd(p, q)).valuation(ell)
    pp = ZZ(p) // ell**mu; qq = ZZ(q) // ell**mu
    if (pp + qq) % ell == 0:
        lam = ZZ(pp + qq).valuation(ell); return (mu, 'A', lam, 2 * lam)
    if pp % ell == 0:
        lam = ZZ(pp).valuation(ell); return (mu, 'B', lam, lam)
    if qq % ell == 0:
        lam = ZZ(qq).valuation(ell); return (mu, 'Bp', lam, lam)
    return (mu, 'none', 0, 0)


def family_pred_v(ell, p, q, n, a, b):
    """定理 X の点ごとの予言 v_ell(E(g^a, g^b))（g は原始 ell^n 乗根）。"""
    (mu, case, lam, Lam) = family_lines(ell, p, q)
    qn = ell**n
    a = ZZ(a) % qn; b = ZZ(b) % qn
    assert not (a == 0 and b == 0)
    nu = lambda x: n if x == 0 else ZZ(x).valuation(ell)
    if case == 'A':
        eps = min(nu(a), nu(b)); m = n - eps; qm = ell**m
        ap = (a // ell**eps) % qm; bp = (b // ell**eps) % qm
        ua = (ap % ell != 0); ub = (bp % ell != 0)
        if not (ua and ub):
            val = 2
        elif (ap - bp) % qm == 0 or (ap + bp) % qm == 0:
            val = lam * euler_phi(qm) + 2
        else:
            r = max(ZZ((ap - bp) % qm).valuation(ell), ZZ((ap + bp) % qm).valuation(ell))
            val = 1 + ell**r
        return QQ(val) / euler_phi(qm)
    if case in ('B', 'Bp'):
        (x, y) = (a, b) if case == 'B' else (b, a)
        if nu(y) < n:
            val = 2 * ell**nu(y)
        else:
            val = lam * euler_phi(qn) + 2 * ell**nu(x)
        return QQ(val) / euler_phi(qn)
    return None


FAMILY = [(3, 2, 1), (3, 1, 2), (3, 1, 8), (3, 4, 5), (3, 3, 1), (3, 1, 3),
          (3, 9, 1), (3, 3, 6), (3, 6, 3),
          (5, 4, 1), (5, 2, 3), (5, 1, 9), (5, 3, 7), (5, 5, 1), (5, 25, 1),
          (5, 10, 15), (7, 3, 4), (7, 1, 6), (7, 7, 2), (11, 5, 6), (11, 11, 3)]

print('--- F1  点ごとの付値の公式（全点網羅） ---')
F1_LIMIT = {3: 3, 5: 2, 7: 2, 11: 1}
for (ell, p, q) in FAMILY:
    (mu, case, lam, Lam) = family_lines(ell, p, q)
    (m, edges) = bouquet([((1, 0), p), ((0, 1), q)])
    D = detL(m, edges); mu2 = mu_content(D, ell); Ev = E_of(D, ell, mu2)
    report('F1 mu ell=%s (p,q)=(%s,%s)' % (ell, p, q), mu == mu2,
           'family_lines mu=%s but mu_content=%s' % (mu, mu2))
    nmax = F1_LIMIT[ell]
    npt = 0
    for n in range(1, nmax + 1):
        qn = ell**n
        for a in range(qn):
            for b in range(qn):
                if a == 0 and b == 0:
                    continue
                pred = family_pred_v(ell, p, q, n, a, b)
                v = point_val(Ev, ell, n, a, b)
                got = None if v is oo else v
                report('F1 ell=%s (p,q)=(%s,%s) n=%s (a,b)=(%s,%s)' % (ell, p, q, n, a, b),
                       got == pred, 'pred=%s actual=%s' % (pred, got))
                npt += 1
    print('  %s  ell=%2s (p,q)=(%2s,%2s) mu=%s case=%-4s lam=%s Lam=%s: level<=%d の全 %d 点を照合'
          % (el(), ell, p, q, mu, case, lam, Lam, nmax, npt))

print()
print('--- F2  Sigma_n の閉形式 ---')
print('  Sigma_n = sum_{(a,b) != 0} v_ell(E) を定理 X の点ごとの式から足し上げ、')
print('  閉形式 ord_ell(kappa_n) = mu(ell^{2n}-1) + 2n ell^n + Lam(ell^n-1) と整合するかを見る。')
print('  （kappa(X) = 1（1 頂点）なので v_ell(kappa(X)) = 0。cycle 14 (1.1): ')
print('    ord_ell(kappa_n) = v_ell(kappa(X)) - 2n + mu(ell^{2n}-1) + Sigma_n。）')
for (ell, p, q) in FAMILY:
    (mu, case, lam, Lam) = family_lines(ell, p, q)
    nmax = F1_LIMIT[ell]
    for n in range(1, nmax + 1):
        qn = ell**n
        tot = QQ(0)
        for a in range(qn):
            for b in range(qn):
                if a == 0 and b == 0:
                    continue
                tot += family_pred_v(ell, p, q, n, a, b)
        pred_sig = 2 * n * ell**n + Lam * (ell**n - 1) + 2 * n
        report('F2 ell=%s (p,q)=(%s,%s) n=%s' % (ell, p, q, n), tot == pred_sig,
               'sum=%s pred=%s' % (tot, pred_sig))
    print('  %s  ell=%2s (p,q)=(%2s,%2s): Sigma_n = 2n ell^n + Lam(ell^n-1) + 2n を n=1..%d で確認'
          % (el(), ell, p, q, nmax))

print()
print('--- F3  ord_ell(kappa_n) = mu(ell^{2n}-1) + 2n ell^n + Lam(ell^n-1)（独立な塔計算と照合） ---')
TOWER_NMAX = {3: 3, 5: 2, 7: 2, 11: 1}
for (ell, p, q) in FAMILY:
    (mu, case, lam, Lam) = family_lines(ell, p, q)
    (m, edges) = bouquet([((1, 0), p), ((0, 1), q)])
    nmax = TOWER_NMAX[ell]
    ords = tower_ords(m, edges, ell, nmax, tag='F3 ell=%s (%s,%s)' % (ell, p, q), budget=420)
    pred = [mu * (ell**(2 * n) - 1) + 2 * n * ell**n + Lam * (ell**n - 1)
            for n in range(nmax + 1)]
    use = usable_prefix(ords)
    if len(use) < len(ords):
        CUTOFFS.append(('F3', ell, p, q, len(use) - 1, nmax))
    for n in range(len(use)):
        report('F3 ell=%s (p,q)=(%s,%s) n=%s' % (ell, p, q, n), use[n] == pred[n],
               'actual=%s pred=%s' % (use[n], pred[n]))
    print('  %s  ell=%2s (p,q)=(%2s,%2s) mu=%s Lam=%s: n=0..%d  actual=%s pred=%s'
          % (el(), ell, p, q, mu, Lam, len(use) - 1, use, pred[:len(use)]))

print()
print('--- F4  例外直線の寄与は lam(ell^n - 1) + n thstar（n ell^n 項を作らない） ---')
print("""
命題 7: 例外直線 Z u（lam = lam(u), thstar = thstar(u)）が全レベルで定理 S の仮定を満たすなら、
その直線の Sigma_n への寄与は sum_{M=1}^n phi(ell^M)(lam + thstar/phi(ell^M))
= lam (ell^n - 1) + n thstar。**n ell^n 項は出ない。**
したがって型 III の n ell^n 項は theta = infinity の点そのものからではなく、
その ell 進近傍にある「有限だが深い」点から出ている（内訳は Step H4）。
""")
for (ell, p, q) in FAMILY:
    (mu, case, lam, Lam) = family_lines(ell, p, q)
    (m, edges) = bouquet([((1, 0), p), ((0, 1), q)])
    D = detL(m, edges); Ev = E_of(D, ell, mu_content(D, ell))
    lines = exceptional_lines(Ev, ell)
    nexp = 2 if case == 'A' else 1
    report('F4 lines ell=%s (p,q)=(%s,%s)' % (ell, p, q), len(lines) == nexp,
           'expected %d exceptional lines, got %s' % (nexp, lines))
    for (u, lm, th) in lines:
        report('F4 lam ell=%s (p,q)=(%s,%s) u=%s' % (ell, p, q, u), lm == lam,
               'lam=%s thstar=%s expected lam=%s' % (lm, th, lam))
    report('F4 Lam ell=%s (p,q)=(%s,%s)' % (ell, p, q),
           sum(lm for (u, lm, th) in lines) == Lam,
           'sum of lam = %s but Lam = %s' % (sum(lm for (u, lm, th) in lines), Lam))
    # 例外点の Sigma_n への寄与
    for n in range(1, F1_LIMIT[ell] + 1):
        s = QQ(0)
        for M in range(1, n + 1):
            qq = ell**M
            for (u, lm, th) in lines:
                for c in range(1, qq):
                    if c % ell == 0:
                        continue
                    s += QQ(lm) + QQ(th) / euler_phi(qq)
        pred_line = sum(lm * (ell**n - 1) + n * th for (u, lm, th) in lines)
        report('F4 sum ell=%s (p,q)=(%s,%s) n=%s' % (ell, p, q, n), s == pred_line,
               'sum=%s pred=%s' % (s, pred_line))
    print('  %s  ell=%2s (p,q)=(%2s,%2s): 例外直線 %s、寄与 sum lam(ell^n-1) + n thstar'
          % (el(), ell, p, q, [(u, lm, th) for (u, lm, th) in lines]))

print()
print('--- F5  この族は ell 奇なら全塔が既知の定理で覆われる ---')
print("""
命題 9: ell を奇素数とすると、族 p(1,0) + q(0,1) の塔は必ず次のいずれかに入る。
  (i) 非退化（z_H = 0）      -> cycle 16 定理 N1 / cycle 18 系 D
  (ii) 退化かつ例外直線なし  -> theta(P) = 4 <= ell（ell >= 5。ell = 3 ではこの場合は起きない）
                              -> cycle 18 定理 C（型 II）
  (iii) 例外直線あり         -> 本サイクルの定理 X（型 III）
以下、1 <= p,q <= 10、ell in {3,5,7,11,13} の**全組合せ**で (i)(ii)(iii) の分割が成り立つことを見る。
""")
for ell in [3, 5, 7, 11, 13]:
    cnt = {'(i) 非退化': 0, '(ii) 退化・cycle18 定理 C': 0, '(iii) 例外直線・定理 X': 0}
    for p in range(1, 11):
        for q in range(1, 11):
            (m, edges) = bouquet([((1, 0), p), ((0, 1), q)])
            inv = invariants(m, edges, ell)
            if inv is None:
                continue
            D = detL(m, edges); Ev = E_of(D, ell, inv['mu'])
            lines = exceptional_lines(Ev, ell)
            prof = delta_profile(D, ell, inv['mu'])
            zh = len(inv['zeros'])
            (mu0, case, lam, Lam) = family_lines(ell, p, q)
            if lines:
                cnt['(iii) 例外直線・定理 X'] += 1
                report('F5 case ell=%s (p,q)=(%s,%s)' % (ell, p, q), case != 'none',
                       'exceptional lines but family_lines says none')
            elif zh == 0:
                cnt['(i) 非退化'] += 1
            else:
                ok = all(v is not None and v <= ell for v in prof.values())
                report('F5 thmC ell=%s (p,q)=(%s,%s)' % (ell, p, q), ok,
                       'degenerate, no exceptional line, but theta profile = %s' % (prof,))
                # theta(P) = 4 であることも見る
                report('F5 theta4 ell=%s (p,q)=(%s,%s)' % (ell, p, q),
                       set(v for v in prof.values()) <= set([2, 4]),
                       'theta profile = %s（4 以外の退化深さ）' % (prof,))
                cnt['(ii) 退化・cycle18 定理 C'] += 1
    print('  ell=%2d: %s（100 組を全走査）' % (ell, cnt))


# ==========================================================================
hr('Step G  母集団を網羅した分類（どの ell・どの塔で theta = infinity が起きるか）')
# ==========================================================================
print("""
宣言する母集団（この母集団の**全走査**であって標本抽出ではない。したがってこの母集団に
ついては完全な判定であり、母集団の外については何も言わない）:
  (a) 1 頂点 bouquet、loop 本数 L = 2..5、voltage は
      {(1,0),(0,1),(1,1),(1,-1),(2,1),(1,2)} からの重複ありの組合せ
  (b) 2 頂点 平行多重辺、本数 3..5、voltage は {(0,0),(1,0),(0,1),(1,1)} からの重複ありの組合せ
素数 ell in {2,3,5,7,11}。仮定 (H)（全ての n で塔が連結）を満たすものだけを対象にする。
""")
VOLT_A = [(1, 0), (0, 1), (1, 1), (1, -1), (2, 1), (1, 2)]
VOLT_B = [(0, 0), (1, 0), (0, 1), (1, 1)]
POP = []
for L in range(2, 6):
    for combo in combinations_with_replacement(VOLT_A, L):
        POP.append((1, [(0, 0, v) for v in combo]))
for L in range(3, 6):
    for combo in combinations_with_replacement(VOLT_B, L):
        POP.append((2, [(0, 1, v) for v in combo]))
print('  母集団サイズ: %d 個の voltage グラフ' % len(POP))

for ell in [2, 3, 5, 7, 11]:
    n_ok = n_inf = n_deg = n_inf_deg = 0
    n_thm_c = 0
    by_lines = {}
    for (m, edges) in POP:
        inv = invariants(m, edges, ell)
        if inv is None:
            continue
        n_ok += 1
        D = detL(m, edges)
        Ev = E_of(D, ell, inv['mu'])
        zh = len(inv['zeros'])
        if zh > 0:
            n_deg += 1
        lines = exceptional_lines(Ev, ell)
        prof = delta_profile(D, ell, inv['mu'])
        if all(v is not None for v in prof.values()):
            n_thm_c += 1
        if lines:
            n_inf += 1
            by_lines[len(lines)] = by_lines.get(len(lines), 0) + 1
            if zh > 0:
                n_inf_deg += 1
            # theta = infinity なら必ず退化（系 6 の帰結）
            report('G degenerate ell=%s %s' % (ell, edges), zh > 0,
                   'theta=infinity but z_H=0')
            # theta = infinity なら cycle 18 定理 C は使えない
            report('G thmC ell=%s %s' % (ell, edges),
                   any(v is None for v in prof.values()),
                   'theta=infinity but cycle18 Thm C applicable')
    print('  ell=%2d: (H) を満たす塔 %4d、退化 %4d、cycle18 定理 C 適用可 %4d、'
          'theta=infinity を持つ塔 %4d（うち退化 %4d）、例外直線の本数分布 %s'
          % (ell, n_ok, n_deg, n_thm_c, n_inf, n_inf_deg, sorted(by_lines.items())))

print()
print('--- G2  族 p(1,0) + q(0,1) の完全な分類（命題 8） ---')
print("""
命題 8: X = p 本の (1,0) loop と q 本の (0,1) loop の bouquet、ell を任意の素数、
mu = v_ell(gcd(p,q))、p' = p/ell^mu、q' = q/ell^mu と置くと

    theta = infinity が起きる  <=>  ell | p' q' (p' + q'),

であり、そのとき例外直線は
    ell | p'+q'  -> 2 本 Z(1,1), Z(1,-1)（lam = v_ell(p'+q')）
    ell | p'     -> 1 本 Z(1,0)（lam = v_ell(p')）
    ell | q'     -> 1 本 Z(0,1)（lam = v_ell(q')）
（3 場合は排反）。証明は report §5.1（Newton 多角形の Minkowski 分解で候補を絞り、
w = z^{+-1} 等の代入で判定する）。
以下、1 <= p,q <= 12、ell in {2,3,5,7,11,13} の**全組合せ**で照合する。

**自己訂正の記録**: 本 step を最初に書いたときの命題 8 は「theta = infinity <=> ell | p+q」
だった。これは **ell | p' や ell | q' の場合を落としていて偽**であり、この Step の
全組合せ照合が 436 件の FAIL を出して検出した（例: ell=2, (p,q)=(1,2) は 2 not| p+q=3 だが
例外直線 Z(0,1) を持つ）。詳細は report §8。
""")
for ell in [2, 3, 5, 7, 11, 13]:
    hits = []
    for p in range(1, 13):
        for q in range(1, 13):
            (m, edges) = bouquet([((1, 0), p), ((0, 1), q)])
            D = detL(m, edges); mu = mu_content(D, ell); Ev = E_of(D, ell, mu)
            lines = exceptional_lines(Ev, ell)
            (mu0, case, lam, Lam) = family_lines(ell, p, q)
            report('G2 mu ell=%s (p,q)=(%s,%s)' % (ell, p, q), mu0 == mu,
                   'mu mismatch %s vs %s' % (mu0, mu))
            report('G2 ell=%s (p,q)=(%s,%s)' % (ell, p, q), bool(lines) == (case != 'none'),
                   'lines=%s case=%s' % (lines, case))
            if lines:
                nl = 2 if case == 'A' else 1
                report('G2 nlines ell=%s (p,q)=(%s,%s)' % (ell, p, q), len(lines) == nl,
                       'lines=%s case=%s' % (lines, case))
                report('G2 lam ell=%s (p,q)=(%s,%s)' % (ell, p, q),
                       all(lm == lam for (u, lm, th) in lines),
                       'lines=%s expected lam=%s' % (lines, lam))
                exp_u = ([(1, -1), (1, 1)] if case == 'A'
                         else ([(1, 0)] if case == 'B' else [(0, 1)]))
                report('G2 dir ell=%s (p,q)=(%s,%s)' % (ell, p, q),
                       sorted(u for (u, lm, th) in lines) == sorted(exp_u),
                       'lines=%s expected %s' % (lines, exp_u))
                hits.append((p, q))
    print('  ell=%2d: theta=infinity になる (p,q) は %d / 144 組、すべて命題 8 の判定と一致'
          % (ell, len(hits)))
print('  -> **theta = infinity は「小さい ell の現象」ではない。** Step G の母集団で')
print('     ell=7,11 が 0 件だったのは、その母集団の loop 本数が 5 以下で係数和が 7 に届かない')
print('     ためであって、現象が起きないからではない（母集団の人工物）。')

# ==========================================================================
hr('Step H  敵対的レビュー')
# ==========================================================================

print('--- H1  「定理 X はフィットではないか」 ---')
print('  予言 mu(ell^{2n}-1) + 2n ell^n + Lam(ell^n-1) は ell, p, q だけから決まり、')
print('  塔の値も点ごとの付値の実測も使っていない。F3 の照合は全段が out-of-sample である。')
print('  以下、予言に使った量（mu と Lam のみ）を列挙する:')
for (ell, p, q) in FAMILY:
    (mu0, case, lam, Lam) = family_lines(ell, p, q)
    print('    ell=%2s (p,q)=(%2s,%2s) -> mu=%s, case=%-4s, Lam=%s（この 2 数だけで 5 係数が決まる）'
          % (ell, p, q, mu0, case, Lam))

print()
print('--- H2  「ell = 2 でも成り立つのではないか」 ---')
print('  成り立たない。導出は (i) 2 が単位元であること、(ii) a=b と a=-b が排反であること、')
print('  (iii) lam (ell-1) >= 2 を使う。ell = 2 では全部壊れる。実測で確かめる:')
(m2, e2) = bouquet([((1, 0), 1), ((0, 1), 1)])
ords2 = tower_ords(m2, e2, 2, 4, tag='H2 torus ell=2', budget=300)
pred2 = [2 * (n + 1) * 2**n - 2 for n in range(5)]
known2 = [None] + [2 * n * 2**n + 4 * 2**n - 6 * n - 1 for n in range(1, 5)]
print('    ell=2 torus: actual=%s' % (ords2,))
print('    定理 X をそのまま当てた値 = %s  -> 一致しない（n>=1）' % (pred2,))
print('    cycle 16 定理 D2 の既知の閉形式 = %s  -> 一致する' % (known2,))
u2 = usable_prefix(ords2)
for n in range(1, len(u2)):
    report('H2 ell=2 known formula n=%s' % n, u2[n] == known2[n],
           'actual=%s known=%s' % (u2[n], known2[n]))
    report('H2 ell=2 theorem X must fail n=%s' % n, u2[n] != pred2[n],
           'theorem X unexpectedly matched at ell=2')

print()
print('--- H3  「ell >= 5 の退化塔は全件型 II」（cycle 18 §5.1）は一般に正しいか ---')
print('  正しくない（cycle 18 の母集団についてのみ正しい）。定理 X の族は任意の奇素数 ell に')
print('  ついて型 III（b = 2）を与える。cycle 18 の母集団（bouquet 2-3 loop と 2 頂点 3-4 重辺）に')
print('  本族の例が入っていないことを確認する:')
for (ell, p, q) in [(3, 2, 1), (5, 4, 1), (5, 5, 1), (7, 3, 4), (7, 7, 2), (11, 5, 6)]:
    print('    ell=%2s (p,q)=(%s,%s): loop 本数 %2d  -> cycle 18 母集団（<=3 loop）に%s'
          % (ell, p, q, p + q, '入る' if p + q <= 3 else '入らない'))

print()
print('--- H4  「theta = infinity の点が n ell^n 項を作っているのではないか」 ---')
print('  違う。F4 のとおり例外直線の寄与は lam(ell^n-1) + n thstar で、n ell^n 項を含まない。')
print('  n ell^n 項は「有限だが深い」点 theta = 1 + ell^r（r = 1..m-1）の総和から出る。内訳:')
for (ell, p, q) in [(3, 2, 1), (5, 4, 1), (5, 2, 3)]:
    (mu0, case, lam0, Lam0) = family_lines(ell, p, q)
    n = F1_LIMIT[ell]
    parts = {'mixed': QQ(0), 'r=0': QQ(0), 'r>=1 finite': QQ(0), 'theta=inf': QQ(0)}
    for M in range(1, n + 1):
        qq = ell**M
        for a in range(qq):
            for b in range(qq):
                if a % ell == 0 and b % ell == 0:
                    continue
                val = family_pred_v(ell, p, q, M, a, b)
                ua = (a % ell != 0); ub = (b % ell != 0)
                if not (ua and ub):
                    parts['mixed'] += val
                elif (a - b) % qq == 0 or (a + b) % qq == 0:
                    parts['theta=inf'] += val
                else:
                    r = max(ZZ((a - b) % qq).valuation(ell), ZZ((a + b) % qq).valuation(ell))
                    parts['r=0' if r == 0 else 'r>=1 finite'] += val
    print('    ell=%s (p,q)=(%s,%s) n=%s: %s  合計 %s（= Sigma_n）'
          % (ell, p, q, n, {k: str(v) for (k, v) in parts.items()}, sum(parts.values())))

print()
print('--- H5  「例外直線の探索範囲が狭いから見落としているのではないか」 ---')
print('  違う。命題 3（Ostrowski: Newt(fg) = Newt(f) + Newt(g)）より例外 u^perp は')
print('  Newton 差体に入る。Step B2 で全例外がその中に入ることを確認済み。')
print('  さらに広い箱（|a|,|b| <= 12）で追加の例外が出ないことを確認する:')
for (name, m, edges, ell) in GENERAL:
    D = detL(m, edges); Ev = E_of(D, ell, mu_content(D, ell))
    body = set(newton_difference_body(Ev))
    extra = []
    for a in range(-12, 13):
        for b in range(-12, 13):
            if (a, b) == (0, 0) or gcd(ZZ(a), ZZ(b)) != 1:
                continue
            (lam, th, m1) = stage_data(Ev, ell, a, b)
            if (lam is Infinity or lam >= 1) and perp((a, b)) not in body:
                extra.append((a, b))
    report('H5 %s ell=%s' % (name, ell), len(extra) == 0,
           'exceptional u outside Newton difference body: %s' % (extra,))
print('    -> 箱の外に例外は出なかった（命題 3 の照合）。')

print()
print('--- H6  「定理 X の形は一般の塔でも成り立つのではないか」 ---')
print("""
  **成り立たない。反例を確定させる。**
  定理 X の閉形式は ord_ell(kappa_n) = mu(ell^{2n}-1) + 2n ell^n + Lam(ell^n-1) で、
  この族では k = 2 なので「k n ell^n + Lam(ell^n-1)」と読める。この読みを一般の
  「例外直線を持つ塔」へ素朴に延長した式

      ord_ell(kappa_n) =? mu(ell^{2n}-1) + k n ell^n + Lam(ell^n-1) + v_ell(kappa(X))

  を、Step G の母集団のうち例外直線を持つ塔すべてで検算する。**一致しない塔がある。**
  したがって Lam だけでは一般の塔の閉形式は決まらず、例外直線の近傍（有限だが深い theta）の
  寄与を別に決める必要がある（report §9）。
""")
for ell in [2, 3, 5]:
    n_ex = n_agree = 0
    counterex = []
    for (m, edges) in POP:
        inv = invariants(m, edges, ell)
        if inv is None:
            continue
        D = detL(m, edges); Ev = E_of(D, ell, inv['mu'])
        lines = exceptional_lines(Ev, ell)
        if not lines:
            continue
        n_ex += 1
        Lam = sum(lm for (u, lm, th) in lines)
        k = inv['k']
        nmax = 3 if ell == 2 else 2
        ords = tower_ords(m, edges, ell, nmax,
                          tag='H6 ell=%s' % ell, budget=180)
        use = usable_prefix(ords)
        if len(use) < len(ords):
            CUTOFFS.append(('H6', ell, tuple((u, v, a, b) for (u, v, (a, b)) in edges),
                            len(use) - 1, nmax))
        pred = [inv['mu'] * (ell**(2 * n) - 1) + k * n * ell**n + Lam * (ell**n - 1)
                + inv['vkX'] for n in range(len(use))]
        if use == pred:
            n_agree += 1
        elif len(counterex) < 3:
            counterex.append((edges, inv['mu'], k, Lam, inv['vkX'], use, pred))
    print('  ell=%2d: 例外直線を持つ塔 %3d のうち素朴な延長と一致 %3d、一致しない %3d'
          % (ell, n_ex, n_agree, n_ex - n_agree))
    for (edges, mu0, k, Lam, vk, use, pred) in counterex:
        print('    反例: voltage=%s  mu=%s k=%s Lam=%s v(kappa_X)=%s'
              % ([e[2] for e in edges], mu0, k, Lam, vk))
        print('          actual=%s   素朴な延長=%s' % (use, pred))
    # 反例が実在すること自体を検証項目にする（0 件だと主張が空になる）
    report('H6 counterexample exists ell=%s' % ell, n_ex == 0 or n_agree < n_ex,
           'no counterexample found for ell=%s (%d towers)' % (ell, n_ex))

# ==========================================================================
hr('総計')
# ==========================================================================
print('PASS %d / FAIL %d' % (TOTAL_PASS, TOTAL_FAIL))
print('打ち切り（時間上限）: %d 件' % (len(CUTOFFS) + len(SKIPS)))
for c in CUTOFFS:
    print('  CUTOFF %s' % (c,))
for s in SKIPS:
    print('  SKIP %s' % (s,))
print('%s 終了' % el())
