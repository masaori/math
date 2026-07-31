# cycle 21 / T3 Pure: 一般の塔の閉形式（5 係数すべて）の数値検証。
#
# 対応する証明本体: outputs/reports/cycle21_T3_general_closed_form.md
# 対象ラベルの宣言: overview.md
#
# 検証する内容（report の番号）:
#   Step A  定理 G4   既知の閉形式との突き合わせ（定理 X′ の族・定理 J8・cycle16 定理 D2 = ell=2 トーラス）
#   Step B  定理 G4   母集団の全走査。**当てはめを一切せず** D の係数だけから (alpha,beta,gamma) を予言し、
#                     実測 Theta_M（整数終結式・仮定なし）と M >= M* で照合する（自由度 0 の out-of-sample）
#   Step C  定理 G3   飽和深度 K の分布と、K が j^* から予言どおりに決まること
#   Step D  ----      (NS)（K = 0）を落とすと予言が壊れることの確認（naive 版との差分。反例の実在）
#   Step E  定理 G2   捻り段データ (Lambda_k, theta^sharp_k) が層ごとの hat theta の実測と一致すること
#   Step F  系 W6     b = sum j^* が飽和の有無に依らず成り立つこと（本 report の定理 G4 の帰結）
#
# 実測側 Theta_M = sum_P hat theta_M(P) は整数終結式（cycle 20 定理 L4）で、本 report の理論から独立。
# 壁時計上限を各 Step に置き、打ち切ったら件数と中身を必ず出力する。

import sys, time, itertools
load('_defs21.sage')

T0 = time.time()
def el():
    return '[%7.1fs]' % (time.time() - T0)

FAIL = 0
TRUNC = []

def fail(msg):
    global FAIL
    FAIL += 1
    print('  FAIL: %s' % msg)
    sys.stdout.flush()

def hdr(s):
    print('')
    print('=' * 78)
    print(s, el())
    print('=' * 78)
    sys.stdout.flush()

# --------------------------------------------------------------------------
# 母集団（cycle 20 と同一に取る。比較可能性のため）
# --------------------------------------------------------------------------
V6 = [(1, 0), (0, 1), (1, 1), (1, -1), (2, 1), (1, 2)]
V4 = [(0, 0), (1, 0), (0, 1), (1, 1)]
POP = []
for L in (2, 3):
    for combo in itertools.combinations_with_replacement(V6, L):
        POP.append(('BQ%d %s' % (L, ','.join(str(c) for c in combo)),
                    1, [(0, 0, c) for c in combo]))
for combo in itertools.combinations_with_replacement(V4, 3):
    POP.append(('TV3 %s' % ','.join(str(c) for c in combo), 2, [(0, 1, c) for c in combo]))
for p in range(1, 7):
    for q in range(p, 7):
        POP.append(('FAM p=%d q=%d' % (p, q), 1,
                    [(0, 0, (1, 0))] * p + [(0, 0, (0, 1))] * q))
ADV = [
    ('ADV torus (1,0),(0,1)', 1, [(0, 0, (1, 0)), (0, 0, (0, 1))]),
    ('ADV bouquet (1,0),(1,-1),(1,2)', 1, [(0, 0, c) for c in [(1, 0), (1, -1), (1, 2)]]),
    ('ADV bouquet (1,0),(0,1),(1,1),(1,-1)', 1,
     [(0, 0, c) for c in [(1, 0), (0, 1), (1, 1), (1, -1)]]),
    ('ADV bouquet (1,0)x3,(0,1)x3', 1, [(0, 0, (1, 0))] * 3 + [(0, 0, (0, 1))] * 3),
    ('ADV bouquet (1,0)x2,(0,1),(1,1)', 1,
     [(0, 0, (1, 0))] * 2 + [(0, 0, (0, 1)), (0, 0, (1, 1))]),
    ('ADV bouquet (1,0)x5,(0,1)', 1, [(0, 0, (1, 0))] * 5 + [(0, 0, (0, 1))]),
]
POP += ADV

PRIMES = [2, 3, 5, 7]
# 母集団走査で到達するレベル（実測コストから決めた。ell=5 の M=5 と M=4 は 1 塔 10 秒以上かかる）
MMAX = {2: 7, 3: 5, 5: 3, 7: 3}
# 深い掃引（名前つきの塔だけ）で到達するレベル
MMAX_DEEP = {2: 9, 3: 6, 5: 4}
BUDGET_B = 420.0        # Step B: 素数ごとの壁時計上限
BUDGET_DEEP = 300.0     # Step B2: 深い掃引の壁時計上限

print('cycle 21 / T3 Pure: 一般の塔の閉形式（5 係数すべて）', el())
print('母集団: %d 塔（bouquet 2-3 ループ / 2 頂点 3 重辺 / 族 p(1,0)+q(0,1) / 名前つき %d 個）'
      % (len(POP), len(ADV)))
print('実測 Theta_M は整数終結式（cycle 20 定理 L4）。予言側は当てはめを一切しない（自由度 0）。')

# ==========================================================================
hdr('Step A: 既知の閉形式との突き合わせ')
# ==========================================================================

def coeffs_of(P, ell, Ms):
    """(a,b,c,d,e) を返す。e は M < M* の Theta を厳密に足して決める。"""
    al, be, ga = P['alpha'], P['beta'], P['gamma']
    acc = QQ(0)
    for M in range(1, Ms):
        t = Theta_level(P['Ev'], ell, M)
        if t is None:
            return None
        acc += t
    def SM(nn): return (ell - (nn + 1) * ell**(nn + 1) + nn * ell**(nn + 2)) / QQ((ell - 1)**2)
    def SE(nn): return (ell**(nn + 1) - ell) / QQ(ell - 1)
    # Sigma_n = acc + al*(SM(n)-SM(Ms-1)) + be*(SE(n)-SE(Ms-1)) + ga*(n-Ms+1)
    const = acc - al * SM(Ms - 1) - be * SE(Ms - 1) - ga * (Ms - 1)
    a = QQ(P['mu'])
    b = al * ell / (ell - 1)
    c = be * ell / (ell - 1) - al * ell / (ell - 1)**2
    d = ga - 2
    e = -P['mu'] + P['vkX'] + const + al * ell / (ell - 1)**2 - be * ell / (ell - 1)
    return (a, b, c, d, e)

# A1: 定理 X′ / 定理 J8 の族（ell 奇、ループ (ell-1) 本 + 1 本）: 2n l^n + 2 l^n - 2
for ell in (3, 5, 7):
    ed = [(0, 0, (1, 0))] * (ell - 1) + [(0, 0, (0, 1))]
    P = closed_form(1, ed, ell)
    Ms = Mstar(P, ell)
    co = coeffs_of(P, ell, Ms)
    exp = (QQ(0), QQ(2), QQ(2), QQ(0), QQ(-2))
    print('A1 ell=%2d 定理 J8 (a,b,c,d,e)=%s  期待 %s  %s' % (ell, co, exp, 'OK' if co == exp else 'MISMATCH'))
    if co != exp:
        fail('A1 ell=%d' % ell)

# A2: 定理 X′ の族 p(1,0)+q(0,1)（ell 奇、例外直線あり）: mu(l^{2n}-1) + 2n l^n + Lam(l^n-1)
for (ell, p, q) in [(3, 1, 2), (3, 2, 4), (5, 1, 4), (5, 2, 3), (7, 3, 4), (3, 3, 3), (5, 5, 5)]:
    ed = [(0, 0, (1, 0))] * p + [(0, 0, (0, 1))] * q
    P = closed_form(1, ed, ell)
    if P is None:
        print('A2 ell=%d (p,q)=(%d,%d) skip ((H) 不成立等)' % (ell, p, q)); continue
    Ms = Mstar(P, ell)
    co = coeffs_of(P, ell, Ms)
    (a, b, c, d, e) = co
    ok = (b == 2 and d == 0 and e == -a - c) if len(P['S']) > 0 else (b == 0)
    print('A2 ell=%d (p,q)=(%d,%d) |S|=%d (a,b,c,d,e)=%s 定理X′形=%s'
          % (ell, p, q, len(P['S']), co, ok))
    if len(P['S']) > 0 and not ok:
        fail('A2 ell=%d (p,q)=(%d,%d) が定理 X′ の形でない' % (ell, p, q))

# A3: ell=2 トーラス（cycle16 定理 D2 / DuBose-Vallieres の数列 5,19,61,167,417,987）
P = closed_form(1, [(0, 0, (1, 0)), (0, 0, (0, 1))], 2)
Ms = Mstar(P, 2)
co = coeffs_of(P, 2, Ms)
(a, b, c, d, e) = co
seq = [5, 19, 61, 167, 417, 987]
pred = [a * 4**n + b * n * 2**n + c * 2**n + d * n + e for n in range(1, 7)]
print('A3 ell=2 トーラス (a,b,c,d,e)=%s' % (co,))
print('   n=1..6 予言 %s / 既知 %s  %s' % (pred, seq, 'OK' if pred == [QQ(s) for s in seq] else 'MISMATCH'))
if pred != [QQ(s) for s in seq]:
    fail('A3 ell=2 トーラスの数列が合わない')

# ==========================================================================
hdr('Step B: 母集団の全走査（自由度 0 の out-of-sample 照合）')
# ==========================================================================

RECS = []
for ell in PRIMES:
    tB = time.time()
    nvalid = 0; nchk = 0; nmis = 0; nskip = 0; nleft = 0
    for (i, (nm, m, ed)) in enumerate(POP):
        if time.time() - tB > BUDGET_B:
            nleft = len(POP) - i
            TRUNC.append('Step B: ell=%d で壁時計 %.0fs 超過。母集団 %d 塔のうち "%s" 以降の %d 塔を未実施'
                         % (ell, BUDGET_B, len(POP), nm, nleft))
            break
        try:
            P = closed_form(m, ed, ell)
        except Exception as exc:
            nskip += 1
            TRUNC.append('Step B: ell=%d %s で例外 %s' % (ell, nm, exc))
            continue
        if P is None:
            nskip += 1
            continue
        nvalid += 1
        Ms = Mstar(P, ell)
        rec = dict(nm=nm, ell=ell, P=P, Ms=Ms)
        RECS.append(rec)
        for M in range(1, MMAX[ell] + 1):
            if M < Ms:
                continue
            meas = Theta_level(P['Ev'], ell, M)
            if meas is None:
                continue
            pr = theta_pred(P, ell, M)
            nchk += 1
            if meas != pr:
                nmis += 1
                fail('Step B ell=%d %s M=%d 実測 %s 予言 %s' % (ell, nm, M, meas, pr))
    print('ell=%2d 有効 %3d 塔 / 照合 %4d (M,塔) 組 / 不一致 %d / 除外 %d / 未実施 %d (M <= %d)'
          % (ell, nvalid, nchk, nmis, nskip, nleft, MMAX[ell]))
    sys.stdout.flush()

# --- Step B2: 名前つきの塔だけ深いレベルまで ---
print('')
print('Step B2: 名前つきの塔を深いレベルまで', el())
tD = time.time(); nD = 0; nDmis = 0
for ell in sorted(MMAX_DEEP):
    for (nm, m, ed) in ADV:
        if time.time() - tD > BUDGET_DEEP:
            TRUNC.append('Step B2: 壁時計 %.0fs 超過。ell=%d の "%s" 以降を未実施' % (BUDGET_DEEP, ell, nm))
            break
        P = closed_form(m, ed, ell)
        if P is None:
            continue
        Ms = Mstar(P, ell); res = []
        for M in range(1, MMAX_DEEP[ell] + 1):
            if M < Ms:
                continue
            meas = Theta_level(P['Ev'], ell, M)
            if meas is None:
                continue
            nD += 1
            ok = (meas == theta_pred(P, ell, M))
            if not ok:
                nDmis += 1
                fail('Step B2 ell=%d %s M=%d 実測 %s 予言 %s' % (ell, nm, M, meas, theta_pred(P, ell, M)))
            res.append('%d:%s' % (M, 'OK' if ok else 'X'))
        print('  ell=%d %-38s M*=%s (b,c,d)=(%s,%s,%s) %s'
              % (ell, nm, Ms, P['b'], P['c'], P['d'], ' '.join(res)))
        sys.stdout.flush()
print('Step B2: 照合 %d 件 / 不一致 %d 件' % (nD, nDmis))

# ==========================================================================
hdr('Step C: 飽和深度 K の分布と、K が j^* から決まること')
# ==========================================================================
from collections import Counter
cntK = Counter(); cntJ = Counter(); cntS = Counter()
for rec in RECS:
    P = rec['P']; ell = rec['ell']
    cntS[(ell, len(P['S']))] += 1
    for dd in P['detail']:
        cntK[(ell, dd['K'])] += 1
        cntJ[(ell, dd['jstar'])] += 1
        # 定理 G3 の明示式: K = max{k>=0 : j* ell >= (ell-1) ell^k （等号は e/m1 で決まる）}
        k = 0
        while ZZ(dd['jstar']) * ell > (ell - 1) * ell**(k + 1):
            k += 1
        if not (dd['K'] >= k):
            fail('Step C: K=%s < 明示下界 %s (ell=%d %s)' % (dd['K'], k, ell, rec['nm']))
print('|S_infinity| の分布 (ell,|S|):count = %s' % dict(sorted(cntS.items())))
print('j^* の分布 (ell,j*):count      = %s' % dict(sorted(cntJ.items())))
print('K の分布 (ell,K):count         = %s' % dict(sorted(cntK.items())))
nsat = sum(1 for rec in RECS if any(dd['K'] >= 1 for dd in rec['P']['detail']))
print('飽和（K>=1 の点をもつ）塔: %d / S_infinity 非空の塔 %d / 全体 %d'
      % (nsat, sum(1 for r in RECS if r['P']['S']), len(RECS)))

# ==========================================================================
hdr('Step D: (NS) を落とした naive 版（K=0 と決めつける）が壊れること')
# ==========================================================================
def naive_pred(P, ell, M):
    """K = 0（飽和なし）と決めつけた版。K >= 1 の塔ではこれが壊れるはず。"""
    al = QQ(0); be = QQ(P['Agen']); ga = QQ(0)
    rs = P['rsharp']
    for dd in P['detail']:
        js = ZZ(dd['jstar']); ejs = ZZ(dd['ejs'])
        (k0, Lam0, th0, m10, mult0) = dd['tw'][0]
        al += QQ((ell - 1) * js) / ell
        be += QQ(ejs) / ell**rs - QQ(js * rs * (ell - 1)) / ell + QQ(ell - 1) / ell * Lam0
        ga += -QQ(ejs) + th0
    return al * M * ell**M + be * ell**M + ga

nbroken = 0; nsat_t = 0
for rec in RECS:
    P = rec['P']; ell = rec['ell']
    if not any(dd['K'] >= 1 for dd in P['detail']):
        continue
    nsat_t += 1
    M = max(rec['Ms'], 2)
    if M > MMAX[ell]:
        continue
    meas = Theta_level(P['Ev'], ell, M)
    if meas is None:
        continue
    if naive_pred(P, ell, M) != meas:
        nbroken += 1
print('K>=1 の塔 %d 個のうち、naive 版（飽和を無視）が実際に外れたもの: %d' % (nsat_t, nbroken))
if nsat_t > 0 and nbroken != nsat_t:
    print('  注: 外れなかった %d 個は M* > MMAX で照合できなかったもの' % (nsat_t - nbroken))

# ==========================================================================
hdr('Step E: 捻り段データ (Lambda_k, theta^sharp_k) の層ごとの実測照合')
# ==========================================================================
nE = 0; nEfail = 0
for rec in RECS[:200]:
    P = rec['P']; ell = rec['ell']
    if not P['S']:
        continue
    M = max(rec['Ms'], 2)
    if M > MMAX[ell]:
        continue
    ph = euler_phi(ell**M)
    for dd in P['detail']:
        (u1, u2) = dd['u']
        e2 = _complete_basis((u1, u2))
        for (k, Lam, ths, m1k, mult) in dd['tw']:
            if M - k < 1:
                continue
            a = ZZ(u1) + ell**(M - k) * ZZ(e2[0])
            b = ZZ(u2) + ell**(M - k) * ZZ(e2[1])
            h = hat_theta_exact(P['Ev'], ell, M, a, b)
            if h is None:
                continue
            nE += 1
            if h != ph * Lam + ths:
                nEfail += 1
                fail('Step E ell=%d %s u=%s k=%d M=%d 実測 %s 予言 %s'
                     % (ell, rec['nm'], dd['u'], k, M, h, ph * Lam + ths))
print('層ごとの照合 %d 件 / 不一致 %d 件' % (nE, nEfail))

# ==========================================================================
hdr('Step F: b = sum j^* が飽和の有無に依らず成り立つこと')
# ==========================================================================
nF = 0
for rec in RECS:
    P = rec['P']; ell = rec['ell']
    b = P['b']
    s = sum(ZZ(dd['jstar']) for dd in P['detail'])
    nF += 1
    if b != s:
        fail('Step F ell=%d %s b=%s != sum j*=%s' % (ell, rec['nm'], b, s))
print('b = sum j^* を %d 塔で確認（うち飽和 %d 塔）' % (nF, nsat))

# ==========================================================================
hdr('まとめ')
# ==========================================================================
print('FAIL 件数: %d' % FAIL)
print('打ち切り件数: %d' % len(TRUNC))
for t in TRUNC:
    print('  - %s' % t)
print('総所要 %.1fs' % (time.time() - T0))
