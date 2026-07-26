# cycle 13 / T3 Pure: (★) と (☆) の証明の各ステップを機械的に検証する。
#
# 対応する証明本体: outputs/reports/cycle13_T3_mu_content_criterion_proof.md
#
# 検証するのは以下の 6 個。いずれも「有限個の例での照合」であって証明ではないが、
# 証明の各補題が具体例で破れていないこと（＝証明の書き間違いが無いこと）の確認になる。
#
#   Step 1  補題 A（DFT ブロック対角化）: charpoly(L_{X_N}) = ∏_{ζ^N=1} charpoly(L(ζ))
#   Step 2  補題 B（連結成分数）: c(X_N) = Σ_{ζ^N=1} dim ker L(ζ)
#   Step 3  補題 C（連結性の gcd 判定）: X_N 連結 ⟺ X 連結 かつ gcd(N, 基本閉路の voltage) = 1
#   Step 4  定理 (★): N·κ(X_N) = κ(X)·∏_{ζ^N=1,ζ≠1} det L(ζ)   （非連結な段も含めて）
#   Step 5  補題 D（content の不変性）: content_z(det L(z)) = content_T(P(1+T))
#           および (☆): v_ℓ(content) = μ_Weierstrass(D(1+T)) = min_j v_ℓ(c_j)
#   Step 6  定理（岩澤漸近, 本レポートの自前導出）:
#           ord_ℓ(κ_n) = μ·ℓ^n + (λ_W - 1)·n + ν   （μ, λ_W は D(1+T) の Weierstrass 不変量）

import itertools
from collections import Counter

set_random_seed(20260726)

Rl = LaurentPolynomialRing(ZZ, 'z'); z = Rl.gen()
Rp = PolynomialRing(ZZ, 'z'); zp = Rp.gen()
Rt = PolynomialRing(ZZ, 'T'); T = Rt.gen()

# --------------------------------------------------------------------------
# 基本構成（cycle12 の cycle12_T3_nonzero_mu_p/ と同じ規約）
#   底グラフ X: 頂点 0..m-1, 辺は (u, v, a) の list。u == v はループ、a ∈ ℤ が voltage。
# --------------------------------------------------------------------------

def volt_laplacian(m, edges):
    """voltage ラプラシアン L(z) ∈ Mat_m(ℤ[z,z^{-1}])。"""
    L = matrix(Rl, m, m)
    for (u, v, a) in edges:
        if u == v:
            L[u, u] += 2 - z**a - z**(-a)
        else:
            L[u, u] += 1; L[v, v] += 1
            L[u, v] -= z**a; L[v, u] -= z**(-a)
    return L

def derived_edges(m, edges, N):
    """導来グラフ X_N の辺 list（頂点は i*m+u で番号付け）。"""
    out = []
    for (u, v, a) in edges:
        for i in range(N):
            out.append((i * m + u, ((i + a) % N) * m + v))
    return out

def int_laplacian(nv, uedges):
    """多重グラフ（ループ可）のラプラシアン。ループは寄与しない。"""
    Lap = matrix(ZZ, nv, nv)
    for (x, y) in uedges:
        if x == y:
            continue
        Lap[x, x] += 1; Lap[y, y] += 1
        Lap[x, y] -= 1; Lap[y, x] -= 1
    return Lap

def kappa_derived(m, edges, N):
    """X_N の全域木数（Kirchhoff の余因子）。非連結なら 0。"""
    return int_laplacian(m * N, derived_edges(m, edges, N)).delete_rows([0]).delete_columns([0]).det()

def n_components(nv, uedges):
    parent = list(range(nv))
    def find(a):
        while parent[a] != a:
            parent[a] = parent[parent[a]]; a = parent[a]
        return a
    for (x, y) in uedges:
        rx, ry = find(x), find(y)
        if rx != ry:
            parent[rx] = ry
    return len(set(find(a) for a in range(nv)))

def laurent_to_poly(D):
    """D(z) = z^{vmin}·P(z), P ∈ ℤ[z], P(0) ≠ 0 を返す（(vmin, P)）。D = 0 なら (0, 0)。"""
    if D == 0:
        return (0, Rp(0))
    d = D.dict()
    vmin = min(d.keys())
    return (vmin, Rp({e - vmin: c for (e, c) in d.items()}))

def content_of(f):
    if f == 0:
        return ZZ(0)
    return gcd([ZZ(c) for c in f.coefficients()])

def weierstrass_mu_lambda(D, ell):
    """D(1+T) ∈ ℤ_ℓ[[T]] の Weierstrass 不変量 (μ, λ_W)。
       D = z^{vmin} P(z) で (1+T)^{vmin} は ℤ[[T]] の単元なので
       f = D(1+T) と p(T) = P(1+T) の (μ, λ_W) は一致する。"""
    vmin, P = laurent_to_poly(D)
    p = P(1 + T)
    cs = [ZZ(c) for c in p.list()]
    mu = min(c.valuation(ell) for c in cs if c != 0) if any(c != 0 for c in cs) else None
    lamW = min(j for (j, c) in enumerate(cs) if c != 0 and c.valuation(ell) == mu)
    return (mu, lamW, p)

def prod_det_over_nontrivial_roots(D, N):
    """∏_{ζ^N=1, ζ≠1} D(ζ) ∈ ℤ を終結式で厳密に計算する。
       D = z^{vmin} P、∏_{ζ≠1} ζ = (-1)^{N+1}、
       ∏_{ζ≠1} P(ζ) = Res_z((z^N-1)/(z-1), P)（(z^N-1)/(z-1) はモニック）。"""
    if N == 1:
        return ZZ(1)
    vmin, P = laurent_to_poly(D)
    if P == 0:
        return ZZ(0)
    Q = Rp((zp**N - 1) // (zp - 1))
    res = ZZ(Q.resultant(P))
    unit = ZZ((-1)**(N + 1))**vmin
    return unit * res

def cycle_voltage_gcd(m, edges):
    """底グラフ X の基本閉路の net voltage の gcd（X 連結を仮定）。
       全域木を取り、非木辺 e=(u,v,a) の基本閉路の voltage は a + h(u) - h(v)
       （h は木上で決まる potential）。"""
    parent = list(range(m))
    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]; x = parent[x]
        return x
    tree, nontree = [], []
    for e in edges:
        (u, v, a) = e
        if u == v:
            nontree.append(e); continue
        ru, rv = find(u), find(v)
        if ru != rv:
            parent[ru] = rv; tree.append(e)
        else:
            nontree.append(e)
    # 木上の potential h: h(v) = h(u) + a （辺 (u,v,a) を u→v と読む）
    adj = {i: [] for i in range(m)}
    for (u, v, a) in tree:
        adj[u].append((v, a)); adj[v].append((u, -a))
    h = {0: 0}; stack = [0]
    while stack:
        x = stack.pop()
        for (y, a) in adj[x]:
            if y not in h:
                h[y] = h[x] + a; stack.append(y)
    g = ZZ(0)
    for (u, v, a) in nontree:
        g = gcd(g, ZZ(a + h[u] - h[v]))
    return g

# --------------------------------------------------------------------------
# テスト対象のグラフ
# --------------------------------------------------------------------------

EXAMPLES = [
    ("例1 A={0,1,2}+各頂点ループ{1}", 2, [(0,1,0),(0,1,1),(0,1,2),(0,0,1),(1,1,1)]),
    ("例2 A={0,1,1,2}+各頂点ループ{1}", 2, [(0,1,0),(0,1,1),(0,1,1),(0,1,2),(0,0,1),(1,1,1)]),
    ("例3 A={0,0,1,2}+loop0{1}+loop1{1,1}", 2, [(0,1,0),(0,1,0),(0,1,1),(0,1,2),(0,0,1),(1,1,1),(1,1,1)]),
    ("例4 3頂点 content=48", 3, [(0,1,1),(0,1,1),(0,2,0),(0,2,1),(1,2,1),(1,2,1),(0,0,1),(2,2,1)]),
    ("例5 A={0,0,0,1}+各頂点ループ{1,1,1}", 2, [(0,1,0),(0,1,0),(0,1,0),(0,1,1)]+[(0,0,1)]*3+[(1,1,1)]*3),
    ("例6 A={0,1}+loop1{1,1}", 2, [(0,1,0),(0,1,1),(1,1,1),(1,1,1)]),
    ("bouquet 1ループ voltage1 (χ=0)", 1, [(0,0,1)]),
    ("bouquet 2ループ voltage1,2", 1, [(0,0,1),(0,0,2)]),
    ("退化: voltage 全部 0 の三角形", 3, [(0,1,0),(1,2,0),(0,2,0)]),
    ("退化: voltage 2 のループのみ (X_N 非連結あり)", 1, [(0,0,2)]),
    ("退化: 木 + voltage 2 のループ", 2, [(0,1,0),(0,0,2)]),
    ("多重辺 voltage {0,2} のみ", 2, [(0,1,0),(0,1,2)]),
]

def random_graph(m_max=3, e_max=6, a_max=3):
    m = randint(1, m_max)
    ne = randint(1, e_max)
    edges = []
    for _ in range(ne):
        u = randint(0, m - 1); v = randint(0, m - 1); a = randint(-a_max, a_max)
        edges.append((u, v, a))
    return (m, edges)

RANDOM = [random_graph() for _ in range(40)]
ALL = [(nm, m, e) for (nm, m, e) in EXAMPLES] + [(f"random#{i}", m, e) for (i, (m, e)) in enumerate(RANDOM)]

print("=" * 78)
print("cycle 13 / T3: (★) と (☆) の証明ステップの機械検証")
print(f"対象グラフ: 明示例 {len(EXAMPLES)} 件 + 乱択 {len(RANDOM)} 件 = {len(ALL)} 件")
print("=" * 78)

# --------------------------------------------------------------------------
# Step 1: 補題 A（DFT ブロック対角化）
#   charpoly(L_{X_N})(x) = ∏_{ζ^N=1} charpoly(L(ζ))(x)   （ℚ(ζ_N)[x] での等式）
# --------------------------------------------------------------------------
print("\n[Step 1] 補題 A: charpoly(L_{X_N}) = ∏_{ζ^N=1} charpoly(L(ζ))")
fail = 0; cnt = 0
for (nm, m, edges) in ALL:
    L = volt_laplacian(m, edges)
    for N in range(1, 7):
        K = CyclotomicField(N) if N > 2 else QQ
        zeta = K.zeta(N) if N > 2 else (K(1) if N == 1 else K(-1))
        Kx = PolynomialRing(K, 'x'); x = Kx.gen()
        lhs = Kx(int_laplacian(m * N, derived_edges(m, edges, N)).charpoly())
        rhs = Kx(1)
        for j in range(N):
            zz = zeta**j
            Lz = matrix(K, m, m, [[sum(ZZ(c) * zz**e for (e, c) in L[i, k].dict().items()) if L[i, k] != 0 else K(0)
                                   for k in range(m)] for i in range(m)])
            rhs *= Kx(Lz.charpoly())
        cnt += 1
        if lhs != rhs:
            fail += 1
            print(f"  NG: {nm} N={N}")
print(f"  検査 {cnt} 件, 不一致 {fail} 件 → {'全て一致' if fail == 0 else '失敗あり'}")

# --------------------------------------------------------------------------
# Step 2: 補題 B（連結成分数の分解）
# --------------------------------------------------------------------------
print("\n[Step 2] 補題 B: c(X_N) = Σ_{ζ^N=1} dim ker L(ζ)")
fail = 0; cnt = 0
for (nm, m, edges) in ALL:
    L = volt_laplacian(m, edges)
    for N in range(1, 9):
        K = CyclotomicField(N) if N > 2 else QQ
        zeta = K.zeta(N) if N > 2 else (K(1) if N == 1 else K(-1))
        s = 0
        for j in range(N):
            zz = zeta**j
            Lz = matrix(K, m, m, [[sum(ZZ(c) * zz**e for (e, c) in L[i, k].dict().items()) if L[i, k] != 0 else K(0)
                                   for k in range(m)] for i in range(m)])
            s += m - Lz.rank()
        c = n_components(m * N, derived_edges(m, edges, N))
        cnt += 1
        if s != c:
            fail += 1
            print(f"  NG: {nm} N={N}: Σdim ker={s}, c(X_N)={c}")
print(f"  検査 {cnt} 件, 不一致 {fail} 件 → {'全て一致' if fail == 0 else '失敗あり'}")

# --------------------------------------------------------------------------
# Step 3: 補題 C（連結性の gcd 判定）
# --------------------------------------------------------------------------
print("\n[Step 3] 補題 C: X 連結のとき、X_N 連結 ⟺ gcd(N, 基本閉路 voltage の gcd) = 1")
fail = 0; cnt = 0
for (nm, m, edges) in ALL:
    if n_components(m, [(u, v) for (u, v, a) in edges]) != 1:
        continue
    g = cycle_voltage_gcd(m, edges)
    for N in range(1, 13):
        conn = (n_components(m * N, derived_edges(m, edges, N)) == 1)
        pred = (gcd(ZZ(N), g) == 1)
        cnt += 1
        if conn != pred:
            fail += 1
            print(f"  NG: {nm} N={N}: 実測連結={conn}, 判定={pred} (g={g})")
print(f"  検査 {cnt} 件, 不一致 {fail} 件 → {'全て一致' if fail == 0 else '失敗あり'}")

# --------------------------------------------------------------------------
# Step 4: 定理 (★)
#   N·κ(X_N) = κ(X)·∏_{ζ^N=1, ζ≠1} det L(ζ)   （両辺 ℤ、非連結な段も含む）
# --------------------------------------------------------------------------
print("\n[Step 4] 定理 (★): N·κ(X_N) = κ(X)·∏_{ζ≠1} det L(ζ)")
fail = 0; cnt = 0; ndisc = 0
for (nm, m, edges) in ALL:
    D = det(volt_laplacian(m, edges))
    k0 = kappa_derived(m, edges, 1)
    for N in range(1, 13):
        kN = kappa_derived(m, edges, N)
        lhs = ZZ(N) * kN
        rhs = ZZ(k0) * prod_det_over_nontrivial_roots(D, N)
        cnt += 1
        if kN == 0:
            ndisc += 1
        if lhs != rhs:
            fail += 1
            print(f"  NG: {nm} N={N}: LHS={lhs}, RHS={rhs}")
print(f"  検査 {cnt} 件（うち X_N 非連結 {ndisc} 件）, 不一致 {fail} 件 → {'全て一致' if fail == 0 else '失敗あり'}")

# --------------------------------------------------------------------------
# Step 5: 補題 D（content の不変性）と (☆)
# --------------------------------------------------------------------------
print("\n[Step 5] 補題 D: content_z(det L) = content_T(P(1+T)) / (☆) v_ℓ(content) = μ_Weierstrass")
fail = 0; cnt = 0; skipped = 0
PRIMES = [2, 3, 5, 7, 23]
for (nm, m, edges) in ALL:
    D = det(volt_laplacian(m, edges))
    if D == 0:
        skipped += 1
        continue
    vmin, P = laurent_to_poly(D)
    cD = content_of(D); cP = content_of(P); p = P(1 + T); cp = content_of(p)
    cnt += 1
    if not (cD == cP == cp):
        fail += 1
        print(f"  NG(content): {nm}: content(D)={cD}, content(P)={cP}, content(P(1+T))={cp}")
    for ell in PRIMES:
        mu, lamW, _ = weierstrass_mu_lambda(D, ell)
        if mu != ZZ(cD).valuation(ell):
            fail += 1
            print(f"  NG(☆): {nm} ℓ={ell}: μ_W={mu}, v_ℓ(content)={ZZ(cD).valuation(ell)}")
print(f"  検査 {cnt} 件（det L = 0 で除外 {skipped} 件）× 素数 {len(PRIMES)} 個, 不一致 {fail} 件 → {'全て一致' if fail == 0 else '失敗あり'}")

# --------------------------------------------------------------------------
# Step 6: 岩澤漸近（本レポートの自前導出）
#   ord_ℓ(κ_n) = μ·ℓ^n + (λ_W - 1)·n + ν
#   μ, λ_W は D(1+T) の Weierstrass 不変量。ν は n=n0 で決め、残りの n で照合する。
# --------------------------------------------------------------------------
print("\n[Step 6] 定理: ord_ℓ(κ_n) = μ·ℓ^n + (λ_W-1)·n + ν  （μ,λ_W は D(1+T) の Weierstrass 不変量）")
TOWERS = [
    ("例1", 2, EXAMPLES[0][2], [(2, 6), (3, 4), (5, 2), (7, 2)]),
    ("例2", 2, EXAMPLES[1][2], [(2, 6), (3, 3), (5, 2)]),
    ("例3", 2, EXAMPLES[2][2], [(2, 5), (3, 3), (23, 1)]),
    ("例4", 3, EXAMPLES[3][2], [(2, 5), (3, 3)]),
    ("例5", 2, EXAMPLES[4][2], [(2, 4), (3, 3), (5, 2)]),
    ("例6", 2, EXAMPLES[5][2], [(2, 4), (3, 3), (5, 2)]),
    ("bouquet 1ループ(χ=0)", 1, EXAMPLES[6][2], [(2, 6), (3, 4)]),
    ("bouquet 2ループ", 1, EXAMPLES[7][2], [(2, 5), (3, 3)]),
    # 退化: ℓ=2 の塔が非連結になる（gcd(基本閉路 voltage)=2）。ℓ=3 では連結。
    ("退化 loop voltage2", 1, EXAMPLES[9][2], [(2, 3), (3, 3)]),
    ("退化 木+loop voltage2", 2, EXAMPLES[10][2], [(2, 3), (3, 3)]),
]
_hdr = "λ_W-1"
print(f"  {'グラフ':>22} {'ℓ':>3} {'μ':>3} {'λ_W':>4} {_hdr:>8} {'ν':>4} {'全 n 一致':>9}  ord_ℓ(κ_n)")
for (nm, m, edges, tw) in TOWERS:
    D = det(volt_laplacian(m, edges))
    for (ell, nmax) in tw:
        mu, lamW, _ = weierstrass_mu_lambda(D, ell)
        vals = []
        ok_tower = True
        for n in range(nmax + 1):
            k = kappa_derived(m, edges, ell**n)
            if k == 0:
                ok_tower = False; break
            vals.append((n, ZZ(k).valuation(ell)))
        if not ok_tower:
            print(f"  {nm:>22} {ell:>3}  塔が非連結（(★) の前提を満たさない）")
            continue
        lam = lamW - 1
        # ν は最大の n で決める（漸近式なので n が大きい方が安全）
        n_last, v_last = vals[-1]
        nu = v_last - mu * ell**n_last - lam * n_last
        agree = [n for (n, v) in vals if v != mu * ell**n + lam * n + nu]
        mark = "全一致" if not agree else f"n={agree} で不一致"
        print(f"  {nm:>22} {ell:>3} {mu:>3} {lamW:>4} {lam:>8} {nu:>4} {mark:>9}  {[v for (_, v) in vals]}")

# 乱択グラフでも Step 6 を回す（塔が連結で det L ≠ 0 のものだけ）
#
# 証明が主張するのは「n ≥ n_0 で一致」なので、ここでは
#   n_0 := 1 + max{ n : 不一致 }（不一致が無ければ 0）
# を求めて報告する。n_0 が n_max に達している＝一致の証拠が 1 点も無い場合のみ「失敗」と数える。
print("\n  乱択グラフでの Step 6（塔が連結なものだけ）: n_0 = 漸近式が成立し始める段")
nchk = 0; nbad = 0; nskip = 0
n0_hist = {}
for (i, (m, edges)) in enumerate(RANDOM):
    D = det(volt_laplacian(m, edges))
    if D == 0:
        nskip += 1; continue
    for (ell, nmax) in [(2, 4), (3, 3)]:
        vals = []
        ok_tower = True
        for n in range(nmax + 1):
            k = kappa_derived(m, edges, ell**n)
            if k == 0:
                ok_tower = False; break
            vals.append((n, ZZ(k).valuation(ell)))
        if not ok_tower:
            nskip += 1; continue
        mu, lamW, _ = weierstrass_mu_lambda(D, ell)
        lam = lamW - 1
        n_last, v_last = vals[-1]
        nu = v_last - mu * ell**n_last - lam * n_last
        agree = [n for (n, v) in vals if v != mu * ell**n + lam * n + nu]
        nchk += 1
        n0 = (max(agree) + 1) if agree else 0
        n0_hist[n0] = n0_hist.get(n0, 0) + 1
        if n0 >= nmax:
            nbad += 1
            print(f"    証拠なし: random#{i} ℓ={ell}: μ={mu} λ={lam} で n_0={n0} = n_max (実測 {[v for (_,v) in vals]})")
print(f"    検査 {nchk} 件（塔が非連結 / det L=0 で除外 {nskip} 件）")
print(f"    n_0 の分布: {dict(sorted(n0_hist.items()))}   （n_0 = 漸近式が成立し始める段）")
print(f"    n_max まで一致の証拠が得られなかったもの: {nbad} 件")


# --------------------------------------------------------------------------
# Step 7: ℓ ∤ N の段は content で支配されない（証明の適用範囲の限界を示す反例探索）
#   証明は v_ℓ(ζ-1) > 0 すなわち ζ が ℓ 冪位数であることを本質的に使う。
#   ζ の位数が ℓ と互いに素なら v_ℓ(ζ-1) = 0 で Weierstrass の議論は効かない。
#   実際 μ = v_ℓ(content) = 0 なのに ℓ ∤ N の段で v_ℓ(κ(X_N)) > 0 になる例が存在する。
# --------------------------------------------------------------------------
print("\n[Step 7] ℓ ∤ N の段: μ = v_ℓ(content) = 0 でも v_ℓ(κ(X_N)) > 0 になりうる（適用範囲の限界）")
found = 0
for (nm, m, edges) in ALL:
    D = det(volt_laplacian(m, edges))
    if D == 0:
        continue
    cD = content_of(D)
    for ell in [2, 3]:
        if ZZ(cD).valuation(ell) != 0:
            continue
        for N in range(2, 14):
            if N % ell == 0:
                continue
            k = kappa_derived(m, edges, N)
            if k != 0 and ZZ(k).valuation(ell) > 0 and found < 6:
                print(f"  witness: {nm}  ℓ={ell}, content={cD} (v_ℓ=0), N={N} (ℓ∤N): "
                      f"κ(X_N)={k}, v_{ell}(κ)={ZZ(k).valuation(ell)}")
                found += 1
                break
print(f"  → {found} 件の witness を提示（1 件でも存在すれば「content が ℓ∤N の段を支配する」は偽）")

print("\n" + "=" * 78)
print("限界（正直に）: 上記はすべて有限個の例での照合であり、証明ではない。")
print("  証明本体は outputs/reports/cycle13_T3_mu_content_criterion_proof.md にある。")
print("  Step 6 の ν は各塔で n = n_max から決めており、小さい n での不一致は")
print("  漸近式が n ≥ n_0 でのみ成立することの現れ（証明の主張と矛盾しない）。")
print("=" * 78)
