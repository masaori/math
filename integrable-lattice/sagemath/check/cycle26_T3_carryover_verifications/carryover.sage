# cycle 26 / T3 Pure: 3 サイクル持ち越しの未検証 2 件を閉じる。
#
# 対応する証明本体: outputs/reports/cycle26_T3_carryover_verifications.md
# 対象ラベルの宣言: overview.md
#
# 閉じる対象（どちらも「記録はされたが確認されていない」まま 3 サイクル持ち越された）:
#
#   持ち越し (i)  cycle22_T3_coefficients_d_e.md 注 3.1
#     訂正後の定理 D2 は「Tdef = 0 ⟺ (1.1) が n=0 で成り立つ」と述べ、
#     さらに「レベル n で (1.1) が成り立つ ⟺ S(n) = Tdef」（S(n) = sum_{M<=n} delta_M）を与える。
#     注 3.1 は「この帰結は Step L では確認していない」と明記している。
#     ここでは delta_M を実測し、S(n) と、Matrix-Tree 定理で独立に計算した ord_ell(kappa_n) を
#     突き合わせて、**レベルごとの同値そのもの**を確認する。
#
#     併せて、同 report の証明が残した限定
#       「実在の塔で delta_M の符号が混ざる例は確認していない」
#     を母集団全体で調べる。符号が混ざる塔が実在し、かつ Tdef = 0 なら、
#     証明中の「任意の Theta で作った反例」が**実在の塔で実現する**ことになる。
#
#   持ち越し (ii) cycle21_T3_general_closed_form.md §6.3
#     「ell=2 トーラス（bouquet (1,0),(0,1)）で DuBose-Vallieres の数列と n=1 から完全に一致する」。
#     cycle22 step 4 の Lean 検算が「一致自体は事実だが定理の保証範囲外」と指摘した箇所。
#     cycle 21 の時点では「n >= n0 で成り立つ」しか無かったので、n=1 は保証の外だった。
#     cycle 22 定理 D2 のレベルごとの判定（S(n) = Tdef）を当てると、
#     この塔で n=1 が保証の内側に入るかどうかが決まる。それを確定させる。
#
# 量の帰属: Theta_M, delta_M, S(n), Tdef, ord_ell(kappa_n) はすべて ZZ / QQ。
#           kappa_n は整数行列式（Matrix-Tree）。**R へは一度も脱出しない。**
#
# 壁時計上限を置き、打ち切ったら件数と中身を必ず出力する。

import sys, time, itertools
load('../cycle22_T3_coefficients_d_e/_defs22.sage')

T26 = time.time()
def el26(): return '[%7.1fs]' % (time.time() - T26)
FAIL = 0; TRUNC = []
def fail(msg):
    global FAIL
    FAIL += 1; print('  FAIL: %s' % msg); sys.stdout.flush()
def hdr(s):
    print(''); print('=' * 78); print(s, el26()); print('=' * 78); sys.stdout.flush()


def deltas(P, ell, Ms):
    """delta_M = Theta_M - (alpha M ell^M + beta ell^M + gamma) を M = 1..Ms-1 で返す。
       (H) が破れていれば None。"""
    al, be, ga = P['alpha'], P['beta'], P['gamma']
    out = []
    for M in range(1, Ms):
        t = Theta_level(P['Ev'], ell, M)
        if t is None:
            return None
        out.append(QQ(t) - (al * M * ell**M + be * ell**M + ga))
    return out


# 母集団は cycle 22 Step L と同じにする（比較できるようにするため）。
V6 = [(1, 0), (0, 1), (1, 1), (1, -1), (2, 1), (1, 2)]
V4 = [(0, 0), (1, 0), (0, 1), (1, 1)]
POP = []
for L in (2, 3):
    for combo in itertools.combinations_with_replacement(V6, L):
        POP.append(('BQ%d %s' % (L, ','.join(str(c) for c in combo)),
                    1, [(0, 0, c) for c in combo]))
for combo in itertools.combinations_with_replacement(V4, 3):
    POP.append(('TV3 %s' % ','.join(str(c) for c in combo), 2, [(0, 1, c) for c in combo]))
for p in range(1, 9):
    for q in range(p, 9):
        POP.append(('FAM p=%d q=%d' % (p, q), 1,
                    [(0, 0, (1, 0))] * p + [(0, 0, (0, 1))] * q))

BUDGET_D = 700.0
BUDGET_K = 700.0
NMAX = {2: 4, 3: 3}

print('cycle 26 / T3 Pure: 持ち越し未検証 2 件を閉じる', el26())
print('母集団 %d 塔 x ell in [2,3]（cycle 22 Step L と同一）' % len(POP))

# ==========================================================================
# Step A: delta_M の実測。Tdef = 0 の塔の内訳と、符号が混ざる塔の探索。
# ==========================================================================
hdr('Step A: delta_M を実測し、Tdef = 0 の塔の内訳を出す')

DATA = []
t0 = time.time()
for ell in (2, 3):
    for (nm, m, ed) in POP:
        if time.time() - t0 > BUDGET_D:
            TRUNC.append('Step A: 壁時計 %.0fs 超過。ell=%d の "%s" 以降を未実施' % (BUDGET_D, ell, nm))
            break
        try:
            P = closed_form(m, ed, ell)
        except Exception:
            continue
        if P is None:
            continue
        Ms = Mstar(P, ell)
        co = coeffs5(P, ell, Ms)
        if co is None:
            continue
        ds = deltas(P, ell, Ms)
        if ds is None:
            continue
        (a, b, c, d, e, tdef) = co
        # Tdef は delta の総和であること（定義の一致）をその場で確認する
        if sum(ds) != tdef:
            fail('ell=%d %s: sum(delta_M) != Tdef（%s vs %s）' % (ell, nm, sum(ds), tdef))
        DATA.append(dict(nm=nm, m=m, ed=ed, ell=ell, Ms=Ms, co=co, ds=ds, P=P))

print('有効 %d 塔' % len(DATA))

zero = [r for r in DATA if r['co'][5] == 0]
nonzero = [r for r in DATA if r['co'][5] != 0]
print('Tdef = 0 の塔 %d / Tdef != 0 の塔 %d' % (len(zero), len(nonzero)))

# Tdef = 0 の塔を「全 delta_M が 0」と「0 でない delta_M があるのに総和が 0」に分ける。
allzero = [r for r in zero if all(x == 0 for x in r['ds'])]
cancel = [r for r in zero if any(x != 0 for x in r['ds'])]
print('  うち delta_M が全て 0（＝過渡が一切無い。(1.1) が全 n>=0 で成り立つ）: %d' % len(allzero))
print('  うち delta_M に 0 でないものがあり総和だけ 0（＝n=0 では成り立つが n>=1 は不明）: %d'
      % len(cancel))

# 符号が混ざる塔（report §3 の証明が「実在の塔では確認していない」と限定した対象）
mixed = []
for r in DATA:
    sg = set(sign(x) for x in r['ds'] if x != 0)
    if len(sg) > 1:
        mixed.append(r)
print('')
print('delta_M の符号が混ざる塔（正と負の両方が出る）: %d 件' % len(mixed))
for r in mixed[:8]:
    print('  ell=%d %-30s M*=%s delta=%s Tdef=%s'
          % (r['ell'], r['nm'], r['Ms'], [str(x) for x in r['ds']], r['co'][5]))
mixed_zero = [r for r in mixed if r['co'][5] == 0]
print('  そのうち Tdef = 0 のもの（＝証明中の反例が実在の塔で実現する）: %d 件' % len(mixed_zero))
for r in mixed_zero[:8]:
    print('    ell=%d %-30s delta=%s' % (r['ell'], r['nm'], [str(x) for x in r['ds']]))
sys.stdout.flush()

# ==========================================================================
# Step B: レベルごとの同値「(1.1) が n で成り立つ ⟺ S(n) = Tdef」を
#         Matrix-Tree の塔の値と突き合わせて確認する。
# ==========================================================================
hdr('Step B: 定理 D2 のレベルごとの判定を、塔の値（Matrix-Tree）と突き合わせる')
print('各塔・各 n について、S(n) = Tdef かどうか（予言）と、')
print('ord_ell(kappa_n) が (1.1) と一致するかどうか（実測）が一致することを見る。')
print('**n < M* も含めて全ての n を見る。** 従来の照合は n >= n0 に限っていた。')

nchk = 0; nmis = 0; nskip = 0
n0_hits = 0        # 予言も実測も「一致する」
n0_miss = 0        # 予言も実測も「一致しない」
t1 = time.time(); stopped = False
for r in DATA:
    if stopped:
        break
    ell = r['ell']
    (a, b, c, d, e, tdef) = r['co']
    ds = r['ds']
    for n in range(0, NMAX[ell] + 1):
        if time.time() - t1 > BUDGET_K:
            TRUNC.append('Step B: 壁時計 %.0fs 超過。ell=%d の "%s" n=%d 以降を未実施'
                         % (BUDGET_K, ell, r['nm'], n))
            stopped = True; break
        kx = kappa_derived(r['m'], r['ed'], ell**n, ell**n)
        if kx == 0:
            nskip += 1; continue
        actual = ZZ(kx).valuation(ell)
        pred = a * ell**(2 * n) + b * n * ell**n + c * ell**n + d * n + e
        # S(n) = sum_{M=1}^{min(n, M*-1)} delta_M（M >= M* の delta は 0）
        Sn = sum(ds[:n]) if n <= len(ds) else sum(ds)
        says_equal = (Sn == tdef)
        is_equal = (actual == pred)
        nchk += 1
        if says_equal != is_equal:
            nmis += 1
            fail('ell=%d %s n=%d: 判定 S(n)=Tdef は %s だが実測の一致は %s'
                 ' (actual=%s pred=%s S(n)=%s Tdef=%s)'
                 % (ell, r['nm'], n, says_equal, is_equal, actual, pred, Sn, tdef))
        elif is_equal:
            n0_hits += 1
        else:
            n0_miss += 1

print('')
print('照合 %d 件（判定と実測が食い違った件数 %d）/ 除外 %d' % (nchk, nmis, nskip))
print('  判定「一致する」かつ実測も一致: %d 件' % n0_hits)
print('  判定「一致しない」かつ実測も不一致: %d 件（**判定が空振りでないことの証拠**）' % n0_miss)
sys.stdout.flush()

# ==========================================================================
# Step C: n=0 での同値「Tdef = 0 ⟺ (1.1) が n=0 で成り立つ」を単独で出す。
#         これが注 3.1 が「Step L では確認していない」と書いた帰結そのもの。
# ==========================================================================
hdr('Step C: 注 3.1 の帰結 — Tdef = 0 の塔で (1.1) が n=0 で成り立つ')

c_ok = 0; c_ng = 0; c_zero_ok = 0
for r in DATA:
    ell = r['ell']
    (a, b, c, d, e, tdef) = r['co']
    kx = kappa_derived(r['m'], r['ed'], 1, 1)
    if kx == 0:
        continue
    actual = ZZ(kx).valuation(ell)
    pred = a + c + e          # n=0 での (1.1)
    if (tdef == 0) != (actual == pred):
        c_ng += 1
        fail('ell=%d %s: n=0 の同値が破れた（Tdef=%s actual=%s pred=%s）'
             % (ell, r['nm'], tdef, actual, pred))
    else:
        c_ok += 1
        if tdef == 0:
            c_zero_ok += 1
print('n=0 の同値を確認した塔 %d 件 / 破れ %d 件' % (c_ok, c_ng))
print('  うち Tdef = 0 で実際に (1.1) が n=0 で成り立った塔: %d 件' % c_zero_ok)
sys.stdout.flush()

# ==========================================================================
# Step D: 持ち越し (ii) — ell=2 トーラス（bouquet (1,0),(0,1)）を名指しで調べる。
# ==========================================================================
hdr('Step D: cycle21 §6.3 の ell=2 トーラスで、n=1 が保証の内側かを決める')

ell = 2
ed = [(0, 0, (1, 0)), (0, 0, (0, 1))]
P = closed_form(1, ed, ell)
if P is None:
    fail('ell=2 トーラスで closed_form が None を返した')
else:
    Ms = Mstar(P, ell)
    co = coeffs5(P, ell, Ms)
    ds = deltas(P, ell, Ms)
    (a, b, c, d, e, tdef) = co
    print('M* = %s' % Ms)
    print('(a,b,c,d,e) = (%s, %s, %s, %s, %s)' % (a, b, c, d, e))
    print('delta_M (M=1..M*-1) = %s' % [str(x) for x in ds])
    print('Tdef = %s' % tdef)
    # cycle21 §6.3 が印字した閉形式は ord_2(kappa_n) = 2n 2^n + 4*2^n - 6n - 1。
    # (1.1) は a ell^{2n} + b n ell^n + c ell^n + d n + e なので、
    # この式には ell^{2n} の項が無い ＝ **a = 0** である（§6.3 の alpha = 1 は a ではない）。
    want = (QQ(0), QQ(2), QQ(4), QQ(-6), QQ(-1))
    if (a, b, c, d, e) != want:
        fail('cycle21 §6.3 の閉形式から読める係数 %s と一致しない（実測 %s）'
             % (str(want), str((a, b, c, d, e))))
    else:
        print('cycle21 §6.3 の閉形式 2n2^n + 4*2^n - 6n - 1 から読める (a,b,c,d,e)=(0,2,4,-6,-1)'
              ' と一致した。')

    # 本題: 定理 D2 のレベルごとの判定「(1.1) が n で成り立つ ⟺ S(n) = Tdef」を、
    # この塔について n ごとに出し、塔の値（Matrix-Tree）と突き合わせる。
    DV = [5, 19, 61, 167]     # DuBose-Vallieres の数列（cycle 14 §7.3・cycle 16 定理 D2）
    print('')
    print('  レベルごとの判定と実測:')
    for n in range(0, 5):
        Sn = sum(ds[:n]) if n <= len(ds) else sum(ds)
        says_equal = (Sn == tdef)
        kx = kappa_derived(1, ed, ell**n, ell**n)
        actual = ZZ(kx).valuation(ell)
        pred = a * ell**(2 * n) + b * n * ell**n + c * ell**n + d * n + e
        is_equal = (actual == pred)
        mark = ''
        if 1 <= n <= 4:
            mark = ' / DuBose-Vallieres=%s' % DV[n - 1]
            if actual != DV[n - 1]:
                fail('ell=2 トーラス n=%d: 塔の値 %s が DuBose-Vallieres の %s と違う'
                     % (n, actual, DV[n - 1]))
        print('   n=%d: S(n)=%-3s Tdef=%-3s 判定=%-5s / ord_2(kappa_n)=%-4s (1.1)=%-4s 実測=%-5s%s'
              % (n, Sn, tdef, says_equal, actual, pred, is_equal, mark))
        if says_equal != is_equal:
            fail('ell=2 トーラス n=%d: 判定 %s と実測 %s が食い違う' % (n, says_equal, is_equal))

    # 結論を機械が出す（人が読んで書くのではなく、実測から決める）。
    start = None
    for n in range(0, 5):
        Sn = sum(ds[:n]) if n <= len(ds) else sum(ds)
        if Sn == tdef:
            start = n
            break
    print('')
    print('  ⇒ (1.1) が成り立ち始めるレベルは n = %s（それ未満では成り立たない）。' % start)
    if start == 1:
        print('     cycle21 §6.3 の「n=1 から完全に一致する」は**正しく、かつ**')
        print('     cycle22 定理 D2 のレベルごとの判定が**ちょうどそう予言する**。')
        print('     Tdef = %s != 0 なので n=0 では成り立たない。「n=1 から」は偶然ではない。' % tdef)
    else:
        fail('(1.1) の成立開始レベルが 1 ではなく %s だった（§6.3 の記述と食い違う）' % start)

hdr('まとめ')
print('FAIL 件数: %d' % FAIL)
print('打ち切り件数: %d' % len(TRUNC))
for t in TRUNC:
    print('  - %s' % t)
print('総所要 %.1fs' % (time.time() - T26))
