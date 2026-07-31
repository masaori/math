# cycle 21 / T3 Pure: 閉形式 (a,b,c,d,e) を **塔の値**（Matrix-Tree 定理）と直接照合する。
#
# 対応する証明本体: outputs/reports/cycle21_T3_general_closed_form.md（Step G）
#
# general_closed_form.sage（Step A-F）は Theta_M（整数終結式）との照合だった。
# 本スクリプトは kappa_n = kappa(X_{ell^n, ell^n}) を Matrix-Tree 定理で独立に計算し、
# ord_ell(kappa_n) が閉形式 a l^{2n} + b n l^n + c l^n + d n + e と一致するかを見る。
# 予言側は D の係数だけから決まる（当てはめ 0）。
#
# 段数の壁: kappa_n の計算は ell^{2n} * |V| 次の行列式なので ell=2 は n<=4、ell=3 は n<=3 まで。
# 壁時計上限を置き、打ち切ったら件数と中身を必ず出力する。

import sys, time, itertools
load('_defs21.sage')

T0 = time.time()
def el(): return '[%7.1fs]' % (time.time() - T0)
FAIL = 0
TRUNC = []
def fail(msg):
    global FAIL
    FAIL += 1
    print('  FAIL: %s' % msg); sys.stdout.flush()

BUDGET = 900.0
NMAX = {2: 4, 3: 3, 5: 2}

V6 = [(1, 0), (0, 1), (1, 1), (1, -1), (2, 1), (1, 2)]
V4 = [(0, 0), (1, 0), (0, 1), (1, 1)]
POP = []
for L in (2, 3):
    for combo in itertools.combinations_with_replacement(V6, L):
        POP.append(('BQ%d %s' % (L, ','.join(str(c) for c in combo)),
                    1, [(0, 0, c) for c in combo]))
for combo in itertools.combinations_with_replacement(V4, 3):
    POP.append(('TV3 %s' % ','.join(str(c) for c in combo), 2, [(0, 1, c) for c in combo]))
for p in range(1, 5):
    for q in range(p, 5):
        POP.append(('FAM p=%d q=%d' % (p, q), 1,
                    [(0, 0, (1, 0))] * p + [(0, 0, (0, 1))] * q))

print('cycle 21 / T3 Pure: 閉形式 vs 塔の値（Matrix-Tree）', el())
print('母集団 %d 塔、ell in %s、n <= %s' % (len(POP), sorted(NMAX), NMAX))

def coeffs_of(P, ell, Ms):
    al, be, ga = P['alpha'], P['beta'], P['gamma']
    acc = QQ(0)
    for M in range(1, Ms):
        t = Theta_level(P['Ev'], ell, M)
        if t is None:
            return None
        acc += t
    def SM(nn): return (ell - (nn + 1) * ell**(nn + 1) + nn * ell**(nn + 2)) / QQ((ell - 1)**2)
    def SE(nn): return (ell**(nn + 1) - ell) / QQ(ell - 1)
    const = acc - al * SM(Ms - 1) - be * SE(Ms - 1) - ga * (Ms - 1)
    a = QQ(P['mu'])
    b = al * ell / (ell - 1)
    c = be * ell / (ell - 1) - al * ell / (ell - 1)**2
    d = ga - 2
    e = -P['mu'] + P['vkX'] + const + al * ell / (ell - 1)**2 - be * ell / (ell - 1)
    return (a, b, c, d, e)

tot = 0; nchk = 0; nmis = 0; nskip = 0; nlate = 0
tS = time.time(); stopped = False
for ell in sorted(NMAX):
    if stopped: break
    for (nm, m, ed) in POP:
        if time.time() - tS > BUDGET:
            TRUNC.append('壁時計 %.0fs 超過。ell=%d の "%s" 以降を未実施' % (BUDGET, ell, nm))
            stopped = True; break
        try:
            P = closed_form(m, ed, ell)
        except Exception as exc:
            nskip += 1; TRUNC.append('ell=%d %s で例外 %s' % (ell, nm, exc)); continue
        if P is None:
            nskip += 1; continue
        Ms = Mstar(P, ell)
        co = coeffs_of(P, ell, Ms)
        if co is None:
            nskip += 1; continue
        (a, b, c, d, e) = co
        tot += 1
        n0 = max(Ms - 1, 1)
        for n in range(1, NMAX[ell] + 1):
            kx = kappa_derived(m, ed, ell**n, ell**n)
            if kx == 0:
                nskip += 1; continue
            actual = ZZ(kx).valuation(ell)
            pred = a * ell**(2 * n) + b * n * ell**n + c * ell**n + d * n + e
            if n < n0:
                if actual != pred:
                    nlate += 1      # n < n0 は理論の射程外（漸近開始前）。数えるだけ
                continue
            nchk += 1
            if actual != pred:
                nmis += 1
                fail('ell=%d %s n=%d 実測 %s 予言 %s (n0=%s)' % (ell, nm, n, actual, pred, n0))
    print('ell=%d まで完了: 塔 %d / 照合 %d / 不一致 %d / 除外 %d' % (ell, tot, nchk, nmis, nskip))
    sys.stdout.flush()

print('')
print('=' * 78)
print('n >= n0 での照合: %d 件、不一致 %d 件' % (nchk, nmis))
print('n < n0（漸近開始前・理論の射程外）でずれた件数: %d' % nlate)
print('FAIL 件数: %d' % FAIL)
print('打ち切り件数: %d' % len(TRUNC))
for t in TRUNC:
    print('  - %s' % t)
print('総所要 %.1fs' % (time.time() - T0))
