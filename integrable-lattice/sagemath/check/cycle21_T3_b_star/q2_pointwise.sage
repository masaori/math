# cycle 21 / T3 Pure: 仮定 (B*) を落とす — 検証その 2（点ごとの分解式）。
#
# 対応する証明本体: outputs/reports/cycle21_T3_drop_assumption_B_star.md
#
# 検証する内容（本 report の証明の中核）:
#   Step F  定理 Q1 の (i)  「良い点」（beta_P + theta_G^max < phi(ell^M)）では
#                             hat theta_M(P) = beta_P + theta_G(P) が **等号で** 成り立つ
#   Step G  定理 Q1 の (ii) 「悪い点」の個数が M に依らず有界であること（実測）
#   Step H  ----            (B*) が破れる塔（cycle 20 §8.1 の反例 2 件）でも上が成り立つこと
#   Step I  ----            定理 B'（＝仮定 (B*) が要求するもの）が実際に破れている点の件数を
#                            同じ掃引で数え、「(B*) は破れているのに Q1 は破れていない」を明示する
#
# 重要: hat theta_M は整数終結式による厳密計算（定理 L4）であり、本 report の理論から独立である。
#
# 壁時計の設計上限: 20 分。超えたら打ち切り、件数と中身を必ず出す。

import sys, time, itertools

load('_defs21.sage')

T_START = time.time()
def el21():
    return '[%7.1fs]' % (time.time() - T_START)

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
    print(s, el21())
    print('=' * 78)
    sys.stdout.flush()

BUDGET = 900.0
MMAX = {2: 7, 3: 5, 5: 3, 7: 2}

# 掃引する塔: ADV 全件（(B*) の反例 2 件を含む）＋ 母集団から b の値ごとに拾ったもの
SEL = list(ADV)
seen = {}
for (name, m, edges) in POP:
    if name.startswith('ADV'):
        continue
    for ell in [2, 3]:
        pr = prepared(m, edges, ell)
        if pr is None:
            continue
        (inv, Ev) = pr
        try:
            bb = decompose(Ev, ell)['b']
        except RuntimeError:
            continue
        key = (ell, ZZ(bb))
        if seen.get(key, 0) < 2:
            seen[key] = seen.get(key, 0) + 1
            SEL.append((name, m, edges))
        break

print('cycle 21 / T3 Pure: 仮定 (B*) を落とす — 検証その 2（点ごとの分解式）', el21())
print('掃引する塔: %d（ADV %d 件 ＋ 母集団から %d 件）' % (len(SEL), len(ADV), len(SEL) - len(ADV)))
print('レベル上限: %s' % MMAX)
sys.stdout.flush()

hdr('Step F/G/H/I: 点ごとの分解式・悪い点の個数・(B*) の破れの件数')

print('%-38s %3s %2s %6s %6s %7s %7s %7s %7s'
      % ('tower', 'ell', 'M', '#good', '#bad', 'goodOK', 'badcontr', 'B*viol', 'err/l^M'))
sys.stdout.flush()

nGood = 0
nBad = 0
nBstarViol = 0
nBstarViolGood = 0
badcount_by_tower = {}
truncated = []

for (name, m, edges) in SEL:
    for ell in [2, 3, 5, 7]:
        if ell not in MMAX:
            continue
        pr = prepared(m, edges, ell)
        if pr is None:
            continue
        (inv, Ev) = pr
        try:
            dec = decompose(Ev, ell)
        except RuntimeError as e:
            fail('decompose: %s ell=%d %s' % (name, ell, e))
            continue
        try:
            (tgmax, Lused, stable) = theta_G_max(dec['G'], ell, Lmax=3)
        except RuntimeError as e:
            fail('theta_G: %s ell=%d %s' % (name, ell, e))
            continue
        b = dec['b']
        parts = dec['parts']

        for M in range(1, MMAX[ell] + 1):
            if time.time() - T_START > BUDGET:
                truncated.append((name, ell, M))
                continue
            phiM = euler_phi(ell**M)
            ngood = nbad = 0
            goodok = True
            badcontr = ZZ(0)
            tot = ZZ(0)
            viol = 0
            viol_good = 0
            skipped = 0
            for (a, bb) in p1_reps(ell, M):
                meas = hat_theta_exact(Ev, ell, M, a, bb)
                if meas is None:      # (H) の破れ。この塔・レベルは対象外
                    skipped += 1
                    continue
                tot += meas
                beta = beta_of_point(parts, ell, M, a, bb)
                # 「良い点」の判定（本 report の十分条件）
                good = (beta is not Infinity) and (beta + tgmax < phiM)
                if True:
                    Fv = restrict_phi(Ev, a, bb)
                    isviol = False
                    if Fv != 0:
                        csv = [ZZ(c) for c in Fv.coefficients(sparse=False)]
                        vv = [phiM * ZZ(c).valuation(ell) + mm
                              for (mm, c) in enumerate(csv) if c != 0]
                        if vv:
                            mnv = min(vv)
                            isviol = (len([1 for x in vv if x == mnv]) >= 2) or (ZZ(meas) != mnv)
                    if isviol:
                        viol += 1
                        if good:
                            viol_good += 1
                if good:
                    tg = theta_lp(dec['G'], ell, a, bb)
                    if tg is Infinity:
                        fail('theta_G infinite at good point: %s ell=%d M=%d P=%s'
                             % (name, ell, M, (a, bb)))
                        continue
                    pred = beta + tg
                    ngood += 1
                    if ZZ(meas) != ZZ(pred):
                        goodok = False
                        fail('pointwise: %s ell=%d M=%d P=%s meas=%s pred=%s (beta=%s theta_G=%s)'
                             % (name, ell, M, (a, bb), meas, pred, beta, tg))
                else:
                    nbad += 1
                    badcontr += meas
            if skipped:
                # (H) を満たさない点があるレベルは掃引対象から外す（黙って落とさない）
                truncated.append((name, ell, M, 'H-violation at %d points' % skipped))
                continue
            nGood += ngood
            nBad += nbad
            nBstarViol += viol
            nBstarViolGood += viol_good
            badcount_by_tower.setdefault((name, ell), []).append((M, nbad))
            err = RR(abs(RR(tot) - RR(b) * RR(M) * RR(phiM))) / RR(ell**M)
            print('%-38s %3d %2d %6d %6d %7s %8s %7d %7.2f'
                  % (name[:38], ell, M, ngood, nbad, 'OK' if goodok else 'NG',
                     badcontr, viol, err))
            sys.stdout.flush()

hdr('総括')
print('良い点（分解式が等号で成り立つべき点）の総数: %d' % nGood)
print('悪い点（十分条件を満たさない点。粗上界だけで押さえる点）の総数: %d' % nBad)
print('仮定 (B*) が実際に破れていた点の総数: %d' % nBstarViol)
print('  うち「良い点」（本 report の分解式が等号で当たった点）: %d' % nBstarViolGood)
print('  → この数が正なら「(B*) が破れているのに定理 Q1 の点ごとの式は破れていない」ことの直接の実例である')
print('')
print('悪い点の個数の M 依存（M に依らず有界であるべき）:')
for (k, v) in sorted(badcount_by_tower.items()):
    print('  %-38s ell=%d : %s' % (k[0][:38], k[1], ', '.join('M=%d:%d' % t for t in v)))
print('')
print('FAIL: %d 件' % FAIL)
if truncated:
    print('打ち切り: %d 件 %s' % (len(truncated), truncated[:8]))
else:
    print('打ち切り: 0 件')
print('総経過 %s' % el21())
