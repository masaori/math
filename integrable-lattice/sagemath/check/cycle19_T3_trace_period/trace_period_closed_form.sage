# cycle 19 / step 3 (T3 Pure): pi_tr(p,k) の閉形式・w* の代数的記述・予想 A の決着
#
# 記号は cycle 18 step 2（sagemath/check/cycle18_T3_trace_period/）を継承する:
#   T in M_d(ZZ), p 素数, p ∤ det T
#   P_k(A) = pi(p,k;A) = GL_d(ZZ/p^k) での A の位数（行列冪列の周期）
#   t_k    = pi_tr(p,k) = トレース列 (Tr T^N mod p^k)_N の周期
#   chi = charpoly(T), rho = rad(chi), r = deg rho, S = ⊕_i C_{f_i}^{⊕ a_i}
#   G = (Tr T^{i+j})_{0<=i,j<r},  w* = v_p(G の最大単因子)
#
# 本 step で新たに導入する量:
#   eta   = (chi' / (chi/rho))(theta) in A = ZZ[x]/(rho)     （定理 W）
#   tau   = P_1(S)
#   g_m   = min_{0<=N<r} v_p( Tr(S^N (S^{p^m tau} - I)) )     （トレース水準）
#   e_k   = log_p( t_k / tau )   （k > w* で well-defined。cycle 18 系 11）
#
# 検証する主張（証明本体: outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md）:
#   [W1] w* = min{ j>=0 : p^j * eta^{-1} in ZZ[theta] }                （定理 W。**証明済み**）
#   [W2] det G = ± N_{A/QQ}(eta)                                        （定理 W の系。**証明済み**）
#   [W3] ZZ[theta] が p 極大かつ rho 既約なら w* = max_{P|p} ceil(v_P(eta)/e_P)   （系 W2。**証明済み**）
#   [Y1] k >= w*+1 ⇒ t_{k+1} | p t_k                                    （定理 A′。**証明した**＝cycle 18 予想 A）
#   [Y2] t_k | p^{max(k-w*-1,0)} t_{w*+1}                               （系 A″＝改良主定理。**証明済み**）
#   [Y3] t_k | p^{max(k-w*-2,0)} t_{w*+1}                               （**偽であるべき**＝Y2 の指数の sharpness）
#   [Y4] k > w* ⇒ e_k = min{ m : g_m >= k }                             （構造定理。**証明済み**）
#   [Y5] g_m >= w*+1 ⇒ g_{m+1} >= g_m + 1                               （定理 A′ の心臓部。**証明済み**）
#   [Y6] g_{m+1} >= min(g_m + 1, 2 g_m - w*)                            （精密版。**証明済み**）
#   [Y7] e_k = max(0, k - g_0)  (k > w*)                                （**偽であるべき**＝閉形式の不存在）
#   [Y8] g_m = g_0 + m                                                   （**偽であるべき**＝Wall 型等式のトレース版）
#
# 「偽であるべき」= 反例が出ることが本 step の結論（閉形式が存在しないことの根拠）。
#
# 実行: sage trace_period_closed_form.sage    （出力は trace_period_closed_form.out）

KMAX = 6      # t_k を測る最大レベル
MMAX = 6      # g_m を測る最大 m
KG = 30       # g_m の測定水準（g_m >= KG は cap 扱い）。KG >> KMAX なので
              # レベル k<=KMAX の主張は cap があっても一意に決まる（undecided は生じない）


def pval(n, p):
    return Infinity if n == 0 else ZZ(n).valuation(p)


def rad(chi):
    return prod([f for (f, a) in chi.factor()])


def semisimple_model(T):
    """S = ⊕_i companion(f_i)^{⊕ a_i}（chi_T = Π f_i^{a_i}）と rho = Π f_i を返す。"""
    chi = T.charpoly()
    fac = list(chi.factor())
    blocks = []
    rho = chi.parent().one()
    for (f, a) in fac:
        rho = rho * f
        C = companion_matrix(f, format='bottom')
        for _ in range(a):
            blocks.append(matrix(ZZ, C))
    return matrix(ZZ, block_diagonal_matrix(blocks)), rho, fac


def eta_polynomial(chi, rho):
    """eta = chi' / (chi/rho) in ZZ[x]（多項式として整。定理 W の証明を見よ）。"""
    h = chi // rho
    num = chi.derivative()
    q, rem = num.quo_rem(h)
    if rem != 0:
        raise RuntimeError("chi'/(chi/rho) が整でない（定理 W の証明に反する）")
    return q


def mult_matrix(elt_poly, rho):
    """A = QQ[x]/(rho) 上の「eta 倍」写像の行列（基底 1, theta, ..., theta^{r-1}）。"""
    r = rho.degree()
    Q = PolynomialRing(QQ, 'x')
    A = Q.quotient(Q(rho), 'th')
    e = A(Q(elt_poly))
    cols = [list((e * A(Q.gen() ** j)).lift().padded_list(r)) for j in range(r)]
    return matrix(QQ, cols).transpose()


def wstar_via_eta(chi, rho, p):
    """[W1] の右辺: min{ j : p^j / eta in ZZ[theta] }。
    p^j/eta in A ⟺ M^{-1} e_1 の各成分の分母の p 冪が p^j 以下。"""
    eta = eta_polynomial(chi, rho)
    r = rho.degree()
    M = mult_matrix(eta, rho)
    y = M.solve_right(vector(QQ, [1] + [0] * (r - 1)))
    return max([ZZ(c.denominator()).valuation(p) for c in y])


def eta_norm(chi, rho):
    """N_{A/QQ}(eta) = det(eta 倍の行列)。"""
    return ZZ(mult_matrix(eta_polynomial(chi, rho), rho).det())


def matrix_period(A, p, k, P1):
    R = Zmod(p ** k)
    M = matrix(R, A)
    I = identity_matrix(R, A.nrows())
    for j in range(k):
        if M ** (p ** j * P1) == I:
            return ZZ(p ** j * P1)
    raise RuntimeError("P_k not found")


def trace_period(T, p, k, period, rcheck):
    """t_k。minpoly(T) がモニック次数 rcheck なので N=0..rcheck-1 の検査で必要十分。"""
    R = Zmod(p ** k)
    M = matrix(R, T)
    pows = [identity_matrix(R, T.nrows())]
    for _ in range(rcheck):
        pows.append(pows[-1] * M)
    for t in sorted(ZZ(period).divisors()):
        Mt = M ** t
        if all((pows[N] * Mt).trace() == pows[N].trace() for N in range(rcheck)):
            return ZZ(t)
    raise RuntimeError("t_k not found")


def trace_levels(S, p, tau, r, mmax=MMAX, kg=KG):
    """g_m = min_{0<=N<r} v_p( Tr(S^N (S^{p^m tau} - I)) )。kg で打ち切る。
    戻り値は (g_list, truncated_count)。"""
    R = Zmod(p ** kg)
    M = matrix(R, S)
    I = identity_matrix(R, S.nrows())
    pows = [I]
    for _ in range(r):
        pows.append(pows[-1] * M)
    g = []
    trunc = 0
    for m in range(mmax + 1):
        B = M ** (p ** m * tau) - I
        vals = []
        for N in range(r):
            z = ZZ((pows[N] * B).trace().lift())
            vals.append(kg if z == 0 else min(kg, ZZ(z).valuation(p)))
        gm = min(vals)
        if gm >= kg:
            trunc += 1
        g.append(gm)
    return g, trunc


def analyse(T, p, kmax=KMAX):
    if T.det() % p == 0:
        return None
    S, rho, fac = semisimple_model(T)
    chi = T.charpoly()
    r = rho.degree()
    rcheck = T.minpoly().degree()
    G = matrix(ZZ, r, r, lambda i, j: (T ** (i + j)).trace())
    Delta = G.det()
    if Delta == 0:
        raise RuntimeError("det G = 0")
    wstar = pval(G.elementary_divisors()[-1], p)
    tau = ZZ(matrix(GF(p), S).multiplicative_order())
    PS, t = {}, {}
    for k in range(1, kmax + 1):
        PS[k] = matrix_period(S, p, k, tau)
        t[k] = trace_period(T, p, k, PS[k], rcheck)
    g, trunc = trace_levels(S, p, tau, r)
    return dict(T=T, S=S, p=p, d=T.nrows(), r=r, chi=chi, rho=rho, fac=fac,
                G=G, Delta=Delta, wstar=wstar, tau=tau, PS=PS, t=t, g=g,
                trunc=trunc, kmax=kmax)


HYPS = ["W1", "W2", "W3", "Y1", "Y2", "Y3", "Y4", "Y5", "Y6", "Y7", "Y8"]
FALSE_EXPECTED = {"Y3", "Y7", "Y8"}

# Y8（Wall 型等式のトレース列版）が破れた (p, r) の分布。閉形式の障害がどこに住むかを測る。
Y8_BREAKDOWN = {}
Y8_TESTED = {}


def check(rec, fails, tested, nontrivial):
    p, ws, t, g, tau, K = rec['p'], rec['wstar'], rec['t'], rec['g'], rec['tau'], rec['kmax']
    out = []

    def rep(name, ok, note, nt=False):
        tested[name] += 1
        if nt:
            nontrivial[name] += 1
        if not ok:
            fails[name] += 1
            out.append((name, note))

    # --- w* の代数的閉形式 -------------------------------------------------
    rep("W1", rec['wstar'] == wstar_via_eta(rec['chi'], rec['rho'], p),
        f"w*={ws}, eta 版={wstar_via_eta(rec['chi'], rec['rho'], p)}", nt=(ws > 0))
    rep("W2", abs(rec['Delta']) == abs(eta_norm(rec['chi'], rec['rho'])),
        f"detG={rec['Delta']}, N(eta)={eta_norm(rec['chi'], rec['rho'])}", nt=True)
    if len(rec['fac']) == 1:
        f0, a0 = rec['fac'][0]
        if f0.degree() >= 1:
            K_ = NumberField(f0, 'a')
            # disc(f) = [O_K : ZZ[theta]]^2 * disc(K) なので、p 極大 ⟺ p ∤ disc(f)/disc(K)
            idx2 = ZZ(f0.discriminant() / K_.discriminant())
            if idx2 % p != 0:                     # ZZ[theta] が p 極大
                eta = eta_polynomial(rec['chi'], rec['rho'])
                th = K_.gen()
                ev = eta(th)
                if ev != 0:
                    pred = max([ceil(K_.ideal(ev).valuation(P) / P.ramification_index())
                                for P in K_.primes_above(p)])
                    rep("W3", ws == pred, f"w*={ws}, ramification 版={pred}", nt=(ws > 0))

    # --- 周期の階段と改良主定理 -------------------------------------------
    for k in range(1, K):
        if k >= ws + 1:
            rep("Y1", (p * t[k]) % t[k + 1] == 0,
                f"k={k},w*={ws}: t_k={t[k]}, t_(k+1)={t[k+1]}", nt=True)
    if ws + 1 <= K:
        for k in range(1, K + 1):
            b2 = p ** max(k - ws - 1, 0) * t[ws + 1]
            rep("Y2", b2 % t[k] == 0, f"k={k},w*={ws}: t_k={t[k]}, bound={b2}",
                nt=(k > ws + 1))
            b3 = p ** max(k - ws - 2, 0) * t[ws + 1]
            rep("Y3", b3 % t[k] == 0, f"k={k},w*={ws}: t_k={t[k]}, bound={b3}",
                nt=(k > ws + 1))

    # --- g_m と e_k の構造 -------------------------------------------------
    for k in range(ws + 1, K + 1):
        ek = pval(t[k] // tau, p) if t[k] % tau == 0 else None
        if ek is None:
            rep("Y4", False, f"k={k}: tau={tau} ∤ t_k={t[k]}", nt=True)
            continue
        cand = [m for m in range(len(g)) if g[m] >= k]
        if not cand:
            continue                              # MMAX の範囲で未達（打ち切り）
        rep("Y4", ek == cand[0], f"k={k}: e_k={ek}, min{{m:g_m>=k}}={cand[0]}", nt=True)
        rep("Y7", ek == max(0, k - g[0]), f"k={k}: e_k={ek}, max(0,k-g_0)={max(0, k - g[0])}",
            nt=True)
    for m in range(len(g) - 1):
        if g[m] >= KG:
            continue
        if g[m] >= ws + 1:
            rep("Y5", g[m + 1] >= g[m] + 1, f"m={m},w*={ws}: g_m={g[m]}, g_(m+1)={g[m+1]}", nt=True)
        rep("Y6", g[m + 1] >= min(g[m] + 1, 2 * g[m] - ws),
            f"m={m},w*={ws}: g_m={g[m]}, g_(m+1)={g[m+1]}", nt=True)
        Y8_TESTED[p] = Y8_TESTED.get(p, 0) + 1
        if g[m + 1] != g[0] + m + 1:
            key = (p, rec['r'])
            Y8_BREAKDOWN[key] = Y8_BREAKDOWN.get(key, 0) + 1
        rep("Y8", g[m + 1] == g[0] + m + 1, f"m={m}: g={g[:m+2]}", nt=True)
    return out


def run(name, samples, show_examples=3, kmax=KMAX):
    fails = {h: 0 for h in HYPS}
    tested = {h: 0 for h in HYPS}
    nontrivial = {h: 0 for h in HYPS}
    examples = {h: [] for h in HYPS}
    n = 0
    trunc_total = 0
    wshist = {}
    ghist = {}
    recs = []
    for T, p in samples:
        rec = analyse(T, p, kmax)
        if rec is None:
            continue
        n += 1
        recs.append(rec)
        trunc_total += rec['trunc']
        wshist[rec['wstar']] = wshist.get(rec['wstar'], 0) + 1
        ghist[rec['g'][0]] = ghist.get(rec['g'][0], 0) + 1
        for (h, note) in check(rec, fails, tested, nontrivial):
            if len(examples[h]) < show_examples:
                examples[h].append((rec, note))
    print("=" * 78)
    print(f"[{name}]  検査した (T,p) 組: {n}   （k = 1..{kmax}, m = 0..{MMAX}）")
    print(f"  w* の分布: {dict(sorted(wshist.items()))}")
    print(f"  g_0 の分布: {dict(sorted(ghist.items()))}")
    print(f"  g_m の cap（g_m >= {KG}。トレース列が p^m tau で完全周期の場合。KG={KG} > KMAX={kmax}\n    なので k<=KMAX の主張はいずれも決定済み＝undecided 0）: {trunc_total} 件")
    print(f"  {'仮説':<6}{'検査数':>8}{'非自明':>8}{'反例':>8}   判定")
    for h in HYPS:
        if tested[h] == 0:
            print(f"  {h:<5}{'-':>8}{'-':>8}{'-':>8}   （検査対象なし）")
            continue
        if h in FALSE_EXPECTED:
            verdict = ("**反例なし（閉形式の不存在の根拠が出ていない）**" if fails[h] == 0
                       else f"反例 {fails[h]} 件（期待どおり）")
        else:
            verdict = "反例なし" if fails[h] == 0 else f"**反例 {fails[h]} 件（証明済みなので異常）**"
        print(f"  {h:<5}{tested[h]:>8}{nontrivial[h]:>8}{fails[h]:>8}   {verdict}")
    for h in HYPS:
        if examples[h]:
            print(f"  -- {h} の反例（先頭 {len(examples[h])} 件）")
            for (rec, note) in examples[h]:
                print(f"     T={rec['T'].rows()}, p={rec['p']}, w*={rec['wstar']}, {note}")
                print(f"       t={[rec['t'][k] for k in range(1, kmax + 1)]}, "
                      f"tau={rec['tau']}, g={rec['g']}")
    return dict(n=n, fails=fails, tested=tested, nontrivial=nontrivial,
                recs=recs, trunc=trunc_total)


# ---------------------------------------------------------------- 標本の生成
def random_samples(count, seed, ds=(2, 3, 4), ps=(2, 3, 5), bound=3):
    set_random_seed(seed)
    out = []
    for _ in range(count):
        d = ds[randint(0, len(ds) - 1)]
        p = ps[randint(0, len(ps) - 1)]
        out.append((matrix(ZZ, d, d, [randint(-bound, bound) for _ in range(d * d)]), p))
    return out


def degenerate_samples(count, seed, ps=(2, 3, 5)):
    set_random_seed(seed)
    out = []
    for _ in range(count):
        p = ps[randint(0, len(ps) - 1)]
        kind = randint(0, 2)
        d0 = 1 + randint(0, 1)
        A = matrix(ZZ, d0, d0, [randint(-3, 3) for _ in range(d0 * d0)])
        if kind == 0:
            T = block_diagonal_matrix(A, A)
        elif kind == 1:
            B = matrix(ZZ, 1, 1, [randint(-3, 3)])
            T = block_diagonal_matrix(A, A, B)
        else:
            n = A.nrows()
            J = block_diagonal_matrix(A, A)
            J[0, n] = 1
            T = J
        out.append((matrix(ZZ, T), p))
    return out


def scalar_samples():
    """(i) の反例族: 1x1（＝スカラー）。p=2 では v_2(c^{2^m}-1) が m=0→1 で 2 段跳ぶ。"""
    out = []
    for c in [3, 5, 7, 9, 11, 13, 15, -3, -5, 17, 19, 21]:
        out.append((matrix(ZZ, [[c]]), 2))
    for c in [2, 4, 5, 7, 8, 10, 11, 13, 14]:
        out.append((matrix(ZZ, [[c]]), 3))
        out.append((matrix(ZZ, [[c]]), 5))
    return out


F = matrix(ZZ, [[0, 1], [1, 1]])
NAMED = [
    (matrix(ZZ, block_diagonal_matrix(F, F)), 2),        # cycle 18 命題 12 の反例（w*=1）
    (F, 2),                                              # 対照（w*=0）
    (F, 5),                                              # 対照（w*=1, 分岐）
    (matrix(ZZ, [[1, 1], [0, 1]]), 2),                   # 非半単純
    (matrix(ZZ, [[3]]), 2),                              # **(i) の反例**: e_k が k-g_0 にならない
    (matrix(ZZ, [[1, 1, -1], [2, 1, -2], [-2, -1, -1]]), 2),
    (matrix(ZZ, [[2, -1, 2], [-3, -3, -2], [-1, -2, -2]]), 3),
    (matrix(ZZ, [[-3, -2, -1], [3, -3, -2], [2, 2, -1]]), 2),
]

print("#" * 78)
print(f"# cycle 19 step 3: pi_tr(p,k) の閉形式・w* の代数的記述・予想 A の決着")
print("#" * 78)
print()
print("=" * 78)
print("[named] 主要例の詳細（w* の 2 つの計算法・g_m・e_k）")
print("=" * 78)
for (T, p) in NAMED:
    rec = analyse(T, p)
    ws, t, g, tau = rec['wstar'], rec['t'], rec['g'], rec['tau']
    eta = eta_polynomial(rec['chi'], rec['rho'])
    print(f"  T={T.rows()}, p={p}")
    print(f"    chi={rec['chi']}, rho={rec['rho']}, eta={eta}")
    print(f"    det G={rec['Delta']}, N(eta)={eta_norm(rec['chi'], rec['rho'])}, "
          f"w*(Smith)={ws}, w*(eta)={wstar_via_eta(rec['chi'], rec['rho'], p)}")
    print(f"    tau=P_1(S)={tau},  t_k={[t[k] for k in range(1, KMAX + 1)]}")
    print(f"    g_m={g}   (m=0..{MMAX}, 打ち切り水準 {KG})")
    ek = [(pval(t[k] // tau, p) if t[k] % tau == 0 else None) for k in range(1, KMAX + 1)]
    print(f"    e_k={ek}  /  max(0,k-g_0)={[max(0, k - g[0]) for k in range(1, KMAX + 1)]}"
          f"  /  k-1={[k - 1 for k in range(1, KMAX + 1)]}")
    print(f"    [Y2] 改良主定理 p^max(k-w*-1,0) t_(w*+1) で押さえられるか: "
          f"{[bool((p ** max(k - ws - 1, 0) * t[ws + 1]) % t[k] == 0) for k in range(1, KMAX + 1)] if ws + 1 <= KMAX else 'n/a'}")
print()

r0 = run("named+scalar", NAMED + scalar_samples())
print()
r1 = run("random", random_samples(700, 20260731))
print()
r2 = run("degenerate-enriched", degenerate_samples(900, 991))
print()
print("=" * 78)
print("[summary] 全標本まとめ")
print("=" * 78)
print(f"  {'仮説':<5}{'検査数':>8}{'非自明':>8}{'反例':>8}   期待")
TOT = {}
for h in HYPS:
    tot = r0['tested'][h] + r1['tested'][h] + r2['tested'][h]
    nt = r0['nontrivial'][h] + r1['nontrivial'][h] + r2['nontrivial'][h]
    f = r0['fails'][h] + r1['fails'][h] + r2['fails'][h]
    TOT[h] = (tot, nt, f)
    exp = "反例が出るべき" if h in FALSE_EXPECTED else "反例 0（証明済み）"
    print(f"  {h:<5}{tot:>8}{nt:>8}{f:>8}   {exp}")
print(f"  g_m の cap 合計: {r0['trunc'] + r1['trunc'] + r2['trunc']} 件（undecided ではない。上記参照）")
bad = [h for h in HYPS if h not in FALSE_EXPECTED and TOT[h][2] > 0]
missing = [h for h in HYPS if h in FALSE_EXPECTED and TOT[h][0] > 0 and TOT[h][2] == 0]
print()
print(f"  証明済み主張の反例: {sum(TOT[h][2] for h in HYPS if h not in FALSE_EXPECTED)} 件"
      f"{'（異常: ' + ','.join(bad) + '）' if bad else '  → FAIL 0'}")
print(f"  偽であるべき主張で反例が出なかったもの: {missing if missing else 'なし'}")
print()
print(f"  [Y8 の反例の分布] (p, r=deg rho) -> 件数: "
      f"{dict(sorted(Y8_BREAKDOWN.items()))}")
print(f"  [Y8 の検査数の分布] p -> 件数: {dict(sorted(Y8_TESTED.items()))}")
print("   （閉形式 g_m = g_0 + m が破れるのがどの領域かを測る。奇素数で反例 0 は")
print("     『破れない』の根拠にはならない。検出力は上の検査数から見積もること）")
print("=" * 78)
