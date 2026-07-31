# cycle 16 / T3 Pure: 低位項の係数（とくに定数項 nu）の明示公式と、退化点の整理。
#
# 対応する証明本体: outputs/reports/cycle16_T3_lower_order_and_degeneracy.md
# 共有定義は _defs.sage にある（記号もそちらのヘッダ参照）。
#
# 実行: sage lower_order.sage

load('_defs.sage')

print("=" * 78)
print("cycle 16 / T3: 低位項（定数項 nu）の明示公式と退化点の整理")
print("SageMath", version())
print("=" * 78)

# ==========================================================================
# Step 1  nu の閉形式（非退化かつ J_0 = 1）
# ==========================================================================
print()
print("### Step 1  非退化 かつ J_0 = 1（<=> k < ell-1）での完全閉形式")
print("    ord_ell(kappa_n) = mu(ell^{2n}-1) + c(ell^n-1) - 2n + v_ell(kappa(X)),  c = k(ell+1)/(ell-1)")
print("    フィットするパラメータは 0 個。n = 0..n_max の全段で照合する。")
print()

cnt1 = bad1 = 0
for (name, m, edges) in EX:
    for ell in PRIMES:
        inv = invariants(m, edges, ell)
        if inv is None or inv['zeros'] or inv['J0'] != 1:
            continue
        ords = usable_prefix(tower_ords(m, edges, ell, NMAX[ell], tag='Step1 ' + name))
        if len(ords) < 2:
            print("  %-42s ell=%2d | 計算できた段が %d 段のみ -> 除外"
                  % (name[:42], ell, len(ords)))
            continue
        nmax = len(ords) - 1
        ok = all(ords[n] == predicted_ord(inv, ell, QQ(0), n) for n in range(nmax + 1))
        cnt1 += 1
        if not ok:
            bad1 += 1
        print("  %-42s ell=%2d mu=%d k=%d v(kX)=%d | n=0..%d 全段一致=%s"
              % (name[:42], ell, inv['mu'], inv['k'], inv['vkX'], nmax, ok))
        if not ok:
            print("      実測 %s" % ords)
            print("      予言 %s" % [predicted_ord(inv, ell, QQ(0), n) for n in range(nmax + 1)])
print("  %s 対象 %d 件、破れ %d 件" % (el(), cnt1, bad1))

# ==========================================================================
# Step 2  nu の有限手続き（非退化かつ J_0 >= 2）
# ==========================================================================
print()
print("### Step 2  非退化 かつ J_0 >= 2 での nu（補正 Delta は低レベルの有限計算だけで決まる）")
print("    Delta はレベル ell^{J_0-1} 以下の 1 の冪根での付値の有限和から計算し、")
print("    塔の値 kappa_n は一切使わない。照合は n = J_0-1 .. n_max。")
print()

cnt2 = bad2 = 0
for (name, m, edges) in EX:
    for ell in PRIMES:
        inv = invariants(m, edges, ell)
        if inv is None or inv['zeros'] or inv['J0'] < 2:
            continue
        ords = usable_prefix(tower_ords(m, edges, ell, NMAX[ell], tag='Step2 ' + name))
        n0chk = inv['J0'] - 1
        if len(ords) < n0chk + 1:
            print("  %-38s ell=%2d J0=%d | 計算できた段が %d 段のみ（n>=%d が要る）-> 除外"
                  % (name[:38], ell, inv['J0'], len(ords), n0chk))
            continue
        nmax = len(ords) - 1
        Delta = delta_correction(inv['D'], ell, inv['mu'], inv['k'], inv['J0'])
        if Delta is None:
            continue
        n0 = inv['J0'] - 1
        ok = all(ords[n] == predicted_ord(inv, ell, Delta, n) for n in range(n0, nmax + 1))
        # n < n0 でも成立するか（成立開始段の実測）
        nstart = None
        for n in range(nmax + 1):
            if all(ords[t] == predicted_ord(inv, ell, Delta, t) for t in range(n, nmax + 1)):
                nstart = n; break
        cnt2 += 1
        if not ok:
            bad2 += 1
        print("  %-38s ell=%2d mu=%d k=%d J0=%d Delta=%s | n>=%d 一致=%s (実測の成立開始段 n=%s)"
              % (name[:38], ell, inv['mu'], inv['k'], inv['J0'], Delta, n0, ok, nstart))
        if not ok:
            print("      実測 %s" % ords)
            print("      予言 %s" % [predicted_ord(inv, ell, Delta, n) for n in range(nmax + 1)])
print("  %s 対象 %d 件、破れ %d 件" % (el(), cnt2, bad2))

# Delta != 0 の例を探す。上の照合が全て Delta = 0 だと、定理 N2 の要である補正項が
# 一度も効いていないことになり、「N2 を照合した」とは言えない。これは自分で
# 確かめないと気付けない種類の穴なので、明示的に探して件数を出す。
print()
print("  (2b) Delta != 0 の例の探索（Delta = 0 ばかりだと補正項が一度も効いていない）")
seen_delta = []
for (name, m, edges) in EX:
    for ell in PRIMES:
        inv = invariants(m, edges, ell)
        if inv is None or inv['zeros'] or inv['J0'] < 2:
            continue
        Dl = delta_correction(inv['D'], ell, inv['mu'], inv['k'], inv['J0'])
        if Dl is None:
            continue
        seen_delta.append((name, ell, inv['J0'], inv['k'], Dl))
nz = [t for t in seen_delta if t[4] != 0]
for (name, ell, J0, k, Dl) in seen_delta:
    print("     %-38s ell=%2d J0=%d k=%d Delta=%s" % (name[:38], ell, J0, k, Dl))
print("     Delta を計算できた %d 件のうち、Delta != 0 は %d 件" % (len(seen_delta), len(nz)))
if not nz:
    print("     ** 全て Delta = 0。定理 N2 の補正項が非自明に効く例は見つかっていない。**")
    print("     ** したがって Step 2 は N2 のうち『Delta = 0 の場合』しか照合できていない。**")

# ==========================================================================
# Step 3  mu > 0 / v_ell(kappa(X)) > 0 の非退化例を探索して確認
# ==========================================================================
print()
print("### Step 3  mu > 0 または v_ell(kappa(X)) > 0 の非退化例（3 つの寄与の独立性）")
print("    ランダム探索で条件を満たす例を集め、Step 1/2 と同じ 0 パラメータ照合を行う。")
print()

# 以前はランダム探索でこの条件（非退化かつ mu>0 または v_ell(kappa(X))>0）を満たす例を
# 探していたが、4000 回引いて 0 件だった。0 件の探索は何の検証にもならないので、
# 条件を満たす例を **狙って構成する** ことに切り替えた。
#
#  (i) mu > 0 の作り方: 全ての辺を ell 重にすると L が ell 倍になり、
#      1 頂点グラフでは D も ell 倍。よって content が ell 倍され mu が 1 増える。
#      E = ell^{-mu} D は元と同じなので、非退化性・k・H は元のグラフのまま。
# (ii) v_ell(kappa(X)) > 0 の作り方: 底グラフの全域木数が ell で割れるようにする。
#      2 頂点を ell 本の平行辺で結ぶと kappa(X) = ell。

def repeat_edges(m, edges, times):
    out = []
    for e in edges:
        for _ in range(times):
            out.append(e)
    return (m, out)


def parallel_bundle(ell):
    """2 頂点 ell 重辺。kappa(X) = ell なので v_ell(kappa(X)) = 1。"""
    volts = [(0, 0), (1, 0), (0, 1), (1, 1), (2, 1), (1, 2), (2, 3), (3, 1),
             (1, 3), (2, 2), (0, 2), (3, 2), (2, 0)]
    return (2, [(0, 1, volts[i % len(volts)]) for i in range(ell)])


CAND3 = []
for ell in [5, 7, 11, 13]:
    # (i) mu > 0
    for (name, m, edges) in EX[:6]:
        (m2, e2) = repeat_edges(m, edges, ell)
        CAND3.append(('%s を %d 重化 (mu>0 狙い)' % (name[:24], ell), m2, e2, ell))
    # (ii) v_ell(kappa(X)) > 0
    (mb, eb) = parallel_bundle(ell)
    CAND3.append(('2 頂点 %d 重平行辺 (v(kX)>0 狙い)' % ell, mb, eb, ell))

found = []
rej = {'inv=None((H)不成立等)': 0, '退化(z_H>0)': 0, 'mu=0 かつ v(kX)=0': 0, '段数不足': 0}
for (name, m, edges, ell) in CAND3:
    inv = invariants(m, edges, ell)
    if inv is None:
        rej['inv=None((H)不成立等)'] += 1; continue
    if inv['zeros']:
        rej['退化(z_H>0)'] += 1; continue
    if inv['mu'] == 0 and inv['vkX'] == 0:
        rej['mu=0 かつ v(kX)=0'] += 1; continue
    ords = usable_prefix(tower_ords(m, edges, ell, NMAX[ell], tag='Step3 ' + name))
    if len(ords) < 2:
        rej['段数不足'] += 1; continue
    found.append((name, m, edges, ell, inv, ords))

print("  構成した候補 %d 件のうち、非退化かつ mu>0 または v_ell(kappa(X))>0 を満たしたもの %d 件"
      % (len(CAND3), len(found)))
print("  除外の内訳: %s" % ', '.join('%s=%d' % kv for kv in rej.items()))
nmu = len([1 for f in found if f[4]['mu'] > 0])
nkx = len([1 for f in found if f[4]['vkX'] > 0])
print("  内訳: mu>0 が %d 件、v_ell(kappa(X))>0 が %d 件" % (nmu, nkx))
print()

cnt3 = bad3 = 0
for (name, m, edges, ell, inv, ords) in found:
    Delta = QQ(0) if inv['J0'] == 1 else delta_correction(inv['D'], ell, inv['mu'], inv['k'], inv['J0'])
    if Delta is None:
        continue
    n0 = inv['J0'] - 1
    nmax = len(ords) - 1
    ok = all(ords[n] == predicted_ord(inv, ell, Delta, n) for n in range(n0, nmax + 1))
    cnt3 += 1
    if not ok:
        bad3 += 1
    print("  %-40s ell=%2d mu=%d k=%d v(kX)=%d(kX=%d) J0=%d Delta=%s | n=%d..%d 一致=%s"
          % (name[:40], ell, inv['mu'], inv['k'], inv['vkX'], inv['kX'], inv['J0'], Delta,
             n0, nmax, ok))
    if not ok:
        print("      実測 %s" % ords)
        print("      予言 %s" % [predicted_ord(inv, ell, Delta, n) for n in range(nmax + 1)])
print("  %s 対象 %d 件、破れ %d 件" % (el(), cnt3, bad3))
if cnt3 == 0:
    print("  ** 対象 0 件。この Step は何も検証していない（0 件を根拠にしてはならない）。**")

# ==========================================================================
# Step 4  退化帯の計数
# ==========================================================================
print()
print("### Step 4  退化帯 Band_n（H の有理零点が指す方向に属する点）の計数と、")
print("    「max(i,j) >= J_0 の点は Band に入る <=> 補題 8.4 の予言 v = k/phi(ell^max) から外れる」")
print()

def direction_of(ell, n, a, b):
    """(zeta,xi) = (g^a, g^b)（g は原始 ell^n 乗根、(a,b) != (0,0)）の方向。
       i = ord_ell 位数の指数。i<j -> (0:1)、i>j -> (1:0)、i=j -> (1: b a^{-1} mod ell)。"""
    N = ell**n
    va = n if a % N == 0 else ZZ(a % N).valuation(ell)
    vb = n if b % N == 0 else ZZ(b % N).valuation(ell)
    i = n - va          # zeta の位数 = ell^i
    j = n - vb
    if i < j:
        return ('(0:1)', i, j)
    if i > j:
        return ('(1:0)', i, j)
    # i = j = M >= 1: a = ell^{n-M} a', b = ell^{n-M} b'、a',b' は ell と互いに素
    M = i
    ap = ZZ(a % N) // ell**(n - M)
    bp = ZZ(b % N) // ell**(n - M)
    c = GF(ell)(bp) / GF(ell)(ap)
    return ('(1:%s)' % c, i, j)

# (4a) 方向ごとの点の個数がちょうど (ell^{2n}-1)/(ell+1) であること
print("  (4a) ell+1 個の方向に点がちょうど均等に分かれる（各 (ell^{2n}-1)/(ell+1) 個）")
bad4a = 0
for ell in [2, 3, 5]:
    for n in range(1, {2: 6, 3: 4, 5: 3}[ell] + 1):
        N = ell**n
        cntd = {}
        for a in range(N):
            for b in range(N):
                if a == 0 and b == 0:
                    continue
                (d, i, j) = direction_of(ell, n, a, b)
                cntd[d] = cntd.get(d, 0) + 1
        exp = ZZ(ell**(2 * n) - 1) / (ell + 1)
        ok = (len(cntd) == ell + 1) and all(v == exp for v in cntd.values())
        if not ok:
            bad4a += 1
        print("     ell=%d n=%d: 方向 %d 個, 各 %s (期待 %s) -> %s"
              % (ell, n, len(cntd), sorted(set(cntd.values())), exp, ok))
print("     破れ %d 件" % bad4a)

# (4b) Band = 例外点（max(i,j) >= J_0 に限る）
print()
print("  (4b) max(i,j) >= J_0 の点で「Band に入る <=> v_ell(E) != k/phi(ell^max)」")
PTMAX = {2: 4, 3: 2, 5: 2}
cnt4 = bad4 = 0
for (name, m, edges) in EX:
    for ell in [2, 3, 5]:
        inv = invariants(m, edges, ell)
        if inv is None:
            continue
        J0 = inv['J0']; k = inv['k']
        nmaxpt = PTMAX[ell]
        if nmaxpt < J0:
            continue
        Ev = E_of(inv['D'], ell, inv['mu'])
        zeros = set(inv['zeros'])
        for n in range(J0, nmaxpt + 1):
            N = ell**n
            mism = 0; nband = 0; nexc = 0; tot = 0
            for a in range(N):
                for b in range(N):
                    if a == 0 and b == 0:
                        continue
                    (d, i, j) = direction_of(ell, n, a, b)
                    if max(i, j) < J0:
                        continue
                    tot += 1
                    v = point_val(Ev, ell, n, a, b)
                    pred = QQ(k) / euler_phi(ell**max(i, j))
                    exc = (v != pred)
                    inb = (d in zeros)
                    if exc:
                        nexc += 1
                    if inb:
                        nband += 1
                    if exc != inb:
                        mism += 1
            cnt4 += 1
            if mism:
                bad4 += 1
            print("     %-34s ell=%d n=%d k=%d J0=%d z_H=%d | 対象点 %d, Band %d, 例外 %d, 不一致 %d"
                  % (name[:34], ell, n, k, J0, len(zeros), tot, nband, nexc, mism))
print("  %s (4b) 対象 %d 件、不一致のあった件数 %d" % (el(), cnt4, bad4))

# (4c) |Band_n| = z_H (ell^{2n}-1)/(ell+1)
print()
print("  (4c) |Band_n| = z_H (ell^{2n}-1)/(ell+1) を n = 1..6 で確認（組合せ計数のみ）")
bad4c = 0
for (name, m, edges) in EX[:8]:
    for ell in [2, 3]:
        inv = invariants(m, edges, ell)
        if inv is None:
            continue
        zeros = set(inv['zeros']); zH = len(zeros)
        for n in range(1, {2: 6, 3: 4}[ell] + 1):
            N = ell**n
            cb = 0
            for a in range(N):
                for b in range(N):
                    if a == 0 and b == 0:
                        continue
                    (d, i, j) = direction_of(ell, n, a, b)
                    if d in zeros:
                        cb += 1
            exp = zH * ZZ(ell**(2 * n) - 1) / (ell + 1)
            if cb != exp:
                bad4c += 1
                print("     MISMATCH %s ell=%d n=%d: %d != %s" % (name, ell, n, cb, exp))
print("     破れ %d 件" % bad4c)

# ==========================================================================
# Step 5  ell = 2 のトーラス（本プロジェクトの主対象）
# ==========================================================================
print()
print("### Step 5  ell = 2 のトーラス（bouquet (1,0),(0,1)）の完全解決")
TOR = (1, [(0, 0, (1, 0)), (0, 0, (0, 1))])
Dtor = detL(*TOR)
print("    D =", Dtor)

def ph(e, M):
    """v_2(1 + zeta_{2^M}^c)  （e = v_2(c)）。e = M-1 のとき零（+Infinity）。"""
    if e >= M:
        return QQ(1)
    if e == M - 1:
        return oo
    return QQ(2)**(1 + e - M)

print()
print("  (5a) 点ごとの付値: 位数がともに 2^M（M >= 2）の (zeta,xi) = (g^a, g^b) について")
print("       v_2(D) = min(2, ph(s) + ph(t)),  s = v_2(b-a), t = v_2(b+a)")
bad5a = 0; cnt5a = 0
for M in range(1, 7):
    (K, g, P, e) = cyc_data(2, M)
    bad = 0; tot = 0
    for a in range(1, 2**M, 2):
        for b in range(1, 2**M, 2):
            v = point_val(Dtor, 2, M, a, b)
            s = M if (b - a) % 2**M == 0 else ZZ((b - a) % 2**M).valuation(2)
            t = M if (b + a) % 2**M == 0 else ZZ((b + a) % 2**M).valuation(2)
            ps = ph(s, M); pt = ph(t, M)
            pred = QQ(2) if (ps is oo or pt is oo) else min(QQ(2), ps + pt)
            tot += 1
            if v != pred:
                bad += 1
                if bad <= 3:
                    print("       M=%d a=%d b=%d: v=%s pred=%s (s=%d t=%d)" % (M, a, b, v, pred, s, t))
    cnt5a += tot
    if M >= 2:
        bad5a += bad
    print("     M=%d: 点 %d 個、公式から外れた点 %d 個%s"
          % (M, tot, bad, "（M=1 は例外。本文 5.3 参照）" if M == 1 else ""))
print("     M >= 2 での破れ %d 件（照合点数 %d）" % (bad5a, cnt5a))

print()
print("  (5b) Sigma_M := sum_{ord zeta = ord xi = 2^M} v_2(D) = (M+1) 2^M - 4  (M >= 2)")
bad5b = 0
for M in range(1, 8):
    tot = QQ(0)
    for a in range(1, 2**M, 2):
        for b in range(1, 2**M, 2):
            s = M if (b - a) % 2**M == 0 else ZZ((b - a) % 2**M).valuation(2)
            t = M if (b + a) % 2**M == 0 else ZZ((b + a) % 2**M).valuation(2)
            ps = ph(s, M); pt = ph(t, M)
            tot += QQ(2) if (ps is oo or pt is oo) else min(QQ(2), ps + pt)
    if M == 1:
        tot = QQ(3)     # M = 1 は (a,b) = (1,1) の 1 点のみで v = 3（(5a) 参照）
    pred = (M + 1) * 2**M - 4
    ok = (tot == pred)
    if M >= 2 and not ok:
        bad5b += 1
    print("     M=%d: Sigma_M = %s, (M+1)2^M - 4 = %d -> %s" % (M, tot, pred, ok))
print("     M >= 2 での破れ %d 件" % bad5b)

print()
print("  (5c) 閉形式 ord_2(kappa_n) = 2n*2^n + 4*2^n - 6n - 1  (n >= 1)")
ords_tor2 = usable_prefix(tower_ords(TOR[0], TOR[1], 2, NMAX[2], tag='Step5c torus ell=2'))
bad5c = 0
for n in range(0, len(ords_tor2)):
    pred = 2 * n * 2**n + 4 * 2**n - 6 * n - 1
    ok = (ords_tor2[n] == pred)
    if n >= 1 and not ok:
        bad5c += 1
    print("     n=%d: 実測 %s / 公式 %d -> %s" % (n, ords_tor2[n], pred, ok))
print("     n >= 1 での破れ %d 件（n=0 は kappa_0 = kappa(X) = 1 で公式の射程外）" % bad5c)

# ==========================================================================
# Step 6  型 I / II / III の分類
# ==========================================================================
print()
print("### Step 6  型分類（z_H = H の P^1(F_ell) 有理零点の個数、b = n ell^n の係数）")
print("    型 I : z_H = 0（非退化）。命題 W + 本 report の nu 公式で完全に決まる。")
print("    型 II: z_H >= 1 かつ b = 0。退化帯はあるが n ell^n 項が出ない。")
print("    型III: b > 0。n ell^n 項が出る。")
print("    係数は最大 5 段でフィットし、より小さい n で out-of-sample 検算する。")
print()

def fit5(ell, ns, vals):
    M = matrix(QQ, [[ell**(2 * n), n * ell**n, ell**n, n, 1] for n in ns])
    return M.solve_right(vector(QQ, vals))

rows6 = []
for (name, m, edges) in EX:
    for ell in [2, 3]:
        inv = invariants(m, edges, ell)
        if inv is None:
            continue
        nmax = NMAX[ell]
        if nmax < 5:
            continue
        ords = usable_prefix(tower_ords(m, edges, ell, nmax, tag='Step6 ' + name))
        if len(ords) < 6:
            print("  %-38s ell=%d | 計算できた段 %d (フィットに 6 段必要) -> 除外"
                  % (name[:38], ell, len(ords)))
            continue
        nmax = len(ords) - 1
        ns = list(range(nmax - 4, nmax + 1))
        try:
            co = fit5(ell, ns, [ords[n] for n in ns])
        except Exception:
            continue
        def fitval(n):
            return sum(co[t] * v for t, v in
                       enumerate([ell**(2 * n), n * ell**n, ell**n, n, 1]))
        # n = 0 は kappa_0 = kappa(X) で、定理 D2 など閉形式の射程外（n >= 1）である。
        # よって out-of-sample は n >= 1 のものを本判定とし、n = 0 は参考として別に出す。
        oos_all = [n for n in range(nmax - 4)]
        oos = [n for n in oos_all if n >= 1]
        okoos = all(fitval(n) == ords[n] for n in oos) if oos else None
        okoos0 = all(fitval(n) == ords[n] for n in oos_all) if oos_all else None
        # フィットの健全性: 5 項の形が本当に当てはまるなら係数は整数になるはず
        # （ord は整数値で、ell^{2n}, n ell^n, ell^n, n, 1 の整数係数結合で書けるなら）。
        integral = all(c in ZZ for c in co)
        zH = len(inv['zeros'])
        # **フィットが健全でないものに型を付けない。** 5 点から 5 係数を解けば必ず「解」は
        # 出るが、それは 5 項の形が正しいことを意味しない（cycle 14 の事故）。
        if not integral or okoos is False:
            typ = 'フィット失敗（5 項の形に合っていない。型を付けない）'
        elif zH == 0:
            typ = 'I'
        elif co[1] > 0:
            typ = 'III'
        elif co[1] == 0:
            typ = 'II'
        else:
            typ = 'フィット失敗（b < 0 は 5 項の形と整合しない）'
        rows6.append((name, ell, inv['mu'], inv['k'], zH, inv['zeros'], co, okoos, typ))
        print("  %-38s ell=%d mu=%d k=%d z_H=%d %-22s" % (name[:38], ell, inv['mu'], inv['k'], zH,
                                                          ','.join(inv['zeros'])))
        print("      a=%s b=%s c=%s d=%s e=%s | 係数が整数=%s | oos(n>=1, n=%s)=%s | oos に n=0 も含めると=%s"
              % (co[0], co[1], co[2], co[3], co[4], integral, oos, okoos, okoos0))
        print("      -> %s" % typ)
ngood = len([r for r in rows6 if r[8] in ('I', 'II', 'III')])
nII = len([r for r in rows6 if r[8] == 'II'])
nIII = len([r for r in rows6 if r[8] == 'III'])
print("  %s 分類 %d 件中、フィットが健全だったもの %d 件（型 II %d 件、型 III %d 件）"
      % (el(), len(rows6), ngood, nII, nIII))
print("  注: フィットは 5 点から 5 係数を解いたものであり、それ自体は証明ではない。")
print("      out-of-sample=True は「フィットに使っていない n でも合った」ことだけを意味する。")
print("      係数が非整数、または oos(n>=1) が False のものは 5 項の形自体が当てはまっていない。")
print("      そのようなものに型を付けると、失敗したフィットを『型 II の実例』と誤読することになる。")

# ==========================================================================
# Step 7  ell = 1 mod 4 のトーラス
# ==========================================================================
print()
print("### Step 7  ell = 1 mod 4 のトーラス（H = -(T^2+S^2) が有理零点 c^2 = -1 をもつ）")
print("    ell = 5, 13。退化なので命題 W の射程外。段数が足りず 5 係数は決まらないので、")
print("    ここでは (i) 退化帯の割合、(ii) 実測値と『非退化なら成り立ったはずの閉形式』との差")
print("    を出すにとどめる（フィットはしない）。")
print()
print("    さらに、report 仮説 6.1（帯の上で v = 4/phi(ell^M)）から導いた閉形式")
print("      (6.3)  ord_ell(kappa_n) = (2 ell + 6)/(ell - 1) * (ell^n - 1) - 2n")
print("    を照合する。(6.3) は帯の付値の観察（小さい M）だけから導いたもので、")
print("    塔の値 kappa_n を一切使っていない。したがってこの照合は out-of-sample である。")
print("    ただし一致しても仮説 6.1 は証明されない（全ての M についての主張だから）。")
print()
bad7 = 0; cnt7 = 0
for ell in [5, 13, 17]:
    inv = invariants(TOR[0], TOR[1], ell)
    ords = usable_prefix(tower_ords(TOR[0], TOR[1], ell, NMAX.get(ell, 1),
                                    tag='Step7 torus ell=%d' % ell))
    print("  ell=%2d: k=%d mu=%d z_H=%d %s, 退化帯の割合 = %s/%d, 計算できた段 n=0..%d"
          % (ell, inv['k'], inv['mu'], len(inv['zeros']), inv['zeros'],
             len(inv['zeros']), ell + 1, len(ords) - 1))
    for n in range(len(ords)):
        nd = predicted_ord(inv, ell, QQ(0), n)
        h61 = QQ(2 * ell + 6) / (ell - 1) * (ell**n - 1) - 2 * n
        ok61 = (ords[n] == h61)
        if n >= 1:
            cnt7 += 1
            if not ok61:
                bad7 += 1
        print("     n=%d: 実測 %s / 非退化型の予言 %s / 差 %s || 仮説6.1 の (6.3) = %s -> %s"
              % (n, ords[n], nd, ords[n] - nd, h61, ok61))
print("  %s (6.3) の照合: n>=1 の %d 件中 破れ %d 件" % (el(), cnt7, bad7))
print("  注: これは有限段の out-of-sample 照合であって、仮説 6.1 の証明ではない。")

# ==========================================================================
# 打ち切り一覧（黙って範囲を狭めないための記録）
# ==========================================================================
print()
print("### 時間上限（%d 秒/段）で打ち切った計算の一覧" % STAGE_BUDGET)
if not SKIPS:
    print("  なし（全ての段が上限内で完了した）")
else:
    for (tag, m, edges, ell, n, budget) in SKIPS:
        print("  %-34s ell=%2d n=%d で打ち切り（m=%d edges=%s）" % (tag[:34], ell, n, m, list(edges)))
    print("  合計 %d 件。これらの段は **未検証** であり、上の各 Step の結論の射程外である。" % len(SKIPS))

print()
print("=" * 78)
print("%s 終了" % el())
print("=" * 78)
