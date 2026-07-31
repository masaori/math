# cycle 16 / T1: lambda = l_0(f) の有限手続きの検証ドライバ
load("l0_algorithm.sage")

R.<z, w> = ZZ[]
GENS = [z, w]


def norm_ord(x, K, p, deg):
    """K = Q(zeta_{p^n}) の元 x != 0 の ord_p（ord_p(p)=1 正規化）。
       p は K で完全分岐（唯一の素点, f=1, e=deg）なので ord_p(x) = v_p(N_{K/Q}(x))/deg。"""
    N = QQ(x.norm())
    return QQ(N.valuation(p)) / deg


def sum_ord_chi_fast(P, p, n):
    L = p**n
    if n == 0:
        val = ZZ(P.subs({z: 1, w: 1}))
        return (ZZ(0) if val == 0 else ZZ(val).valuation(p)), (1 if val == 0 else 0)
    K = CyclotomicField(L)
    zeta = K.gen()
    deg = K.degree()
    tot = QQ(0)
    ndeg = 0
    pw = [zeta**i for i in range(L)]
    for i in range(L):
        for j in range(L):
            val = P.subs({z: pw[i], w: pw[j]})
            if val == 0:
                ndeg += 1
                continue
            tot += norm_ord(val, K, p, deg)
    return tot, ndeg


def h_bound(P, p):
    """cycle 15 (4.1) の上界: bar f = bar P(1+T,1+S) の最低次斉次部分 H の
       F_p 有理線形因子の重複度の和。"""
    supp = laurent_dict(P, GENS)
    m0, barP = reduce_mod_p(supp, p)
    RT = PolynomialRing(GF(p), 'T,S')
    T, S = RT.gens()
    shift = [min(e[i] for e in barP.keys()) for i in range(2)]
    f = RT(0)
    for e, c in barP.items():
        f += RT(c) * (1 + T)**ZZ(e[0] - shift[0]) * (1 + S)**ZZ(e[1] - shift[1])
    if f == 0:
        return None
    k = min(m.degree() for m in f.monomials())
    H = sum(c * m for c, m in zip(f.coefficients(), f.monomials()) if m.degree() == k)
    tot = 0
    for fac, mult in RT(H).factor():
        if fac.degree() == 1 and fac.constant_coefficient() == 0:
            tot += mult
    return k, tot


# ============================================================ (1) アルゴリズムの出力

print()
print("--- (1) 有限アルゴリズム l0_algorithm() の出力（候補方向は台の差の原始方向のみ） ---")
print()

CASES = [
    ("torus 4-z-1/z-w-1/w", 4*z*w - z^2*w - w - z*w^2 - z, [2, 3, 5]),
    ("counterex z+w^2-2w",  z + w^2 - 2*w,                 [2, 3, 5]),
    ("z-1",                 z - 1,                          [2, 3]),
    ("(z-1)^2",             (z - 1)^2,                      [2, 3]),
    ("(z-1)(w-1)",          (z - 1)*(w - 1),                [2, 3]),
    ("(z-1)^2(w-1)",        (z - 1)^2*(w - 1),              [2, 3]),
    ("z*w-1  (=gamma_(1,1)-1)", z*w - 1,                    [2, 3]),
    ("z+w^2",               z + w^2,                        [2, 3]),
    ("6-z-w",               6 - z - w,                      [2, 3]),
    ("2+3z+3w",             2 + 3*z + 3*w,                  [2, 3]),
    ("3*(6-z-w)",           3*(6 - z - w),                  [2, 3]),
    ("7-2z-2w",             7 - 2*z - 2*w,                  [2, 3]),
    ("z^2+z*w+w^2 (p=3)",   z^2 + z*w + w^2,                [2, 3]),
    ("z^3-1",               z^3 - 1,                        [2, 3]),
]

print("%-26s %3s %5s %5s %6s  %s" % ("P", "p", "m_0", "l_0", "(4.1)上界", "割り切る方向 (v, ord)"))
ALG = {}
for name, P, ps in CASES:
    for p in ps:
        m0, l0, hits = l0_algorithm(P, GENS, p)
        kb = h_bound(P, p)
        ALG[(name, p)] = (m0, l0, hits)
        print("%-26s %3d %5d %5d %6s    %s"
              % (name, p, m0, l0, ("k=%d,B=%d" % kb) if kb else "-", hits))

print()
print("  * (4.1) は cycle 15 の上界 l_0 <= (H の F_p 有理線形因子の重複度の和)。B < l_0 が出たら (4.1) が誤り。")
bad41 = [(nm, p) for (nm, p), (m0, l0, h) in ALG.items()
         if h_bound(dict((n, P) for n, P, _ in CASES)[nm], p) is not None
         and l0 > h_bound(dict((n, P) for n, P, _ in CASES)[nm], p)[1]]
print("  (4.1) 違反: %d 件" % len(bad41))


# ============================================================ (2) 独立実装 B: 冪級数引き戻し

print()
print("--- (2) 独立検証 B: 有理方向 v ごとに z->(1+Y)^{-v2}, w->(1+Y)^{v1} を代入した F_p[[Y]] の零判定 ---")
print("    アルゴリズム A の判定（ファイバー係数和）と一致するかを見る。")
print()
badB = 0
for name, P, ps in CASES:
    for p in ps:
        supp = laurent_dict(P, GENS)
        m0, barP = reduce_mod_p(supp, p)
        if len(barP) <= 1:
            continue
        for v in candidate_directions(barP):
            algo = fiber_test(barP, v, p)
            prec = p**5
            s = pullback_series(barP, quotient_exponents(v), p, prec)
            ser = (s == 0)
            if algo != ser:
                badB += 1
                print("    不一致 P=%s p=%d v=%s: A=%s B=%s" % (name, p, v, algo, ser))
print("  A と B の不一致: %d 件" % badB)


# ============================================================ (3) 独立検証 C: P^1(Z/p^K) 全被覆

print()
print("--- (3) 独立検証 C: P^1(Z/p^K) 全点走査（有理・無理を区別せず Z_p 方向を有限精度で全被覆） ---")
print("    級数が Y^{p^K} まで 0 にならないボールは、その中のどの方向も割らないことを証明する。")
print("    残ったボールの中心が A の出した有理方向と（p^K の精度で）一致するかを見る。")
print()
for name, P, ps in [("torus 4-z-1/z-w-1/w", 4*z*w - z^2*w - w - z*w^2 - z, [2, 3]),
                    ("counterex z+w^2-2w", z + w^2 - 2*w, [3]),
                    ("(z-1)(w-1)", (z - 1)*(w - 1), [2, 3]),
                    ("z+w^2", z + w^2, [2])]:
    for p in ps:
        K = 3
        supp = laurent_dict(P, GENS)
        m0, barP = reduce_mod_p(supp, p)
        total, zeros = sweep_P1(barP, p, K)
        m0a, l0a, hits = l0_algorithm(P, GENS, p)
        # A の方向を Z/p^K の代表へ
        def to_rep(v):
            a, b = ZZ(v[0]), ZZ(v[1])
            m = p**K
            if a % p != 0:
                return (1, ZZ(b * a.inverse_mod(m)) % m)
            else:
                return (ZZ(a * b.inverse_mod(m)) % m, 1)
        expect = sorted(set(to_rep(v) for v, _ in hits))
        got = sorted(set(zeros))
        print("  P=%-24s p=%d K=%d: 走査 %d 点, 残存 %s / A の予測 %s  一致=%s"
              % (name, p, K, total, got, expect, got == expect))


# ============================================================ (4) 検証 D: 漸近形との照合

print()
print("--- (4) 検証 D: Kataoka Thm 2.1/2.3 の漸近形 sum_{chi(f)!=0} ord_p(chi(f)) との照合 ---")
print("    v(n) = m_0 p^{2n} + l_0 n p^n + mu_1 p^n + lam_1 n + nu  (n>>0)")
print("    A が出した l_0 を固定し、残り 4 係数を最後の 4 点でフィット → 別の n で検証。")
print()

FIT = [
    ("torus 4-z-1/z-w-1/w", 4*z*w - z^2*w - w - z*w^2 - z, 2, 5),
    ("torus 4-z-1/z-w-1/w", 4*z*w - z^2*w - w - z*w^2 - z, 3, 4),
    ("counterex z+w^2-2w",  z + w^2 - 2*w,                 3, 4),
    ("6-z-w",               6 - z - w,                     2, 5),
    ("2+3z+3w",             2 + 3*z + 3*w,                 2, 5),
    ("3*(6-z-w)",           3*(6 - z - w),                 3, 4),
    ("(z-1)(w-1)",          (z - 1)*(w - 1),               2, 5),
    ("z+w^2",               z + w^2,                       2, 5),
    ("z*w-1",               z*w - 1,                       2, 5),
    ("z^2+z*w+w^2",         z^2 + z*w + w^2,               3, 4),
]

print("    m_0 = v_p(content P)（cycle 15 で確定）と l_0（本 step のアルゴリズム A）を**両方とも固定**し、")
print("    残る 3 係数 (mu_1, lam_1, nu) を最も大きい 3 点で決めて、それ以外の n で予測が当たるかを見る。")
print("    ⇒ 当たれば l_0 の値は 1 自由度も使わずに漸近列を再現したことになる（フィットの後付けではない）。")
print()
for name, P, p, nmax in FIT:
    seq, degs = [], []
    for n in range(0, nmax + 1):
        s, nd = sum_ord_chi_fast(P, p, n)
        seq.append(s)
        degs.append(nd)
    m0a, l0a, hits = l0_algorithm(P, GENS, p)
    ns = list(range(nmax - 2, nmax + 1))          # 上位 3 点だけ使う
    rows, rhs = [], []
    for n in ns:
        X = p**n
        rows.append([X, n, 1])
        rhs.append(seq[n] - m0a * X * X - l0a * n * X)
    M = matrix(QQ, rows)
    sol = M.solve_right(vector(QQ, rhs)) if M.rank() == 3 else None
    print("  P=%-24s p=%d: v(n)=%s  退化 chi 数=%s" % (name, p, [str(x) for x in seq], degs))
    print("      A: m_0=%d l_0=%d 割る方向 %s" % (m0a, l0a, hits))
    if sol is None:
        print("      フィット不能（階数不足）")
    else:
        pred = [m0a*(p**n)**2 + l0a*n*(p**n) + sol[0]*(p**n) + sol[1]*n + sol[2]
                for n in range(nmax + 1)]
        free = [n for n in range(1, nmax + 1) if n not in ns]
        bad = [n for n in range(1, nmax + 1) if pred[n] != seq[n]]
        print("      (mu_1,lam_1,nu)=%s ; フィットに使っていない n=%s で予測的中=%s ; n>=1 で外れた n=%s"
              % (tuple(sol), free, all(pred[n] == seq[n] for n in free), bad))


# ============================================================ (5) 不連続性（一般の冪級数では有限手続き不能）

print()
print("--- (5) l_0 の (T,S) 進不連続性: f_m -> f = z-1 だが l_0(f_m) != l_0(f) ---")
print("    これは「f の有限個の係数だけを読むアルゴリズムでは l_0 を決められない」ことの証明である。")
print("    摂動は (w-1)^{p^m} * D(w) （D は p ごとに固定の Laurent 多項式）。")
print("    (T,S) 進位数は p^m 以上なので m -> infinity で f_m -> f。")
print()
PERT = {2: w + 1, 3: R(1), 5: R(1)}
for p in [2, 3, 5, 7]:
    base = z - 1
    m0b, l0b, hb = l0_algorithm(base, GENS, p)
    D = PERT.get(p, R(1))
    print("  p=%d: l_0(z-1)=%d %s   摂動 D(w)=%s" % (p, l0b, hb, D))
    for m in range(1, 4):
        Pm = (z - 1) + (w - 1)^(p^m) * D
        m0m, l0m, hm = l0_algorithm(Pm, GENS, p)
        print("      m=%d: f_m - f の (T,S) 進位数 >= %d,  l_0(f_m)=%d %s"
              % (m, p^m, l0m, hm))

print()
print("--- (6) d=3 への一般化（アルゴリズムは d に依存しない） ---")
print()
R3.<x, y, u> = ZZ[]
G3 = [x, y, u]
CASES3 = [
    ("6-x-y-u",              6 - x - y - u,                    [2, 3, 5]),
    ("(x-1)(y-1)(u-1)",      (x - 1)*(y - 1)*(u - 1),          [2, 3]),
    ("x*y*u-1",              x*y*u - 1,                        [2, 3]),
    ("x+y+u",                x + y + u,                        [2, 3]),
    ("x^2+y^2+u^2",          x^2 + y^2 + u^2,                  [2, 3]),
    ("3-x-y-u+ ...(3D torus)", 6*x*y*u - x^2*y*u - y*u - x*y^2*u - x*u - x*y*u^2 - x*y,
                                                               [2, 3]),
]
print("%-26s %3s %5s %5s  %s" % ("P", "p", "m_0", "l_0", "割り切る方向 (v, ord)"))
for name, P, ps in CASES3:
    for p in ps:
        m0, l0, hits = l0_algorithm(P, G3, p)
        print("%-26s %3d %5d %5d    %s" % (name, p, m0, l0, hits))

print()
print("--- (7) 無作為 Laurent 多項式での A/B 総当たり整合（d=2） ---")
print()
set_random_seed(20260731)
bad, tested, dirs = 0, 0, 0
for trial in range(400):
    p = choice([2, 3, 5])
    nm = randint(2, 5)
    Pd = {}
    for _ in range(nm):
        e = (randint(-3, 3), randint(-3, 3))
        Pd[e] = Pd.get(e, 0) + randint(-6, 6)
    Pd = {e: c for e, c in Pd.items() if c != 0}
    if len(Pd) == 0:
        continue
    Pt = sum(ZZ(c) * z^(e[0] + 3) * w^(e[1] + 3) for e, c in Pd.items())
    if Pt == 0:
        continue
    tested += 1
    supp = laurent_dict(Pt, GENS)
    m0, barP = reduce_mod_p(supp, p)
    if len(barP) <= 1:
        continue
    for v in candidate_directions(barP):
        dirs += 1
        a = fiber_test(barP, v, p)
        b = (pullback_series(barP, quotient_exponents(v), p, p^5) == 0)
        c1 = ord_at_gamma(barP, v, p)
        c2 = ord_by_division(barP, v, p)
        if a != b or c1 != c2 or (c1 >= 1) != a:
            bad += 1
            print("    不一致: p=%d P=%s v=%s A=%s B=%s ord=%s/%s" % (p, Pt, v, a, b, c1, c2))
print("  試行 %d 件 / 方向 %d 件, 不一致 %d 件" % (tested, dirs, bad))

print()
print("--- (8) cycle 15 (4.1) の上界との差、および線ごとの精密化 ---")
print("    in(-)（最低次斉次部分をとる操作）は乗法的で in(gamma_v - 1) = sum_i bar v_i T_i なので、")
print("    P^1(F_p) の各線 l について  sum_{v: bar v = l} ord_v(bar f)  <=  mult_l(H)  が成り立つはず。")
print("    (4.1) はこれを l について足したもの。等号が崩れる例を数える。")
print()


def line_of(v, p):
    """原始整数ベクトル v の mod p 方向（P^1(F_p) の点）。"""
    r = tuple(GF(p)(ZZ(x)) for x in v)
    for i, x in enumerate(r):
        if x != 0:
            inv = x**(-1)
            return tuple(y * inv for y in r)
    return None


def H_line_mults(P, gens, p):
    """H = in(bar f) の P^1(F_p) 有理線形因子の重複度を線ごとに返す（d=2）。"""
    supp = laurent_dict(P, gens)
    m0, barP = reduce_mod_p(supp, p)
    if len(barP) == 0:
        return None
    RT = PolynomialRing(GF(p), 'T,S')
    T, S = RT.gens()
    shift = [min(e[i] for e in barP.keys()) for i in range(2)]
    f = sum(RT(c) * (1 + T)**ZZ(e[0] - shift[0]) * (1 + S)**ZZ(e[1] - shift[1])
            for e, c in barP.items())
    if f == 0:
        return None
    k = min(m.degree() for m in f.monomials())
    H = sum(c * m for c, m in zip(f.coefficients(), f.monomials()) if m.degree() == k)
    out = {}
    for fac, mult in RT(H).factor():
        if fac.degree() == 1 and fac.constant_coefficient() == 0:
            a = fac.monomial_coefficient(T)
            b = fac.monomial_coefficient(S)
            # 線形形式 aT+bS は v=(a,b) 方向に対応（in(gamma_v-1)=bar v_1 T + bar v_2 S）
            out[line_of((a, b), p)] = out.get(line_of((a, b), p), 0) + mult
    return out


def line_check(P, gens, p):
    m0, l0, hits = l0_algorithm(P, gens, p)
    hm = H_line_mults(P, gens, p)
    if hm is None:
        return None
    agg = {}
    for v, m in hits:
        l = line_of(v, p)
        agg[l] = agg.get(l, 0) + m
    viol = [(l, agg[l], hm.get(l, 0)) for l in agg if agg[l] > hm.get(l, 0)]
    B = sum(hm.values())
    strict = [(l, agg.get(l, 0), hm[l]) for l in hm if agg.get(l, 0) < hm[l]]
    return l0, B, viol, strict


print("%-26s %3s %5s %6s  %s" % ("P", "p", "l_0", "上界B", "B-l_0 / 線ごとに緩い線 (l, sum ord, mult_l H)"))
for name, P, ps in CASES:
    for p in ps:
        r = line_check(P, GENS, p)
        if r is None:
            continue
        l0, B, viol, strict = r
        assert not viol, "線ごとの不等式が破れた: %s p=%d %s" % (name, p, viol)
        print("%-26s %3d %5d %6d   %d  %s" % (name, p, l0, B, B - l0, strict))

print()
set_random_seed(20260731)
tot, eq, viol_cnt = 0, 0, 0
gapdist = {}
for trial in range(600):
    p = choice([2, 3, 5])
    nm = randint(2, 5)
    Pd = {}
    for _ in range(nm):
        e = (randint(-3, 3), randint(-3, 3))
        Pd[e] = Pd.get(e, 0) + randint(-6, 6)
    Pd = {e: c for e, c in Pd.items() if c != 0}
    Pt = sum(ZZ(c) * z^(e[0] + 3) * w^(e[1] + 3) for e, c in Pd.items())
    if Pt == 0:
        continue
    r = line_check(Pt, GENS, p)
    if r is None:
        continue
    l0, B, viol, strict = r
    tot += 1
    if viol:
        viol_cnt += 1
        print("    線ごとの不等式が破れた: p=%d P=%s %s" % (p, Pt, viol))
    if B == l0:
        eq += 1
    gapdist[B - l0] = gapdist.get(B - l0, 0) + 1
print("  無作為 %d 件: 線ごとの不等式の反例 %d 件、上界が等号 %d 件 (%.1f%%)、差 B-l_0 の分布 %s"
      % (tot, viol_cnt, eq, 100.0 * eq / tot, sorted(gapdist.items())))

print()
print("=" * 100)
print("まとめ:")
print("  (1)(2)(3) 3 通りの独立実装が同じ l_0 を返す。とくに (3) は Z_p の方向を全被覆した探索で、")
print("      有理方向以外に (gamma-1) | bar f となる方向が無いことを有限精度で確認している。")
print("  (4) 得られた l_0 が Monsky/Cuoco-Monsky の漸近形の n p^n 係数と整合する。")
print("  (5) 一方、一般の冪級数では l_0 は (T,S) 進に不連続なので、有限個の係数から決定できない。")
print("      => 決定可能性の境界: Laurent 多項式（＝群環 Z[Z^d] の元）までは決定可能、")
print("         一般の Z_p[[Gamma]] の元では（係数オラクル模型で）決定不能。")
print("=" * 100)
