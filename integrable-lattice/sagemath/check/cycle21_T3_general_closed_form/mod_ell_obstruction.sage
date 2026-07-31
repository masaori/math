# cycle 21 / T3 Pure: 捻り段データ (Lambda_k, theta^sharp_k) が bar tilde E だけでは決まらないこと。
#
# 対応する証明本体: outputs/reports/cycle21_T3_general_closed_form.md §9.1（Step H）
#
# 主張: tilde E を ell * (単項式) だけずらすと bar tilde E は変わらない（したがって
#   S_infinity・j^*・二項式因子の重複度・e_j はすべて不変）が、Lambda_1 は変わる。
#   したがって c, d, e を「bar tilde E の不変量」で書くことは原理的にできない。
#   b = sum j^* が bar tilde E で決まる（cycle 20 定理 W4）のとは対照的である。
#
# 壁時計は数秒。

import sys, time
load('_defs21.sage')

T0 = time.time()
FAIL = 0
def fail(msg):
    global FAIL
    FAIL += 1
    print('  FAIL: %s' % msg); sys.stdout.flush()

print('cycle 21 / T3 Pure: Lambda_k は bar tilde E だけでは決まらない（Step H）')

CASES = [
    ('ell=2 torus (1,0),(0,1)', 2, 1, [(0, 0, (1, 0)), (0, 0, (0, 1))]),
    ('ell=2 TV3 (0,0),(1,0),(0,1)', 2, 2, [(0, 1, (0, 0)), (0, 1, (1, 0)), (0, 1, (0, 1))]),
    ('ell=3 bouquet (1,0),(0,1),(1,1),(1,-1)', 3, 1,
     [(0, 0, c) for c in [(1, 0), (0, 1), (1, 1), (1, -1)]]),
]

print('')
print('--- H1: 同じ (j^*, lambda, theta^*, e_{j^*}) をもつ塔で Lambda_1 が違うこと ---')
rows = []
for (nm, ell, m, ed) in CASES:
    D = detL(m, ed); Ev = E_of(D, ell, mu_content(D, ell))
    S = s_infinity(Ev, ell)
    rec = S[0]
    (L1, t1, m1) = twisted_stage(Ev, ell, rec['u'], 1)
    rows.append((nm, ell, rec['jstar'], rec['lam'], rec['thstar'], rec['ej'][rec['jstar']], L1, t1))
    print('  %-40s ell=%d j*=%s lam=%s th*=%s e_{j*}=%s  ->  (Lambda_1,theta#_1)=(%s,%s)'
          % (nm, ell, rec['jstar'], rec['lam'], rec['thstar'], rec['ej'][rec['jstar']], L1, t1))
same = [r for r in rows if r[1] == 2]
if len(same) >= 2 and same[0][2:6] == same[1][2:6] and same[0][6] != same[1][6]:
    print('  => (j^*,lambda,theta^*,e_{j^*}) が同一で Lambda_1 が異なる組が実在する。OK')
else:
    fail('H1: そのような組が見つからない（report §9.1 の根拠が崩れる）')

print('')
print('--- H2: tilde E を ell*(単項式) でずらすと bar tilde E は不変だが Lambda_1 が変わる ---')
D = detL(1, [(0, 0, (1, 0)), (0, 0, (0, 1))])
Ev = E_of(D, 2, mu_content(D, 2))
S = s_infinity(Ev, 2)
u = S[0]['u']
base = twisted_stage(Ev, 2, u, 1)
print('  基準 (ell=2 torus, u=%s): (Lambda_1,theta#_1,m#_1) = %s' % (u, base))
(z, w) = Ev.parent().gens()
nchanged = 0
for pert in [2 * z * w, 2 * z**2 * w, 2 * z * w**2, 2 * z**2 * w - 2 * z * w]:
    Ev2 = Ev + pert
    if ebar(Ev2, 2) != ebar(Ev, 2):
        fail('H2: 摂動 %s が bar tilde E を変えている' % pert); continue
    S2 = s_infinity(Ev2, 2)
    if sorted(r['u'] for r in S2) != sorted(r['u'] for r in S):
        fail('H2: 摂動 %s が S_infinity を変えている' % pert); continue
    tw = twisted_stage(Ev2, 2, u, 1)
    ch = (tw[0] != base[0])
    if ch:
        nchanged += 1
    print('  摂動 %-22s bar 不変 / S_inf 不変 / (Lambda_1,theta#_1,m#_1)=%s  %s'
          % (pert, tw, '<- Lambda_1 が変わった' if ch else ''))
if nchanged == 0:
    fail('H2: Lambda_1 を変える摂動が 1 つも見つからない（report §9.1 の根拠が崩れる）')
else:
    print('  => bar tilde E を固定したまま Lambda_1 を変える摂動が %d 件。'
          'Lambda_1 は bar tilde E の関数ではない。OK' % nchanged)

print('')
print('FAIL 件数: %d' % FAIL)
print('打ち切り件数: 0')
print('総所要 %.1fs' % (time.time() - T0))
