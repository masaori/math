# cycle 22 / T3 Pure: 閉形式 (a,b,c,d,e) を **塔の値**（Matrix-Tree 定理）と直接照合する。
#
# 対応する証明本体: outputs/reports/cycle22_T3_coefficients_d_e.md（Step E）
# 対象ラベルの宣言: overview.md
#
# structure.sage（Step A-D）と mod_ell_cut.sage（Step F-I）は理論の内部整合を見る。
# 本スクリプトは kappa_n = kappa(X_{ell^n, ell^n}) を Matrix-Tree 定理で独立に計算し、
# ord_ell(kappa_n) が a l^{2n} + b n l^n + c l^n + d n + e と一致するかを見る。
# **e が入っている定数項まで含めた照合**なので、定理 D2 の e の値を独立に検算することになる。
# 予言側は D の係数だけから決まる（当てはめ 0）。
#
# 段数の壁: kappa_n の計算は ell^{2n} * |V| 次の行列式なので ell=2 は n<=4、ell=3 は n<=3 まで。
# 壁時計上限を置き、打ち切ったら件数と中身を必ず出力する。

import sys, time, itertools
load('_defs22.sage')

T22 = time.time()
def el22(): return '[%7.1fs]' % (time.time() - T22)
FAIL = 0; TRUNC = []
def fail(msg):
    global FAIL
    FAIL += 1; print('  FAIL: %s' % msg); sys.stdout.flush()

BUDGET = 800.0
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

print('cycle 22 / T3 Pure: 閉形式 vs 塔の値（Matrix-Tree）', el22())
print('母集団 %d 塔、ell in %s、n <= %s' % (len(POP), sorted(NMAX), NMAX))
print('e を含む 5 係数すべてを、理論から独立な塔の値と照合する。')

tot = 0; nchk = 0; nmis = 0; nskip = 0; nearly = 0
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
        co = coeffs5(P, ell, Ms)
        if co is None:
            nskip += 1; continue
        (a, b, c, d, e, tdef) = co
        # 定理 D2 の分解を、この場でも独立に確認しておく
        if e != QQ(P['vkX']) - a - c + tdef:
            fail('ell=%d %s 定理 D2 の分解が破れた' % (ell, nm))
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
                    nearly += 1      # n < n0 は理論の射程外（漸近開始前）。数えるだけ
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
print('n < n0（漸近開始前・理論の射程外）でずれた件数: %d' % nearly)
print('FAIL 件数: %d' % FAIL)
print('打ち切り件数: %d' % len(TRUNC))
for t in TRUNC:
    print('  - %s' % t)
print('総所要 %.1fs' % (time.time() - T22))
