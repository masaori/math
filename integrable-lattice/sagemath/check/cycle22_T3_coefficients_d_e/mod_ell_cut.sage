# cycle 22 / T3 Pure: 「どの追加情報が要るか」の切れ目を確定させる数値検証。
#
# 対応する証明本体: outputs/reports/cycle22_T3_coefficients_d_e.md
# 対象ラベルの宣言: overview.md
#
# cycle21 §9.1 は「Lambda_1 は bar tilde E の関数ではない」を示した（mod ell では c が決まらない）。
# 本スクリプトはそこから 3 歩進める。
#
#   Step F  定理 D3   **d と e も mod ell では決まらない。** しかも tilde E を勝手にいじるのではなく、
#                     **実在する voltage グラフ 2 本**（トーラス と (1,0)x3+(0,1)）が
#                     bar tilde E も mu も S_infinity も j^* も e_j も **全部一致する**のに
#                     d と e が違う。cycle21 §9.1 の反例は「tilde E の摂動」で、
#                     グラフとして実現できるかを言っていなかった。ここはグラフで実現している。
#   Step G  定理 D4   **どんな固定精度 ell^N でも足りない（c）。** 族 X_t（1 頂点、(1,0),(0,1) と
#                     (1,-1) を t 本）で、t = 2^{N+1}-1 と t' = 3*2^N-1 は tilde E が mod 2^N で
#                     一致するのに c が 3 だけ違う。N は任意に大きく取れる。
#   Step H  定理 D5   **どんな固定精度 ell^N でも足りない（d）。** 族 Y_N（(1,0)^p,(0,1)^q,(1,-1)^t、
#                     p = 2^{N+1}-1, q = 1+2^{N+2}, t = 1）と p -> p + 2^N は mod 2^N で一致するのに
#                     theta^sharp_1 が 2 -> 0 に変わり d が 2 だけ違う。Lambda_1 は変わらない
#                     （＝位置側だけが動く。付値側 c とは独立な障害である）。
#   Step I  定理 D6   **精度 N > max_k Lambda_k なら足りる（逆向き）。** 母集団の各塔で
#                     tilde E に ell^N g（N > max Lambda）を足しても (Lambda_k, theta^sharp_k) が
#                     不変で、したがって c, d が不変であることを確認する。
#   Step J  ----      Step G/H の族の手計算（report §6）と機械計算の突き合わせ。
#
# 壁時計上限を置き、打ち切ったら件数と中身を必ず出力する。

import sys, time, itertools
load('_defs22.sage')

T22 = time.time()
def el22():
    return '[%7.1fs]' % (time.time() - T22)

FAIL = 0
TRUNC = []

def fail(msg):
    global FAIL
    FAIL += 1
    print('  FAIL: %s' % msg); sys.stdout.flush()

def hdr(s):
    print(''); print('=' * 78); print(s, el22()); print('=' * 78); sys.stdout.flush()

def bq(loops):
    return [(0, 0, c) for c in loops]

def five(m, ed, ell):
    P = closed_form(m, ed, ell)
    if P is None:
        return (None, None)
    return (P, coeffs5(P, ell, Mstar(P, ell)))

print('cycle 22 / T3 Pure: mod ell の切れ目 と 必要精度', el22())

# ==========================================================================
hdr('Step F: bar tilde E が完全に一致する実在の 2 塔で d, e が違う')
# ==========================================================================
PAIRS_F = [
    ('ell=2 トーラス (1,0),(0,1)', 1, bq([(1, 0), (0, 1)]),
     'ell=2 bouquet (1,0)x3,(0,1)', 1, bq([(1, 0)] * 3 + [(0, 1)]), 2),
    ('ell=2 bouquet (1,0)x3,(0,1)', 1, bq([(1, 0)] * 3 + [(0, 1)]),
     'ell=2 bouquet (1,0)x5,(0,1)', 1, bq([(1, 0)] * 5 + [(0, 1)]), 2),
    ('ell=3 bouquet (1,0)x1,(0,1)x2', 1, bq([(1, 0)] + [(0, 1)] * 2),
     'ell=3 bouquet (1,0)x4,(0,1)x2', 1, bq([(1, 0)] * 4 + [(0, 1)] * 2), 3),
]
nF = 0
for (n1, m1, e1, n2, m2, e2, ell) in PAIRS_F:
    (P1, c1) = five(m1, e1, ell); (P2, c2) = five(m2, e2, ell)
    if P1 is None or P2 is None or c1 is None or c2 is None:
        TRUNC.append('Step F: %s / %s は closed_form が None' % (n1, n2)); continue
    same_bar = (ebar(P1['Ev'], ell) == ebar(P2['Ev'], ell))
    same_mu = (P1['mu'] == P2['mu'])
    loc1 = sorted((tuple(dd['u']), ZZ(dd['jstar']), ZZ(dd['ejs']), ZZ(dd['K']),
                   ZZ(dd['lam']), ZZ(dd['thstar'])) for dd in P1['detail'])
    loc2 = sorted((tuple(dd['u']), ZZ(dd['jstar']), ZZ(dd['ejs']), ZZ(dd['K']),
                   ZZ(dd['lam']), ZZ(dd['thstar'])) for dd in P2['detail'])
    print('')
    print('  %s   vs   %s   (ell=%d)' % (n1, n2, ell))
    print('    bar tilde E 一致: %s   mu 一致: %s   (j*,e_j*,K,lambda,theta*) 一致: %s'
          % (same_bar, same_mu, loc1 == loc2))
    print('    bar tilde E = %s' % ebar(P1['Ev'], ell))
    print('    (a,b,c,d,e) = %s' % (c1[:5],))
    print('    (a,b,c,d,e) = %s' % (c2[:5],))
    print('    Tdef = %s vs %s' % (c1[5], c2[5]))
    if same_bar and same_mu:
        nF += 1
        if c1[0] != c2[0] or c1[1] != c2[1]:
            fail('Step F: bar tilde E が同じなのに a か b が違う（既知の定理に反する）')
        if c1[3] == c2[3] and c1[4] == c2[4] and c1[2] == c2[2]:
            print('    -> この対では c,d,e がすべて一致（反例になっていない）')
        else:
            print('    -> **c,d,e のいずれかが違う。mod ell では決まらない。**')
    else:
        TRUNC.append('Step F: %s / %s は bar tilde E か mu が違うので対にならない' % (n1, n2))
print('')
print('Step F: bar tilde E も mu も一致する対を %d 組検査した' % nF)

# ==========================================================================
hdr('Step G: 固定精度 ell^N では c が決まらない（N を任意に大きく取れる）')
# ==========================================================================
NMAX_G = 8
BUDGET_G = 600.0
tG = time.time()
rowsG = []
for N in range(1, NMAX_G + 1):
    if time.time() - tG > BUDGET_G:
        TRUNC.append('Step G: 壁時計 %.0fs 超過。N=%d 以降を未実施（N=1..%d は完了）'
                     % (BUDGET_G, N, N - 1))
        break
    t = 2**(N + 1) - 1; t2 = 3 * 2**N - 1
    (P1, c1) = five(1, X_t(t), 2); (P2, c2) = five(1, X_t(t2), 2)
    if P1 is None or P2 is None:
        TRUNC.append('Step G: N=%d で closed_form が None' % N); continue
    d1 = detL(1, X_t(t)); d2 = detL(1, X_t(t2))
    okmod = all(ZZ(x) % 2**N == 0 for x in (d1 - d2).coefficients())
    okbar = (ebar(P1['Ev'], 2) == ebar(P2['Ev'], 2)) and (P1['mu'] == P2['mu'])
    # 手計算（report §6.1）: P0=(1,1) で Lambda_1 = 2 + v_2(t+1)、P0=(1,0),(0,1) で Lambda_0 = v_2(t+1)
    hand = {}
    for dd in P1['detail']:
        u = tuple(dd['u'])
        tw = dict((k, L) for (k, L, th, _, _) in dd['tw'])
        hand[u] = tw
    exp11 = 2 + ZZ(t + 1).valuation(2)
    got11 = hand.get((1, 1), {}).get(1, None)
    exp01 = ZZ(t + 1).valuation(2)
    got01 = hand.get((0, 1), {}).get(0, None)
    rowsG.append((N, t, t2, okmod, okbar, c1[2], c2[2], c1[3], c2[3], c1[4], c2[4]))
    print('  N=%d t=%-5d t2=%-5d  mod 2^N 一致:%s  bar/mu 一致:%s  c: %s -> %s (差 %s)  d: %s -> %s  e: %s -> %s'
          % (N, t, t2, okmod, okbar, c1[2], c2[2], c2[2] - c1[2], c1[3], c2[3], c1[4], c2[4]))
    print('       手計算 Lambda_1((1:1)) = 2+v_2(t+1) = %s / 機械 %s ; Lambda_0((0:1)) = v_2(t+1) = %s / 機械 %s'
          % (exp11, got11, exp01, got01))
    if not okmod:
        fail('Step G N=%d: mod 2^N で一致していない' % N)
    if not okbar:
        fail('Step G N=%d: bar tilde E か mu が違う' % N)
    if c1[2] == c2[2]:
        fail('Step G N=%d: c が変わっていない（反例になっていない）' % N)
    if got11 != exp11 or got01 != exp01:
        fail('Step G N=%d: 手計算と機械計算が食い違う' % N)
    sys.stdout.flush()
print('Step G: N=1..%d で「mod 2^N 一致だが c が違う」対を確認' % (len(rowsG)))

# ==========================================================================
hdr('Step H: 固定精度 ell^N では d も決まらない（位置側 theta^sharp が動く）')
# ==========================================================================
NMAX_H = 8
BUDGET_H = 600.0
tH = time.time()
rowsH = []
def Y(p, q, t):
    return bq([(1, 0)] * p + [(0, 1)] * q + [(1, -1)] * t)
for N in range(1, NMAX_H + 1):
    if time.time() - tH > BUDGET_H:
        TRUNC.append('Step H: 壁時計 %.0fs 超過。N=%d 以降を未実施（N=1..%d は完了）'
                     % (BUDGET_H, N, N - 1))
        break
    t = 1; p = 2**(N + 1) - t; q = t + 2**(N + 2); p2 = p + 2**N
    (P1, c1) = five(1, Y(p, q, t), 2); (P2, c2) = five(1, Y(p2, q, t), 2)
    if P1 is None or P2 is None:
        TRUNC.append('Step H: N=%d で closed_form が None' % N); continue
    d1 = detL(1, Y(p, q, t)); d2 = detL(1, Y(p2, q, t))
    okmod = all(ZZ(x) % 2**N == 0 for x in (d1 - d2).coefficients())
    okbar = (ebar(P1['Ev'], 2) == ebar(P2['Ev'], 2)) and (P1['mu'] == P2['mu'])
    def tw01(P):
        for dd in P['detail']:
            if tuple(dd['u']) == (0, 1):
                return dict((k, (L, th)) for (k, L, th, _, _) in dd['tw'])
        return {}
    a1 = tw01(P1); a2 = tw01(P2)
    # 手計算（report §6.2）: P0=(0:1) の k=1 で A_0 = A_1 = 4(p+t)、A_2 = t-q
    hL = min(ZZ(4 * (p + t)).valuation(2), ZZ(t - q).valuation(2))
    hT = 0 if ZZ(4 * (p + t)).valuation(2) <= ZZ(t - q).valuation(2) else 2
    hL2 = min(ZZ(4 * (p2 + t)).valuation(2), ZZ(t - q).valuation(2))
    hT2 = 0 if ZZ(4 * (p2 + t)).valuation(2) <= ZZ(t - q).valuation(2) else 2
    rowsH.append((N, p, p2, okmod, okbar, c1[3], c2[3]))
    print('  N=%d p=%-5d -> %-5d (q=%d,t=%d)  mod 2^N 一致:%s bar/mu 一致:%s  d: %s -> %s   c: %s -> %s   e: %s -> %s'
          % (N, p, p2, q, t, okmod, okbar, c1[3], c2[3], c1[2], c2[2], c1[4], c2[4]))
    print('       (0:1) の k=1: 機械 (Lambda,theta#) = %s -> %s ; 手計算 (%s,%s) -> (%s,%s)'
          % (a1.get(1), a2.get(1), hL, hT, hL2, hT2))
    if not okmod:
        fail('Step H N=%d: mod 2^N で一致していない' % N)
    if not okbar:
        fail('Step H N=%d: bar tilde E か mu が違う' % N)
    if c1[3] == c2[3]:
        fail('Step H N=%d: d が変わっていない（反例になっていない）' % N)
    if a1.get(1) != (QQ(hL), ZZ(hT)) or a2.get(1) != (QQ(hL2), ZZ(hT2)):
        fail('Step H N=%d: 手計算と機械計算が食い違う（%s vs (%s,%s) / %s vs (%s,%s)）'
             % (N, a1.get(1), hL, hT, a2.get(1), hL2, hT2))
    sys.stdout.flush()
print('Step H: N=1..%d で「mod 2^N 一致だが d が違う」対を確認' % (len(rowsH)))

# ==========================================================================
hdr('Step I: 精度 N > max_k Lambda_k なら c, d は決まる（逆向きの確認）')
# ==========================================================================
# tilde E に ell^N g を足しても (Lambda_k, theta^sharp_k) が変わらないことを、
# 母集団の塔 x いくつかの摂動 g で確認する。closed_form_D は (H) を確認しないので、
# ここで見るのは「D の係数の ell 進 N 桁目までが (Lambda_k, theta^sharp_k) を決める」ことだけ。
V6 = [(1, 0), (0, 1), (1, 1), (1, -1), (2, 1), (1, 2)]
POP_I = []
for L in (2, 3):
    for combo in itertools.combinations_with_replacement(V6, L):
        POP_I.append(('BQ%d %s' % (L, ','.join(str(c) for c in combo)), 1, bq(list(combo))))
BUDGET_I = 500.0
tI = time.time()
nI = 0; nImis = 0; nIskip = 0
GS = [zL * wL + zL**(-1) * wL**(-1), zL**2 * wL + zL**(-2) * wL**(-1),
      zL - 2 + zL**(-1), zL * wL**(-1) + zL**(-1) * wL]
for ell in (2, 3):
    for (nm, m, ed) in POP_I:
        if time.time() - tI > BUDGET_I:
            TRUNC.append('Step I: 壁時計 %.0fs 超過。ell=%d の "%s" 以降を未実施' % (BUDGET_I, ell, nm))
            break
        try:
            P = closed_form(m, ed, ell)
        except Exception:
            continue
        if P is None:
            continue
        Lmax = max_Lambda(P)
        N = ZZ(Lmax.floor()) + 1        # N > max Lambda
        D0 = detL(m, ed)
        for g in GS:
            try:
                P2 = closed_form_D(D0 + ell**N * g, ell, P['vkX'])
            except Exception:
                nIskip += 1; continue
            if P2 is None:
                nIskip += 1; continue
            if P2['mu'] != P['mu']:
                nIskip += 1; continue
            k1 = sorted((tuple(dd['u']), tuple((k, L, th) for (k, L, th, _, _) in dd['tw']))
                        for dd in P['detail'])
            k2 = sorted((tuple(dd['u']), tuple((k, L, th) for (k, L, th, _, _) in dd['tw']))
                        for dd in P2['detail'])
            nI += 1
            if k1 != k2 or P2['c'] != P['c'] or P2['d'] != P['d']:
                nImis += 1
                fail('Step I ell=%d %s N=%d 摂動 %s で段データか (c,d) が変わった: %s / %s, (c,d)=(%s,%s)->(%s,%s)'
                     % (ell, nm, N, g, k1, k2, P['c'], P['d'], P2['c'], P2['d']))
    print('ell=%d まで: 照合 %d / 不一致 %d / 除外 %d' % (ell, nI, nImis, nIskip)); sys.stdout.flush()
print('Step I: 摂動 ell^N g（N > max Lambda）で段データと (c,d) が不変: %d 件中 不一致 %d 件（除外 %d）'
      % (nI, nImis, nIskip))

# ==========================================================================
hdr('まとめ')
# ==========================================================================
print('FAIL 件数: %d' % FAIL)
print('打ち切り件数: %d' % len(TRUNC))
for t in TRUNC:
    print('  - %s' % t)
print('総所要 %.1fs' % (time.time() - T22))
