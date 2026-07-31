# cycle 18 / step 2 (T3 Pure): トレース列の周期 pi_tr(p,k) (k>=2) の上界の検証
#
# 記号（outputs/reports/cycle17_ops_lean_propB.md §4 の使い分けに従う）:
#   T in M_d(ZZ), p 素数, p ∤ det T。
#   P_k(A) = pi(p,k;A) = 行列冪列 (A^N mod p^k)_N の（純）周期 = GL_d(ZZ/p^k) での A の位数
#   t_k    = pi_tr(p,k) = トレース列 (Tr T^N mod p^k)_N の（純）周期
#
#   chi = charpoly(T),  rho = rad(chi)（相異なる既約因子の積, ZZ[x] monic）,  r = deg rho
#   S   = ⊕_i (companion(f_i))^{⊕ a_i}    （chi = Π f_i^{a_i}）
#         → chi_S = chi, minpoly(S) = rho, Tr S^N = Tr T^N (∀N), det S = det T
#   G   = (Tr T^{i+j})_{0<=i,j<r},  Delta = det G,  v = v_p(Delta)
#   e_r = G の最大単因子（Smith 標準形の最後の対角成分）,  w* = v_p(e_r) <= v
#
# 検証する命題（証明本体: outputs/reports/cycle18_T3_trace_period_bound.md）:
#   [L]  Delta = disc(rho) * Π_lambda m_lambda   （補題 2。m_lambda = chi の根 lambda の重複度）
#   [B0] t_k | P_k(T)                            （命題 3）
#   [B1] t_k | P_k(S)                            （命題 3）
#   [B2] t_k | t_{k+1}                           （命題 4）
#   [B3] P_k(S) | p^{k-1} P_1(S)                 （命題 5 = 命題 C の行列冪列版・既知）
#   [B4] k > w* ⇒ P_{k-w*}(S) | t_k              （定理 6(i)）
#   [B5] k > w* ⇒ P_k(S) | p^{w*} t_k            （定理 6(ii)）
#   [B6] t_k | p^{k-1} t_{w*+1}                  （定理 7 = 本 step の主結果）
#   [B6d] t_k | p^{k-1} t_{v+1}                  （定理 7 の粗い版。w* <= v なので B6 から従う）
#   [B7] v = 0 ⇒ t_k = P_k(S)                    （系 8）
#   [B8] t_k | p^{k-1+ceil(log_p d)} * lcm_{1<=i<=d}(p^i - 1)   （系 9: d,p,k のみによる明示上界）
#   [X1] t_k | p^{k-1} t_1                       （素朴な持ち上げ。**偽**。cycle 17 で 3.4%）
#   [X2] t_{k+1} | p t_k                         （素朴な階段。**偽**）
#   [X3p] k >= 2w*+1 ⇒ t_{k+1} | p t_k           （定理 10。**証明済み**）
#   [X3g] w*+1 <= k <= 2w* ⇒ t_{k+1} | p t_k     （**未証明の隙間**。数値支持のみ）
#   [X2low] k <= w* ⇒ t_{k+1} | p t_k            （偽であるべき領域。X3g の偶然 0 件を見積もる物差し）
#   [X4] t_k | p^{k-1} t_{w*}  (w*>=1)           （基準レベルを 1 段下げられるか＝主結果の sharpness）
#
# 実行: sage trace_period_bounds.sage      （出力は trace_period_bounds.out）

KMAX = 6


def pval(n, p):
    return Infinity if n == 0 else ZZ(n).valuation(p)


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
    S = block_diagonal_matrix(blocks)
    return matrix(ZZ, S), rho, fac


def matrix_period(A, p, k, P1):
    """P_k(A)。P_k = p^j P_1 (0<=j<=k-1)（行列冪列版の Wall 型上界）を使う。"""
    R = Zmod(p ** k)
    M = matrix(R, A)
    I = identity_matrix(R, A.nrows())
    for j in range(k):
        if M ** (p ** j * P1) == I:
            return ZZ(p ** j * P1)
    raise RuntimeError("P_k not found (contradicts the matrix Wall bound)")


def trace_period(T, p, k, period, rcheck):
    """t_k。period は既知の周期（その約数の中に最小周期がある）。
    minpoly(T) が次数 rcheck の monic なので T^N (N>=rcheck) は I,...,T^{rcheck-1} の
    ZZ 係数一次結合。ゆえに N=0..rcheck-1 の検査で全 N について従う（有限検査で必要十分）。"""
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


def analyse(T, p, kmax=KMAX):
    if T.det() % p == 0:
        return None
    d = T.nrows()
    S, rho, fac = semisimple_model(T)
    r = rho.degree()
    rcheck = T.minpoly().degree()
    G = matrix(ZZ, r, r, lambda i, j: (T ** (i + j)).trace())
    Delta = G.det()
    if Delta == 0:
        raise RuntimeError("Gram determinant vanished (contradicts Lemma 1)")
    v = pval(Delta, p)
    wstar = pval(G.elementary_divisors()[-1], p)   # 最大単因子の p 進付値（<= v）
    # 補題 2 の検算: Delta = disc(rho) * Π_lambda m_lambda
    mprod = prod([ZZ(a) ** ZZ(f.degree()) for (f, a) in fac])
    lemma_ok = bool(Delta == rho.discriminant() * mprod)
    P1S = ZZ(matrix(GF(p), S).multiplicative_order())
    P1T = ZZ(matrix(GF(p), T).multiplicative_order())
    PS, PT, t = {}, {}, {}
    for k in range(1, kmax + 1):
        PS[k] = matrix_period(S, p, k, P1S)
        PT[k] = matrix_period(T, p, k, P1T)
        t[k] = trace_period(T, p, k, PS[k], rcheck)
    Fp = PolynomialRing(GF(p), 'x')
    sqfree = bool(Fp(T.charpoly()).is_squarefree())
    return dict(T=T, S=S, p=p, d=d, r=r, v=v, wstar=wstar, Delta=Delta, PS=PS, PT=PT, t=t,
                sqfree=sqfree, lemma_ok=lemma_ok, rho=rho, kmax=kmax)


HYPS = ["L", "B0", "B1", "B2", "B3", "B4", "B5", "B6", "B6d", "B7", "B8",
        "X1", "X2", "X2low", "X3p", "X3g", "X4"]


def explicit_bound(p, d):
    return p ** ceil(log(d, p)) * lcm([p ** i - 1 for i in range(1, d + 1)])


def check(rec, fails, tested, nontrivial):
    p, v, PS, PT, t, K = rec['p'], rec['v'], rec['PS'], rec['PT'], rec['t'], rec['kmax']
    ws = rec['wstar']
    out = []

    def rep(name, ok, note, nt=False):
        tested[name] += 1
        if nt:
            nontrivial[name] += 1
        if not ok:
            fails[name] += 1
            out.append((name, note))

    rep("L", rec['lemma_ok'], f"Delta={rec['Delta']}", nt=True)
    for k in range(1, K + 1):
        rep("B0", PT[k] % t[k] == 0, f"k={k}", nt=(t[k] != PT[k]))
        rep("B1", PS[k] % t[k] == 0, f"k={k}", nt=(t[k] != PS[k]))
        rep("B3", (p ** (k - 1) * PS[1]) % PS[k] == 0, f"k={k}")
        if k < K:
            rep("B2", t[k + 1] % t[k] == 0, f"k={k}", nt=(t[k] != t[k + 1]))
            rep("X2", (p * t[k]) % t[k + 1] == 0,
                f"k={k}: t_k={t[k]} t_(k+1)={t[k+1]}")
            ok_step = ((p * t[k]) % t[k + 1] == 0)
            if k >= 2 * ws + 1:
                rep("X3p", ok_step, f"k={k},w*={ws}: t_k={t[k]} t_(k+1)={t[k+1]}", nt=True)
            elif k >= ws + 1:
                rep("X3g", ok_step, f"k={k},w*={ws}: t_k={t[k]} t_(k+1)={t[k+1]}", nt=True)
            else:
                rep("X2low", ok_step, f"k={k},w*={ws}: t_k={t[k]} t_(k+1)={t[k+1]}", nt=True)
        if k > ws:
            rep("B4", t[k] % PS[k - ws] == 0, f"k={k}: t_k={t[k]} P_(k-w*)={PS[k-ws]}", nt=(ws > 0))
            rep("B5", (p ** ws * t[k]) % PS[k] == 0, f"k={k}", nt=(ws > 0 and t[k] != PS[k]))
        if ws + 1 <= K:
            rep("B6", (p ** (k - 1) * t[ws + 1]) % t[k] == 0,
                f"k={k}: t_k={t[k]} bound={p**(k-1)*t[ws+1]}",
                nt=(ws > 0 and (p ** (k - 1) * t[1]) % t[k] != 0))
            if ws >= 1:
                rep("X4", (p ** (k - 1) * t[ws]) % t[k] == 0,
                    f"k={k},w*={ws}: t_k={t[k]} t_w*={t[ws]}", nt=True)
        if v + 1 <= K:
            rep("B6d", (p ** (k - 1) * t[v + 1]) % t[k] == 0, f"k={k}",
                nt=(v > 0 and (p ** (k - 1) * t[1]) % t[k] != 0))
        if rec['v'] == 0:
            rep("B7", t[k] == PS[k], f"k={k}")
        rep("B8", (p ** (k - 1) * explicit_bound(p, rec['d'])) % t[k] == 0, f"k={k}")
        rep("X1", (p ** (k - 1) * t[1]) % t[k] == 0, f"k={k}: t_1={t[1]} t_k={t[k]}")
    return out


def run(name, samples, show_examples=3, kmax=KMAX):
    fails = {h: 0 for h in HYPS}
    tested = {h: 0 for h in HYPS}
    nontrivial = {h: 0 for h in HYPS}
    examples = {h: [] for h in HYPS}
    n = 0
    stats = dict(v_pos=0, sqfree=0, vhist={}, wshist={}, whist={})
    recs = []
    for T, p in samples:
        rec = analyse(T, p, kmax)
        if rec is None:
            continue
        n += 1
        recs.append(rec)
        v = rec['v']
        stats['vhist'][v] = stats['vhist'].get(v, 0) + 1
        stats['wshist'][rec['wstar']] = stats['wshist'].get(rec['wstar'], 0) + 1
        if v > 0:
            stats['v_pos'] += 1
        if rec['sqfree']:
            stats['sqfree'] += 1
        # w = min{ j>=0 : P_1(S) | t_{j+1} }（定理 3(i) は w <= v を主張する）
        w = None
        for j in range(kmax):
            if rec['t'][j + 1] % rec['PS'][1] == 0:
                w = j
                break
        stats['whist'][w] = stats['whist'].get(w, 0) + 1
        rec['w'] = w
        for (h, note) in check(rec, fails, tested, nontrivial):
            if len(examples[h]) < show_examples:
                examples[h].append((rec, note))
    print("=" * 78)
    print(f"[{name}]  検査した (T,p) 組: {n}   （k = 1..{kmax}）")
    print(f"  v = v_p(det G) の分布: {dict(sorted(stats['vhist'].items()))}")
    print(f"  w* = v_p(最大単因子) の分布: {dict(sorted(stats['wshist'].items()))}")
    print(f"  w = min{{j : P_1(S) | t_(j+1)}} の分布（None = k<={kmax} の範囲で未達）: "
          f"{sorted(stats['whist'].items(), key=lambda kv: (kv[0] is None, kv[0]))}")
    print(f"  chi mod p が squarefree: {stats['sqfree']}/{n}")
    print(f"  {'仮説':<6}{'検査数':>8}{'非自明':>8}{'反例':>8}   判定")
    for h in HYPS:
        if tested[h] == 0:
            print(f"  {h:<5}{'-':>8}{'-':>8}{'-':>8}   （検査対象なし）")
            continue
        verdict = "反例なし" if fails[h] == 0 else f"**反例 {fails[h]} 件**"
        print(f"  {h:<5}{tested[h]:>8}{nontrivial[h]:>8}{fails[h]:>8}   {verdict}")
    for h in HYPS:
        if examples[h]:
            print(f"  -- {h} の反例（先頭 {len(examples[h])} 件）")
            for (rec, note) in examples[h]:
                print(f"     T={rec['T'].rows()}, p={rec['p']}, v={rec['v']}, "
                      f"w*={rec['wstar']}, sqfree={rec['sqfree']}, {note}")
                print(f"       P_k(S)={[rec['PS'][k] for k in range(1, kmax + 1)]}, "
                      f"t={[rec['t'][k] for k in range(1, kmax + 1)]}")
    return dict(n=n, fails=fails, tested=tested, nontrivial=nontrivial, stats=stats, recs=recs)


def sharpness(recs, kmax=KMAX):
    """(1) 主結果 t_k | p^{k-1} t_{v+1} の指数 k-1 が丁度必要か。
       (2) 定理 3(i) の w <= v にどれだけ余裕があるか。"""
    print("=" * 78)
    print("[sharpness] 主結果の指数と、不変量 v の余裕")
    print("=" * 78)
    slack = {}
    vw = {}
    tight_ex = []
    for rec in recs:
        p, ws, t = rec['p'], rec['wstar'], rec['t']
        if rec['w'] is not None:
            vw[ws - rec['w']] = vw.get(ws - rec['w'], 0) + 1
        if ws + 1 > kmax:
            continue
        for k in range(ws + 1, kmax + 1):
            m = 0
            while (p ** m * t[ws + 1]) % t[k] != 0:
                m += 1
                if m > 30:
                    raise RuntimeError("no such m")
            s = (k - 1) - m
            slack[s] = slack.get(s, 0) + 1
            if s == 0 and k > ws + 1 and len(tight_ex) < 5:
                tight_ex.append((rec, k, m))
    print(f"  t_k | p^m t_(w*+1) を満たす最小 m に対する余裕 (k-1) - m の分布: {dict(sorted(slack.items()))}")
    print("   （0 = その標本で指数 k-1 が丁度必要）")
    for (rec, k, m) in tight_ex:
        print(f"   tight: T={rec['T'].rows()}, p={rec['p']}, w*={rec['wstar']}, k={k}, m={m}, "
              f"t={[rec['t'][j] for j in range(1, kmax + 1)]}")
    print(f"  w* - w の分布（w = P_1(S) を捕まえる最小レベル - 1。定理 3(i) は w*-w>=0 を主張）: "
          f"{dict(sorted(vw.items()))}")


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
    """chi mod p が非 squarefree になりやすい標本（重複ブロック・ユニポテント摂動）。
    素朴な上界が破れる領域＝主結果が非自明になる領域を厚く取る。"""
    set_random_seed(seed)
    out = []
    for _ in range(count):
        p = ps[randint(0, len(ps) - 1)]
        kind = randint(0, 2)
        d0 = 1 + randint(0, 1)
        A = matrix(ZZ, d0, d0, [randint(-3, 3) for _ in range(d0 * d0)])
        if kind == 0:                      # A ⊕ A（重複度 2）
            T = block_diagonal_matrix(A, A)
        elif kind == 1:                    # A ⊕ A ⊕ B
            B = matrix(ZZ, 1, 1, [randint(-3, 3)])
            T = block_diagonal_matrix(A, A, B)
        else:                              # 非半単純（Jordan 型の摂動）
            n = A.nrows()
            J = block_diagonal_matrix(A, A)
            J[0, n] = 1
            T = J
        out.append((matrix(ZZ, T), p))
    return out


NAMED = [
    (matrix(ZZ, [[0, 1, 0, 0], [1, 1, 0, 0], [0, 0, 0, 1], [0, 0, 1, 1]]), 2),   # cycle17 §2 反例
    (matrix(ZZ, [[1, 1, -1], [2, 1, -2], [-2, -1, -1]]), 2),                      # cycle17 §4 反例
    (matrix(ZZ, [[2, -1, 2], [-3, -3, -2], [-1, -2, -2]]), 3),                    # cycle17 §4 反例
    (matrix(ZZ, [[-3, -2, -1], [3, -3, -2], [2, 2, -1]]), 2),                     # cycle17 §4 反例
    (matrix(ZZ, [[0, 1], [1, 1]]), 2),                                            # 対照（v=0）
    (matrix(ZZ, [[0, 1], [1, 1]]), 5),                                            # 対照（v=1）
    (matrix(ZZ, [[1, 1], [0, 1]]), 2),                                            # 非半単純（ユニポテント）
]

print("#" * 78)
print(f"# cycle 18 step 2: トレース列の周期 pi_tr(p,k) の上界（k <= {KMAX}）")
print("#" * 78)
print()
print("=" * 78)
print("[named] cycle 17 が挙げた反例と対照例の詳細")
print("=" * 78)
for (T, p) in NAMED:
    rec = analyse(T, p)
    v, ws, t = rec['v'], rec['wstar'], rec['t']
    print(f"  T={T.rows()}, p={p}")
    print(f"    chi={T.charpoly()}, rho={rec['rho']}, Delta=det G={rec['Delta']}"
          f"（補題 2 の等式: {rec['lemma_ok']}）, v={v}, w*={ws}, chi mod p squarefree={rec['sqfree']}")
    print(f"    P_k(T) = {[rec['PT'][k] for k in range(1, KMAX + 1)]}")
    print(f"    P_k(S) = {[rec['PS'][k] for k in range(1, KMAX + 1)]}")
    print(f"    t_k    = {[t[k] for k in range(1, KMAX + 1)]}")
    print(f"    [X1] 素朴上界 p^(k-1) t_1 で押さえられるか: "
          f"{[bool((p ** (k - 1) * t[1]) % t[k] == 0) for k in range(1, KMAX + 1)]}")
    if ws + 1 <= KMAX:
        print(f"    [B6] 主結果 p^(k-1) t_(w*+1) で押さえられるか: "
              f"{[bool((p ** (k - 1) * t[ws + 1]) % t[k] == 0) for k in range(1, KMAX + 1)]}")
print()

S1 = random_samples(700, 20260731)
S2 = degenerate_samples(900, 991)
r1 = run("random", S1)
print()
r2 = run("degenerate-enriched", S2)
print()
sharpness(r1['recs'] + r2['recs'])
print()
print("=" * 78)
print("[summary] 全標本まとめ")
print("=" * 78)
print(f"  {'仮説':<5}{'検査数':>8}{'非自明':>8}{'反例':>8}")
for h in HYPS:
    tot = r1['tested'][h] + r2['tested'][h]
    nt = r1['nontrivial'][h] + r2['nontrivial'][h]
    f = r1['fails'][h] + r2['fails'][h]
    print(f"  {h:<5}{tot:>8}{nt:>8}{f:>8}")
print("=" * 78)
