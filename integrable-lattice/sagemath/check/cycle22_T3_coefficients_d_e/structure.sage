# cycle 22 / T3 Pure: 係数 d, e の構造（局所性・過渡欠損）の数値検証。
#
# 対応する証明本体: outputs/reports/cycle22_T3_coefficients_d_e.md
# 対象ラベルの宣言: overview.md
#
# 検証する内容（report の番号）:
#   Step A  定理 D1   d = sum_{P0} ( T(P0) - e_{j*} ell^K ) - 2 が cycle21 (5.4)+(2.2) の d と一致し、
#                     **A_gen も過渡も使わない**（S_infinity だけの局所式）こと。
#                     併せて c の局所形（Lambda 側だけが c に入る）も一致すること。
#   Step B  命題 D1a  飽和深度を K -> K+1, K+2 と水増ししても (c, d) が変わらないこと
#                     （cycle21 注 4.2 の「K は上界でよい」の機械確認）。
#   Step C  定理 D2   e = v_ell(kappa(X)) - a - c + Tdef、Tdef は M* の取り方に依らないこと。
#   Step D  定理 D2   Tdef の分布（0 でない塔がどれだけあるか）と d の整数性・c,e の非整数性。
#
# Step E（Matrix-Tree の塔の値との照合）は tower_check.sage に分けた
# （1 本のスクリプトの壁時計上限 20 分を守るため）。
#
# 予言側は D の係数だけから決まり、**当てはめ（fit）は一切しない（自由度 0）**。
# 壁時計上限を各 Step に置き、打ち切ったら件数と中身を必ず出力する。

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

# --------------------------------------------------------------------------
# 母集団（cycle 21 と同一に取る。比較可能性のため）
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
    ('ADV bouquet (1,0)x3,(0,1)', 1, [(0, 0, (1, 0))] * 3 + [(0, 0, (0, 1))]),
    ('ADV bouquet (1,0),(1,-1),(1,2)', 1, [(0, 0, c) for c in [(1, 0), (1, -1), (1, 2)]]),
    ('ADV bouquet (1,0),(0,1),(1,1),(1,-1)', 1,
     [(0, 0, c) for c in [(1, 0), (0, 1), (1, 1), (1, -1)]]),
    ('ADV bouquet (1,0)x5,(0,1)', 1, [(0, 0, (1, 0))] * 5 + [(0, 0, (0, 1))]),
]
POP += ADV
PRIMES = [2, 3, 5, 7]
BUDGET_AB = 420.0     # Step A/B: 素数ごとの壁時計上限
BUDGET_CD = 420.0     # Step C/D: 全体の壁時計上限
# Tdef の M* 非依存性は Theta_{M*+1}, Theta_{M*+2} の実測を要する。
# ell = 5, 7 ではこれが 1 塔で数分かかるので、非依存性の確認は ell = 2, 3 に限る
# （Tdef 自体と定理 D2 の分解は全素数で見る）。打ち切りではなく設計上の限定なので明示する。
PRIMES_MSTAR = [2, 3]

print('cycle 22 / T3 Pure: 係数 d, e の構造', el22())
print('母集団 %d 塔 x ell in %s。予言側は D の係数だけ（当てはめ 0）。' % (len(POP), PRIMES))
print('')
print('【重要な前提】d と e は本サイクルで初めて決まったのではない。')
print('cycle21 定理 G4 (5.4) + 定理 G1 (2.2)(2.3) が既に両方を D の係数から決めている。')
print('本スクリプトが見るのは「d と e がどういう情報でできているか」の構造である。')

# ==========================================================================
hdr('Step A / B: d の局所式、c の局所形、K 水増し不変性')
# ==========================================================================
RECS = []
nA = 0; nAmis = 0; nB = 0; nBmis = 0
for ell in PRIMES:
    tA = time.time(); nleft = 0
    for (i, (nm, m, ed)) in enumerate(POP):
        if time.time() - tA > BUDGET_AB:
            nleft = len(POP) - i
            TRUNC.append('Step A/B: ell=%d で壁時計 %.0fs 超過。母集団 %d 塔のうち "%s" 以降の %d 塔を未実施'
                         % (ell, BUDGET_AB, len(POP), nm, nleft))
            break
        try:
            P = closed_form(m, ed, ell)
        except Exception as exc:
            TRUNC.append('Step A/B: ell=%d %s で例外 %s' % (ell, nm, exc)); continue
        if P is None:
            continue
        RECS.append(dict(nm=nm, m=m, ed=ed, ell=ell, P=P))
        nA += 1
        dl = d_local(P, ell); cl = c_local(P, ell)
        if dl != P['d']:
            nAmis += 1; fail('Step A ell=%d %s d_local=%s != d=%s' % (ell, nm, dl, P['d']))
        if cl != P['c']:
            nAmis += 1; fail('Step A ell=%d %s c_local=%s != c=%s' % (ell, nm, cl, P['c']))
        if P['d'] not in ZZ:
            nAmis += 1; fail('Step A ell=%d %s d=%s が整数でない' % (ell, nm, P['d']))
        if not P['S'] and P['d'] != -2:
            nAmis += 1; fail('Step A ell=%d %s S_inf=空 なのに d=%s (系 G6 は -2)' % (ell, nm, P['d']))
        for bump in (1, 2):
            r = recompute_bump(P, ell, bump)
            nB += 1
            if r is None or r[3] != P['c'] or r[4] != P['d']:
                nBmis += 1
                fail('Step B ell=%d %s K+%d で (c,d) が変わった: %s' % (ell, nm, bump, r))
    print('ell=%2d まで完了: 有効 %d 塔（累計）/ 未実施 %d' % (ell, nA, nleft)); sys.stdout.flush()
print('Step A: d の局所式・c の局所形・d の整数性 を %d 塔で照合、不一致 %d' % (nA, nAmis))
print('Step B: K 水増し（+1, +2）の不変性を %d 件で照合、不一致 %d' % (nB, nBmis))

# ==========================================================================
hdr('Step C / D: e = v_ell(kappa(X)) - a - c + Tdef、Tdef の M* 非依存性と分布')
# ==========================================================================
from collections import Counter
nC = 0; nCmis = 0; nT0 = 0; nTz = 0; nMs = 0; nMsskip = 0
cntd = Counter(); nonintc = 0; noninte = 0; nonintT = 0
tC = time.time()
for (i, rec) in enumerate(RECS):
    P = rec['P']; ell = rec['ell']
    if time.time() - tC > BUDGET_CD:
        TRUNC.append('Step C/D: 壁時計 %.0fs 超過。%d 塔のうち "%s"(ell=%d) 以降の %d 塔を未実施'
                     % (BUDGET_CD, len(RECS), rec['nm'], ell, len(RECS) - i))
        break
    Ms = Mstar(P, ell)
    co = coeffs5(P, ell, Ms)
    if co is None:
        continue
    (a, b, c, d, e, tdef) = co
    nC += 1
    # 定理 D2 の分解
    if e != QQ(P['vkX']) - a - c + tdef:
        nCmis += 1
        fail('Step C ell=%d %s e=%s != vk - a - c + T = %s'
             % (ell, rec['nm'], e, QQ(P['vkX']) - a - c + tdef))
    # Tdef が M* の取り方に依らないこと（M*+1, M*+2 でも同じ）。
    # ell = 5, 7 は Theta_{M*+1} の実測が重すぎるので設計上 ell = 2, 3 に限る。
    if ell in PRIMES_MSTAR:
        for extra in (1, 2):
            t2 = transient(P, ell, Ms + extra)
            if t2 is None:
                continue
            nMs += 1
            if t2 != tdef:
                nCmis += 1
                fail('Step C ell=%d %s Tdef が M*+%d で変わった %s -> %s'
                     % (ell, rec['nm'], extra, tdef, t2))
    else:
        nMsskip += 1
    if tdef == 0:
        nTz += 1
    else:
        nT0 += 1
    cntd[(ell, d)] += 1
    if c not in ZZ: nonintc += 1
    if e not in ZZ: noninte += 1
    if tdef not in ZZ: nonintT += 1
    rec['co'] = co
print('Step C: e = v_ell(kappa X) - a - c + Tdef を %d 塔で照合、不一致 %d' % (nC, nCmis))
print('Step C: Tdef の M* 非依存性（M*+1, M*+2）を %d 件で照合（ell=5,7 の %d 塔は設計上除外）'
      % (nMs, nMsskip))
print('Step D: Tdef != 0 の塔 %d / Tdef = 0 の塔 %d（e は局所量だけでは決まらない）' % (nT0, nTz))
print('Step D: 非整数の c: %d 塔 / 非整数の e: %d 塔 / 非整数の Tdef: %d 塔（d は上で全数整数を確認済み）'
      % (nonintc, noninte, nonintT))
print('Step D: d の値の分布 (ell,d):count = %s' % dict(sorted(cntd.items())))

# ==========================================================================
hdr('まとめ')
# ==========================================================================
print('FAIL 件数: %d' % FAIL)
print('打ち切り件数: %d' % len(TRUNC))
for t in TRUNC:
    print('  - %s' % t)
print('総所要 %.1fs' % (time.time() - T22))
