# cycle 22 / T3 Pure: e には過渡欠損 Tdef が本当に要ることの確認。
#
# 対応する証明本体: outputs/reports/cycle22_T3_coefficients_d_e.md
# 対象ラベルの宣言: overview.md
#
# 定理 D2 は e = v_ell(kappa(X)) - a - c + Tdef と分解する。
# 「Tdef は捻り段データ (Lambda_k, theta^sharp_k) と A_gen から決まってしまうのではないか」
# という疑い（＝第 3 層が余計ではないか）を潰すのが本スクリプトの目的。
#
#   Step K  定理 D2   (a,b,c,d) と局所データがすべて一致するのに e が違う 2 塔を探す。
#                     見つかれば「e は第 2 層（捻り段データ + A_gen）では決まらない」が確定する。
#   Step L  ----      Tdef の符号・大きさの分布と、Tdef = 0（漸近が n=0 から成り立つ）塔の割合。
#
# 壁時計上限を置き、打ち切ったら件数と中身を必ず出力する。

import sys, time, itertools
load('_defs22.sage')

T22 = time.time()
def el22(): return '[%7.1fs]' % (time.time() - T22)
FAIL = 0; TRUNC = []
def fail(msg):
    global FAIL
    FAIL += 1; print('  FAIL: %s' % msg); sys.stdout.flush()
def hdr(s):
    print(''); print('=' * 78); print(s, el22()); print('=' * 78); sys.stdout.flush()

def bq(loops): return [(0, 0, c) for c in loops]

V6 = [(1, 0), (0, 1), (1, 1), (1, -1), (2, 1), (1, 2)]
V4 = [(0, 0), (1, 0), (0, 1), (1, 1)]
POP = []
for L in (2, 3):
    for combo in itertools.combinations_with_replacement(V6, L):
        POP.append(('BQ%d %s' % (L, ','.join(str(c) for c in combo)), 1, bq(list(combo))))
for combo in itertools.combinations_with_replacement(V4, 3):
    POP.append(('TV3 %s' % ','.join(str(c) for c in combo), 2, [(0, 1, c) for c in combo]))
for p in range(1, 9):
    for q in range(p, 9):
        POP.append(('FAM p=%d q=%d' % (p, q), 1, bq([(1, 0)] * p + [(0, 1)] * q)))

BUDGET = 700.0
print('cycle 22 / T3 Pure: e に過渡欠損が要ること', el22())
print('母集団 %d 塔 x ell in [2,3]' % len(POP))

hdr('Step K / L: (a,b,c,d) と局所データが一致して e が違う対を探す')
DATA = []
t0 = time.time()
for ell in (2, 3):
    for (nm, m, ed) in POP:
        if time.time() - t0 > BUDGET:
            TRUNC.append('Step K/L: 壁時計 %.0fs 超過。ell=%d の "%s" 以降を未実施' % (BUDGET, ell, nm))
            break
        try:
            P = closed_form(m, ed, ell)
        except Exception:
            continue
        if P is None:
            continue
        co = coeffs5(P, ell, Mstar(P, ell))
        if co is None:
            continue
        loc = tuple(sorted((tuple(dd['u']), ZZ(dd['jstar']), ZZ(dd['ejs']), ZZ(dd['K']),
                            tuple((k, L, th) for (k, L, th, _, _) in dd['tw']))
                           for dd in P['detail']))
        DATA.append(dict(nm=nm, ell=ell, co=co, loc=loc, Agen=P['Agen'], vk=P['vkX'],
                         Ebar=str(ebar(P['Ev'], ell)), mu=P['mu']))
print('有効 %d 塔' % len(DATA))

# Step K: (ell, a,b,c,d) が同じで e が違う対
from collections import defaultdict
by = defaultdict(list)
for r in DATA:
    (a, b, c, d, e, td) = r['co']
    by[(r['ell'], a, b, c, d)].append(r)
nK = 0; shown = 0
for (key, rs) in sorted(by.items(), key=lambda kv: str(kv[0])):
    es = set(r['co'][4] for r in rs)
    if len(es) > 1:
        nK += 1
        if shown < 6:
            shown += 1
            print('')
            print('  (ell,a,b,c,d)=%s で e が %d 通り: %s' % (key, len(es), sorted(es)))
            seen = set()
            for r in rs:            # e の値ごとに代表を 1 本ずつ出す
                if r['co'][4] in seen:
                    continue
                seen.add(r['co'][4])
                print('     %-34s e=%-8s Tdef=%-8s v_ell(kappa X)=%s A_gen=%s'
                      % (r['nm'], r['co'][4], r['co'][5], r['vk'], r['Agen']))
print('')
print('Step K: (ell,a,b,c,d) が同じで e が複数値を取る組 %d 個' % nK)

# Step K2: 局所データ（捻り段データを含む）+ A_gen + v_ell(kappa X) まで一致して e が違う対
by2 = defaultdict(list)
for r in DATA:
    by2[(r['ell'], r['mu'], r['loc'], r['Agen'], r['vk'])].append(r)
nK2 = 0; shown2 = 0
for (key, rs) in by2.items():
    es = set(r['co'][4] for r in rs)
    if len(es) > 1:
        nK2 += 1
        if shown2 < 4:
            shown2 += 1
            print('')
            print('  局所データ + A_gen + v_ell(kappa X) が一致して e が %d 通り: %s' % (len(es), sorted(es)))
            seen = set()
            for r in rs:            # e の値ごとに代表を 1 本ずつ出す
                if r['co'][4] in seen:
                    continue
                seen.add(r['co'][4])
                print('     ell=%d %-34s (a,b,c,d,e)=%s Tdef=%s'
                      % (r['ell'], r['nm'], r['co'][:5], r['co'][5]))
print('')
print('Step K2: 第 2 層（局所データ + A_gen）+ v_ell(kappa X) まで一致して e が違う組 %d 個' % nK2)

# Step L: Tdef の分布
from collections import Counter
cnt = Counter(r['co'][5] for r in DATA)
nz = sum(v for (k, v) in cnt.items() if k != 0)
print('')
print('Step L: Tdef = 0 の塔 %d / Tdef != 0 の塔 %d' % (cnt.get(QQ(0), 0), nz))
print('Step L: Tdef の値の分布（上位 12 個）= %s'
      % dict(sorted(cnt.items(), key=lambda kv: -kv[1])[:12]))
print('Step L: Tdef の最小 %s / 最大 %s' % (min(cnt), max(cnt)))

hdr('まとめ')
print('FAIL 件数: %d' % FAIL)
print('打ち切り件数: %d' % len(TRUNC))
for t in TRUNC: print('  - %s' % t)
print('総所要 %.1fs' % (time.time() - T22))
