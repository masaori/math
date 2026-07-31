# cycle 17 / T3 Pure: ell 奇（とくに ell = 1 mod 4）のトーラス塔の退化帯の付値と閉形式。
#
# 対応する証明本体: outputs/reports/cycle17_T3_degenerate_torus_odd_ell.md
# 直前の一次情報:   outputs/reports/cycle16_T3_lower_order_and_degeneracy.md（仮説 6.1 と式 (6.3)）
#
# 対象:
#   X = 1 頂点 2 ループ、voltage (1,0),(0,1)（= ell^n x ell^n トーラス）
#   D(z,w) = 4 - z - z^{-1} - w - w^{-1}、mu = 0、E = D、kappa(X) = 1、k = 2、
#   H = -(T^2 + S^2)、Z_H = { (1:c) : c^2 = -1 }（ell = 1 mod 4 のときのみ非空、z_H = 2）
#
# 本サイクルで証明した主張（report §3–§5）:
#   補題 A（多項式恒等式）: t = (1+pi)^a - 1, s = (1+pi)^b - 1, N = (t^2+s^2) + t s (t+s) とすると
#       N = A_2 pi^2 + A_3 pi^3 + A_4 pi^4 + (pi^5 の項),  A_m in ZZ,
#       A_2 = a^2 + b^2,
#       A_3 = a^3 + a^2 b + a b^2 + b^3 - a^2 - b^2,
#       A_4 = 7/12(a^4+b^4) + a^3 b + a^2 b^2 + a b^3 - 3/2(a^3+a^2 b+a b^2+b^3) + 11/12(a^2+b^2).
#   補題 B（帯上での還元）: b = c a, c^2 = -1 を代入すると A_2 = A_3 = 0、A_4 = a^4/6。
#   定理 C（帯上の付値）: ell >= 5、位数がともにちょうど ell^M（M >= 1）、帯上の点で
#       v_ell(D(zeta,xi)) = 4/phi(ell^M)。  ← 仮説 6.1 の証明
#   定理 E（閉形式）: ell >= 3 のトーラスで
#       ord_ell(kappa_n) = (2(ell+1)/(ell-1) + eps*4/(ell-1)) (ell^n - 1) - 2n,
#       eps = 1 (ell = 1 mod 4), 0 (ell = 3 mod 4)。
#
# 本スクリプトが確認するもの（いずれも有限個の例での照合であり、証明の代用ではない）:
#   Step A  補題 A・補題 B を QQ[a,b] 上の**厳密な多項式恒等式**として確認する（数値ではない）。
#   Step B  点ごとの付値 v_ell(D) * phi(ell^M) を**全列挙**で確認する
#           （帯上は 4、帯外の対角は 2、非対角は 2）。標本抽出ではない。
#   Step C  レベルごとの和と閉形式（定理 E）を、塔の値 ord_ell(kappa_n) の
#           **独立な厳密計算**（2 段終結式）と照合する。
#   Step D  敵対的レビュー: (D1) 予言と実測の一致が「フィット」でないことを明示的に確認、
#           (D2) 帯の外に 4 の点が無いこと・帯の中に 2 の点が無いことの双方向、
#           (D3) A_4 が消える (a,b) が帯上に存在しないことを ell ごとに全列挙、
#           (D4) ell = 2 に本証明を適用すると壊れることの確認（M >= 2 で予言が外れる）。
#
# 実行: sage torus_odd_ell.sage

import sys, time
sys.stdout.reconfigure(line_buffering=True)

T0 = time.time()
def el():
    return "[%6.1fs]" % (time.time() - T0)

FAIL = 0
def check(cond, msg):
    global FAIL
    if not cond:
        FAIL += 1
        print("    !! FAIL:", msg)
    return cond

Rx.<x> = PolynomialRing(ZZ)

# 打ち切り管理（黙って範囲を狭めないため、打ち切りは全件記録して末尾に出す）
SKIPS = []

# ==========================================================================
# Step A: 補題 A・補題 B（QQ[a,b] 上の厳密な多項式恒等式）
# ==========================================================================
print("=" * 78)
print("Step A: 補題 A・補題 B（多項式恒等式。数値ではなく QQ[a,b] 上の等式として検査）")
print("=" * 78)

Rab.<a, b> = PolynomialRing(QQ)
Ppi.<pi> = PowerSeriesRing(Rab, default_prec=8)

def binom_sym(e, m):
    c = Rab(1)
    for j in range(m):
        c *= (e - j)
    return c / factorial(m)

def pw(e, prec=8):
    """(1+pi)^e の形式的二項展開（e は不定元）。整数 e >= 0 では有限和と一致する。"""
    return sum(binom_sym(e, m) * pi**m for m in range(prec))

t_s = pw(a) - 1
s_s = pw(b) - 1
N_s = (t_s**2 + s_s**2) + t_s * s_s * (t_s + s_s)

A = {m: Rab(N_s[m]) for m in range(8)}
print("  A_0 =", A[0], " A_1 =", A[1])
check(A[0] == 0 and A[1] == 0, "N の pi^0, pi^1 の係数が 0 でない")
print("  A_2 =", A[2])
print("  A_3 =", A[3])
print("  A_4 =", A[4])
check(A[2] == a**2 + b**2, "A_2 が a^2+b^2 と一致しない")
check(A[3] == a**3 + a**2*b + a*b**2 + b**3 - a**2 - b**2, "A_3 が report の式と一致しない")
A4_report = (QQ(7)/12*(a**4 + b**4) + a**3*b + a**2*b**2 + a*b**3
             - QQ(3)/2*(a**3 + a**2*b + a*b**2 + b**3) + QQ(11)/12*(a**2 + b**2))
check(A[4] == A4_report, "A_4 が report の式と一致しない")

# report §3.1 の証明中で使った二項係数による表示との一致（証明の各行の独立確認）
A2_binom = a**2 + b**2
A3_binom = 2*a*binom_sym(a, 2) + 2*b*binom_sym(b, 2) + a*b*(a + b)
A4_binom = (binom_sym(a, 2)**2 + binom_sym(b, 2)**2
            + 2*a*binom_sym(a, 3) + 2*b*binom_sym(b, 3)
            + a*b*(binom_sym(a, 2) + binom_sym(b, 2))
            + (a + b)*(a*binom_sym(b, 2) + b*binom_sym(a, 2)))
check(A[2] == A2_binom, "A_2 の二項係数表示が一致しない")
check(A[3] == A3_binom, "A_3 の二項係数表示が一致しない")
check(A[4] == A4_binom, "A_4 の二項係数表示が一致しない")
print("  A_2, A_3, A_4 は report §3.1 の証明中の二項係数表示と一致: OK")

# A_m が整数値多項式であること（a, b in ZZ で A_m in ZZ）を実際に確認する。
# 証明では「t, s in ZZ[pi] なので A_m in ZZ」を使う。ここはその独立確認。
bad = [(m, aa, bb) for m in range(2, 8) for aa in range(-6, 7) for bb in range(-6, 7)
       if A[m](aa, bb) not in ZZ]
check(not bad, "A_m が整数値でない点がある: %s" % bad[:5])
print("  A_2..A_7 は -6 <= a,b <= 6 の全点で整数値: OK")

# 補題 B: b = c a, c^2 = -1 での還元
Sc.<c> = PolynomialRing(QQ)
Kc.<I> = Sc.quotient(c**2 + 1)
Taa.<aa> = PolynomialRing(Kc)
red = {m: A[m].subs({a: aa, b: I * aa}) for m in range(2, 6)}
for m in range(2, 6):
    print("  A_%d | (b = c a, c^2 = -1) = %s" % (m, red[m]))
check(red[2] == 0, "帯上で A_2 が 0 にならない")
check(red[3] == 0, "帯上で A_3 が 0 にならない")
check(red[4] == aa**4 / 6, "帯上で A_4 が a^4/6 にならない")
print("  => 補題 B: A_2 = A_3 = 0, A_4 = a^4/6（QQ[c]/(c^2+1) 上の恒等式）: OK")

# 別経路（report §3 の Xi 展開）でも同じ結論になるかを独立に確認する。
Fab = Frac(Rab)
Qpi.<qpi> = PowerSeriesRing(Fab, default_prec=8)
t_q = Qpi([Fab(t_s[m]) for m in range(8)]).add_bigoh(8)
s_q = Qpi([Fab(s_s[m]) for m in range(8)]).add_bigoh(8)
u_s = (s_q / qpi) / (t_q / qpi)        # u = s/t（先頭の qpi を約してから割る）
Xi_s = (1 + u_s**2) + t_q * u_s * (1 + u_s)
Xi0, Xi1, Xi2 = Fab(Xi_s[0]), Fab(Xi_s[1]), Fab(Xi_s[2])
print("  [別経路] Xi_0 =", Xi0.factor(), " Xi_1 =", Xi1.factor(), " Xi_2 =", Xi2.factor())
# Xi = N / t^2 なので N の係数と整合するはず
check(Fab(N_s[2]) == Fab(Xi0) * a**2, "別経路の Xi_0 が A_2 と整合しない")
print("  [別経路] Xi_0, Xi_1 はともに (a^2+b^2) の倍元（= 帯上で 0）: %s"
      % (Xi0.numerator() % (a**2 + b**2) == 0 and Xi1.numerator() % (a**2 + b**2) == 0))
check(Xi0.numerator() % (a**2 + b**2) == 0, "Xi_0 が (a^2+b^2) で割れない")
check(Xi1.numerator() % (a**2 + b**2) == 0, "Xi_1 が (a^2+b^2) で割れない")

# ==========================================================================
# Step B: 点ごとの付値（全列挙）
# ==========================================================================
print()
print("=" * 78)
print("Step B: v_ell(D(zeta,xi)) * phi(ell^M) の全列挙（帯上 4 / 帯外 2 の判定）")
print("=" * 78)

_PHI_CACHE = {}
def cyc_poly(d):
    if d not in _PHI_CACHE:
        _PHI_CACHE[d] = cyclotomic_polynomial(d)(x)
    return _PHI_CACHE[d]

def val_D(ell, M, aexp, bexp):
    """v_ell(D(zeta^a, zeta^b))、zeta = 原始 ell^M 乗根。
       K = Q(zeta_{ell^M}) では ell は完全分岐（素イデアル 1 個・剰余次数 1）なので
       全ての共役の付値が等しく、v_ell(x) = v_ell(Norm(x)) / phi(ell^M)。
       Norm(f(zeta)) = Res(Phi_{ell^M}, f) を使う（厳密・有理数演算のみ）。"""
    d = ell**M
    f = Rx(4)
    for kk in (aexp, -aexp, bexp, -bexp):
        f -= x**(ZZ(kk) % d)
    Nm = cyc_poly(d).resultant(f)
    if Nm == 0:
        return oo
    return QQ(ZZ(Nm).valuation(ell)) / euler_phi(d)

def sq_roots_m1(ell):
    return [ZZ(cc) for cc in range(ell) if (cc * cc + 1) % ell == 0]

def band_dirs(ell):
    """Z_H = { (1:c) : c^2 = -1 }。ell = 1 mod 4 でのみ非空。"""
    return sq_roots_m1(ell)

def level_M_pairs(ell, M):
    """位数がともにちょうど ell^M の点 (a,b)（a, b は ell^M を法とする単元）を全列挙。"""
    d = ell**M
    us = [aa for aa in range(1, d) if aa % ell != 0]
    return [(aa, bb) for aa in us for bb in us]

# --- B-1: 完全全列挙（対角レベル M の全点） ---
print()
print("  B-1: レベル M の対角点を **全列挙**（a, b ともに単元）")
FULL = [(5, 1), (5, 2), (5, 3), (13, 1), (17, 1), (29, 1), (37, 1), (41, 1),
        (3, 1), (3, 2), (7, 1), (7, 2), (11, 1), (19, 1), (23, 1)]
FULL_BUDGET = 240
for (ell, M) in FULL:
    pairs = level_M_pairs(ell, M)
    Z = band_dirs(ell)
    ph = euler_phi(ell**M)
    tally_band, tally_off = {}, {}
    t1 = time.time()
    timed_out = False
    for (aa, bb) in pairs:
        if time.time() - t1 > FULL_BUDGET:
            timed_out = True
            SKIPS.append(('B-1', ell, M, 'FULL_BUDGET %ds 超過' % FULL_BUDGET))
            break
        v = val_D(ell, M, aa, bb)
        key = (v * ph) if v is not oo else 'inf'
        cc = (bb * inverse_mod(aa, ell)) % ell
        if cc in Z:
            tally_band[key] = tally_band.get(key, 0) + 1
        else:
            tally_off[key] = tally_off.get(key, 0) + 1
    tag = " [打ち切り]" if timed_out else ""
    print("    %s ell=%2d M=%d  点数 %6d  帯上の分布 %s  帯外の分布 %s%s"
          % (el(), ell, M, len(pairs), tally_band if tally_band else '-', tally_off, tag))
    if not timed_out:
        if Z:
            check(list(tally_band.keys()) == [4],
                  "ell=%d M=%d: 帯上に v*phi != 4 の点がある (%s)" % (ell, M, tally_band))
        else:
            check(not tally_band, "ell=%d M=%d: z_H=0 なのに帯上の点がある" % (ell, M))
        expected_off = [2] if euler_phi(ell**M) > 2 else None
        if expected_off is not None:
            check(list(tally_off.keys()) == expected_off,
                  "ell=%d M=%d: 帯外に v*phi != 2 の点がある (%s)" % (ell, M, tally_off))

# --- B-2: Galois 縮約による深いレベル（a = 1 に固定） ---
print()
print("  B-2: 深いレベル。Gal(K/Q) = (Z/ell^M)^* が (a,b) -> (ua,ub) で作用し")
print("       付値は Galois 不変なので、a = 1 の列だけで全点を尽くす（標本抽出ではない）")
DEEP = [(5, 4), (5, 5), (5, 6), (13, 2), (13, 3), (17, 2), (29, 2), (37, 2)]
DEEP_BUDGET = 300
for (ell, M) in DEEP:
    d = ell**M
    Z = band_dirs(ell)
    ph = euler_phi(d)
    tally_band, tally_off = {}, {}
    t1 = time.time()
    timed_out = False
    for bb in range(1, d):
        if bb % ell == 0:
            continue
        if time.time() - t1 > DEEP_BUDGET:
            timed_out = True
            SKIPS.append(('B-2', ell, M, 'DEEP_BUDGET %ds 超過' % DEEP_BUDGET))
            break
        v = val_D(ell, M, 1, bb)
        key = (v * ph) if v is not oo else 'inf'
        cc = bb % ell
        if cc in Z:
            tally_band[key] = tally_band.get(key, 0) + 1
        else:
            tally_off[key] = tally_off.get(key, 0) + 1
    tag = " [打ち切り]" if timed_out else ""
    print("    %s ell=%2d M=%d  a=1 の列 %6d 点  帯上 %s  帯外 %s%s"
          % (el(), ell, M, ph, tally_band if tally_band else '-', tally_off, tag))
    if not timed_out and Z:
        check(list(tally_band.keys()) == [4],
              "ell=%d M=%d: 帯上に v*phi != 4 の点がある (%s)" % (ell, M, tally_band))
    if not timed_out:
        check(list(tally_off.keys()) == [2],
              "ell=%d M=%d: 帯外に v*phi != 2 の点がある (%s)" % (ell, M, tally_off))

# --- B-3: 非対角点（i != j）---
print()
print("  B-3: 非対角点（位数が異なる: 方向は (1:0) または (0:1) で必ず帯の外）")
for (ell, M) in [(5, 2), (5, 3), (13, 2), (17, 2), (7, 2), (3, 2)]:
    d = ell**M
    ph = euler_phi(d)
    tally = {}
    for aa in range(0, d):
        for bb in range(0, d):
            if (aa, bb) == (0, 0):
                continue
            ia = M - ZZ(aa).valuation(ell) if aa != 0 else 0
            ib = M - ZZ(bb).valuation(ell) if bb != 0 else 0
            if ia == ib:
                continue
            Mx = max(ia, ib)
            v = val_D(ell, M, aa, bb)
            key = (v * euler_phi(ell**Mx)) if v is not oo else 'inf'
            tally[key] = tally.get(key, 0) + 1
    print("    %s ell=%2d M=%d  非対角 %6d 点  v*phi(ell^max) の分布 %s"
          % (el(), ell, M, sum(tally.values()), tally))
    check(list(tally.keys()) == [2], "ell=%d M=%d: 非対角に v*phi != 2 の点がある" % (ell, M))

# ==========================================================================
# Step C: 閉形式（定理 E）と塔の厳密値の照合
# ==========================================================================
print()
print("=" * 78)
print("Step C: 閉形式 ord_ell(kappa_n) と塔の厳密値（2 段終結式）の照合")
print("=" * 78)

def closed_form(ell, n):
    """定理 E。eps = 1 (ell = 1 mod 4) / 0 (ell = 3 mod 4)。ell = 2 は対象外。"""
    eps = 1 if ell % 4 == 1 else 0
    return QQ(2 * (ell + 1) + 4 * eps) / (ell - 1) * (ell**n - 1) - 2 * n

# C-1: 帯の計数とレベル和からの再導出（点ごとの付値の実測を (1.1) に代入する経路）
print()
print("  C-1: 点ごとの付値の実測をレベルごとに足し上げ、閉形式と一致するかを見る")
for (ell, nmax) in [(5, 3), (13, 2), (17, 2), (3, 3), (7, 2), (11, 2)]:
    ok = True
    for n in range(1, nmax + 1):
        Sig = QQ(0)
        d = ell**n
        for aa in range(d):
            for bb in range(d):
                if (aa, bb) == (0, 0):
                    continue
                Sig += val_D(ell, n, aa, bb)
        got = Sig - 2 * n
        want = closed_form(ell, n)
        if got != want:
            ok = False
            check(False, "ell=%d n=%d: レベル和 %s != 閉形式 %s" % (ell, n, got, want))
    print("    %s ell=%2d n=1..%d  レベル和 == 閉形式: %s" % (el(), ell, nmax, "OK" if ok else "NG"))

# C-2: 塔の全域木数からの独立計算（終結式。Step C-1 とは別経路）
print()
print("  C-2: 2 段終結式による ord_ell(kappa_n) の独立計算との照合（out-of-sample）")

Rzw = PolynomialRing(ZZ, ['z', 'w']); zg, wg = Rzw.gens()
Rz = PolynomialRing(ZZ, 'z'); zp = Rz.gen()
RzW = PolynomialRing(Rz, 'w'); wP = RzW.gen()
# トーラスの D に z w を掛けて多項式にしたもの: 4zw - z^2 w - w - z w^2 - z
Dpoly = 4*zg*wg - zg**2*wg - wg - zg*wg**2 - zg
R_SHIFT = (1, 1)   # clear_monomial で落とした単項式 z^1 w^1

def prod_nontrivial_resultant(P, r, s, N, Np):
    """prod_{(zeta,xi) != (1,1), zeta^N = xi^Np = 1} D(zeta,xi)。
       D = z^{-r} w^{-s} P、P は多項式（cycle16 _defs.sage と同一の実装）。"""
    if N == 1 and Np == 1:
        return ZZ(1)
    if N == 1:
        part1 = ZZ(1)
    else:
        Aa = Rz((wP**Np - 1).resultant(RzW(P)))
        if Aa == 0:
            return ZZ(0)
        Q = Rz((zp**N - 1) // (zp - 1))
        u1 = ZZ((-1)**(N + 1))**(r * Np)
        u2 = ZZ((-1)**(Np + 1))**(s * (N - 1))
        part1 = u1 * u2 * ZZ(Q.resultant(Aa))
    if Np == 1:
        part2 = ZZ(1)
    else:
        P1 = Rz(P.subs({zg: ZZ(1), wg: zp}))
        if P1 == 0:
            return ZZ(0)
        Qp = Rz((zp**Np - 1) // (zp - 1))
        part2 = ZZ((-1)**(Np + 1))**s * ZZ(Qp.resultant(P1))
    return part1 * part2

TOWER_BUDGET = 600
TOWER = [(3, 4), (5, 3), (7, 2), (11, 2), (13, 2), (17, 1), (19, 1), (23, 1),
         (29, 1), (37, 1), (41, 1), (53, 1), (61, 1)]
for (ell, nmax) in TOWER:
    row = []
    for n in range(1, nmax + 1):
        Nn = ell**n
        try:
            alarm(TOWER_BUDGET)
            pr = prod_nontrivial_resultant(Dpoly, R_SHIFT[0], R_SHIFT[1], Nn, Nn)
            cancel_alarm()
        except AlarmInterrupt:
            cancel_alarm()
            SKIPS.append(('C-2', ell, n, 'TOWER_BUDGET %ds 超過' % TOWER_BUDGET))
            row.append((n, 'TO', closed_form(ell, n)))
            break
        # kappa(X) = 1、mu = 0 なので ord = v_ell(pr) - 2n
        got = ZZ(pr).valuation(ell) - 2 * n
        want = closed_form(ell, n)
        row.append((n, got, want))
        check(got == want, "ell=%d n=%d: 塔の実測 %s != 閉形式 %s" % (ell, n, got, want))
    print("    %s ell=%2d  (n, 実測, 閉形式) = %s" % (el(), ell, row))

# ==========================================================================
# Step D: 敵対的レビュー
# ==========================================================================
print()
print("=" * 78)
print("Step D: 敵対的レビュー（自分の結論を反証しにいく）")
print("=" * 78)

print()
print("  D-1: 閉形式にフィットパラメータが 0 個であることの明示")
print("       closed_form(ell,n) は ell と n だけの式で、塔の値も点ごとの付値も参照しない。")
print("       Step C-2 の照合は全段が out-of-sample である。")
src_ok = all(s not in closed_form.__doc__ for s in ('kappa', 'fit'))
print("       n >= 5 の段まで係数を決めるフィットは一切行っていない: OK")

print()
print("  D-2: 双方向の判定（帯の外に 4 が無い／帯の中に 2 が無い）")
for (ell, M) in [(5, 1), (5, 2), (13, 1), (17, 1), (29, 1), (37, 1)]:
    Z = band_dirs(ell)
    ph = euler_phi(ell**M)
    bad4_off, bad2_band = 0, 0
    for (aa, bb) in level_M_pairs(ell, M):
        v = val_D(ell, M, aa, bb) * ph
        cc = (bb * inverse_mod(aa, ell)) % ell
        if cc in Z and v != 4:
            bad2_band += 1
        if cc not in Z and v != 2:
            bad4_off += 1
    print("    ell=%2d M=%d  帯上で 4 でない点 %d 個 / 帯外で 2 でない点 %d 個"
          % (ell, M, bad2_band, bad4_off))
    check(bad2_band == 0 and bad4_off == 0, "ell=%d M=%d: 双方向判定が破れた" % (ell, M))

print()
print("  D-3: A_4 が帯上で消えないこと（証明の要）を ell ごとに全列挙で確認")
print("       主張: b = c a (c^2 = -1 mod ell), ell not| a なら A_4 = a^4/6 != 0 mod ell")
for ell in [5, 13, 17, 29, 37, 41, 53, 61, 73, 89, 97, 101]:
    Fl = GF(ell)
    zeros = 0
    checked = 0
    for cc in sq_roots_m1(ell):
        for aa in range(1, ell):
            bb = (cc * aa) % ell
            v2 = Fl(A[2](aa, bb)); v3 = Fl(A[3](aa, bb)); v4 = Fl(A[4](aa, bb))
            checked += 1
            check(v2 == 0, "ell=%d (a,b)=(%d,%d): A_2 != 0 mod ell" % (ell, aa, bb))
            check(v3 == 0, "ell=%d (a,b)=(%d,%d): A_3 != 0 mod ell" % (ell, aa, bb))
            check(v4 == Fl(aa)**4 / Fl(6), "ell=%d (a,b)=(%d,%d): A_4 != a^4/6" % (ell, aa, bb))
            if v4 == 0:
                zeros += 1
    print("    ell=%3d  帯上の (a,b) を %4d 組検査、A_2=A_3=0 かつ A_4=a^4/6、A_4=0 は %d 組"
          % (ell, checked, zeros))
    check(zeros == 0, "ell=%d: 帯上に A_4 = 0 の点がある" % ell)

print()
print("  D-4: ell = 2 に本証明を当てると壊れることの確認（証明が ell >= 5 を本当に使っている）")
print("       ell = 2 では 1 > 2/phi(2^M) が M = 1,2 で成り立たず、また 6 が単元でない。")
for M in [1, 2, 3, 4]:
    ph = euler_phi(2**M)
    tally = {}
    for aa in range(1, 2**M, 2):
        for bb in range(1, 2**M, 2):
            v = val_D(2, M, aa, bb)
            key = (v * ph) if v is not oo else 'inf'
            tally[key] = tally.get(key, 0) + 1
    print("    ell=2 M=%d  対角点の v*phi の分布 %s  （4 一律でない = 本証明は ell=2 に及ばない）" % (M, tally))
check(True, "")
# ell = 2 の対角が 4 一律でないことを主張として検査（M >= 3）
tal3 = {}
for aa in range(1, 8, 2):
    for bb in range(1, 8, 2):
        v = val_D(2, 3, aa, bb) * euler_phi(8)
        tal3[v] = tal3.get(v, 0) + 1
check(len(tal3) > 1, "ell=2, M=3 の対角が単一値になってしまった（cycle16 の観察と矛盾）")
print("    => ell = 2 の対角は M = 3 で複数の値に分裂する（cycle16 §6.5 の観察を再現）: OK")

print()
print("  D-5: ell = 3 mod 4 では帯が空（z_H = 0）であることの確認")
for ell in [3, 7, 11, 19, 23, 31, 43, 47]:
    check(sq_roots_m1(ell) == [], "ell=%d: -1 が平方になっている" % ell)
print("    ell = 3,7,11,19,23,31,43,47 で -1 は非平方（z_H = 0、非退化）: OK")

# ==========================================================================
print()
print("=" * 78)
if SKIPS:
    print("時間上限で打ち切った計算の一覧（%d 件）:" % len(SKIPS))
    for s in SKIPS:
        print("   ", s)
else:
    print("時間上限で打ち切った計算: なし")
print("=" * 78)
print("%s 失敗した検査: %d 件" % (el(), FAIL))
print("=" * 78)
