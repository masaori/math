# cycle 14 / T3 Pure: Z_ell^2-塔（d=2）への拡張。証明の各ステップを機械的に検証する。
#
# 対応する証明本体: outputs/reports/cycle14_T3_two_variable_criterion.md
#
# 検証するのは以下の 9 個。いずれも「有限個の例での照合」であって証明ではない。
# 証明の各補題が具体例で破れていないこと（＝証明の書き間違いが無いこと）の確認である。
#
#   Step 1  補題 A2（2 重 DFT ブロック対角化）:
#           charpoly(L_{X_{N,N'}}) = prod_{zeta^N=1, xi^{N'}=1} charpoly(L(zeta,xi))
#   Step 2  補題 B2（連結成分数）: c(X_{N,N'}) = sum_{zeta,xi} dim ker L(zeta,xi)
#   Step 3  補題 C2（連結性の格子判定）:
#           X_{N,N'} 連結 <=> X 連結 かつ B + (N Z + N' Z) = Z^2  （B = 基本閉路 voltage の生成格子）
#   Step 4  定理 1 = (★) の 2 変数版:
#           N N' kappa(X_{N,N'}) = kappa(X) * prod_{(zeta,xi) != (1,1)} det L(zeta,xi)
#           左辺は導来グラフの Kirchhoff 余因子、右辺は (a) 円分体上の直接積 (b) 2 段終結式
#           の 2 通りで独立に計算する。
#   Step 5  補題 D2（content の不変性）:
#           v_ell(content_{z,w} det L) = min_{i,j} v_ell(c_{ij})   (det L(1+T,1+S) = sum c_{ij} T^i S^j)
#   Step 6  DuBose-Vallieres, Algebraic Combinatorics 6 (2023) 1331-1346, Section 7 の
#           数値例 5 件を (★) 経由で再現し、論文の表・公式と突き合わせる（外部照合）。
#   Step 7  ord_ell(kappa_n) を [ell^{2n}, n ell^n, ell^n, n, 1] で fit し、
#           ell^{2n} の係数 a が v_ell(content_{z,w} det L) と一致するかを見る。
#   Step 8  非退化条件（H が P^1(F_ell) 上に零点をもたない）の判定と、
#           そのとき成立すると証明した閉形式
#             ord_ell(kappa_n) = mu ell^{2n} + k (ell+1)/(ell-1) ell^n - 2 n + nu
#           の照合（nu は最大の n で 1 回だけ決める）。
#   Step 9  中心となる補題（点ごとの付値）:
#           非退化なら v_ell(det L(zeta,xi)) = mu + k / phi(ell^max(i,j))
#           （ord zeta = ell^i, ord xi = ell^j, max(i,j) >= J_0）を円分体の素イデアルで直接確認。
#
# 実行: sage two_var.sage

import sys
import time
from itertools import product as iproduct

sys.stdout.reconfigure(line_buffering=True)
set_random_seed(20260726)

Rzw = PolynomialRing(ZZ, ['z', 'w']); zg, wg = Rzw.gens()
Lzw = LaurentPolynomialRing(ZZ, ['z', 'w']); zL, wL = Lzw.gens()
Rz = PolynomialRing(ZZ, 'z'); zp = Rz.gen()
RzW = PolynomialRing(Rz, 'w'); wP = RzW.gen()
RTS = PolynomialRing(ZZ, ['T', 'S']); Tg, Sg = RTS.gens()

# ==========================================================================
# 基本構成
#   底グラフ X: 頂点 0..m-1、辺は (u, v, (a,b)) の list。u == v はループ、
#   (a,b) in Z^2 が voltage。cycle13 の 1 変数版 (cycle13_T3_criterion_proof) の素直な拡張。
# ==========================================================================

def volt_laplacian(m, edges):
    """voltage ラプラシアン L(z,w) in Mat_m(Z[z^{+-1}, w^{+-1}])。"""
    L = matrix(Lzw, m, m)
    for (u, v, (a, b)) in edges:
        mon = zL**a * wL**b
        if u == v:
            L[u, u] += 2 - mon - mon**(-1)
        else:
            L[u, u] += 1; L[v, v] += 1
            L[u, v] -= mon; L[v, u] -= mon**(-1)
    return L

def detL(m, edges):
    return volt_laplacian(m, edges).det()

def derived_edges(m, edges, N, Np):
    """導来グラフ X_{N,N'} の辺 list（頂点は (i*Np + j)*m + u で番号付け）。"""
    out = []
    for (u, v, (a, b)) in edges:
        for i in range(N):
            for j in range(Np):
                x = (i * Np + j) * m + u
                y = (((i + a) % N) * Np + ((j + b) % Np)) * m + v
                out.append((x, y))
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

def kappa_derived(m, edges, N, Np):
    """X_{N,N'} の全域木数（Kirchhoff の余因子）。非連結なら 0。"""
    nv = m * N * Np
    Lap = int_laplacian(nv, derived_edges(m, edges, N, Np))
    return Lap.delete_rows([0]).delete_columns([0]).det()

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

def base_connected(m, edges):
    return n_components(m, [(u, v) for (u, v, _) in edges]) == 1

def cycle_voltage_lattice(m, edges):
    """底グラフ X（連結を仮定）の基本閉路 voltage の生成する Z^2 の部分格子の生成元 list。
       全域木 T を取り、非木辺 e=(u,v,alpha) の基本閉路 voltage は alpha + h(u) - h(v)。"""
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
    # 木上の potential h: V -> Z^2
    h = {0: vector(ZZ, [0, 0])}
    adj = {}
    for (u, v, a) in tree:
        adj.setdefault(u, []).append((v, vector(ZZ, a)))
        adj.setdefault(v, []).append((u, -vector(ZZ, a)))
    stack = [0]
    while stack:
        x = stack.pop()
        for (y, a) in adj.get(x, []):
            if y not in h:
                h[y] = h[x] + a; stack.append(y)
    gens = []
    for (u, v, a) in nontree:
        gens.append(vector(ZZ, a) + h[u] - h[v])
    return gens

def connected_by_lattice(m, edges, N, Np):
    """B + (N Z + N' Z) = Z^2 か（＝補題 C2 の判定）。"""
    if not base_connected(m, edges):
        return False
    gens = cycle_voltage_lattice(m, edges)
    rows = [list(g) for g in gens] + [[N, 0], [0, Np]]
    M = matrix(ZZ, rows)
    if M.nrows() == 0:
        return N == 1 and Np == 1
    d = M.elementary_divisors()
    d = [x for x in d if x != 0]
    return len(d) == 2 and d[0] == 1 and d[1] == 1

def content_of(F):
    """Laurent 多項式 / 多項式の content（係数の gcd）。"""
    cs = [ZZ(c) for c in F.coefficients()]
    if not cs:
        return ZZ(0)
    return gcd(cs)

def clear_monomial(D):
    """D in Z[z^{+-},w^{+-}] を D = z^r w^s * P(z,w), P in Z[z,w] と書き (r, s, P) を返す。"""
    if D == 0:
        return (0, 0, Rzw(0))
    ex = [e for e in D.dict().keys()]
    r = min(e[0] for e in ex); s = min(e[1] for e in ex)
    P = Rzw({(e[0] - r, e[1] - s): ZZ(c) for (e, c) in D.dict().items()})
    return (r, s, P)

def f_series(D):
    """f(T,S) = P(1+T, 1+S) in Z[T,S]（D = z^r w^s P, 単項式因子は Z_ell[[T,S]] の単元なので落とす）。"""
    (r, s, P) = clear_monomial(D)
    return RTS(P.subs({zg: 1 + Tg, wg: 1 + Sg}))

def mu_content(D, ell):
    """v_ell(content_{z,w} D)。"""
    return ZZ(content_of(D)).valuation(ell)

def lowest_form(D, ell):
    """f = P(1+T,1+S) の mod ell 還元の最低次斉次部分 H とその次数 k を返す。"""
    f = f_series(D)
    Fl = GF(ell)
    fb = f.change_ring(Fl)
    if fb == 0:
        return (None, None)
    k = min(e[0] + e[1] for (e, c) in fb.dict().items() if c != 0)
    RTSl = PolynomialRing(Fl, ['T', 'S'])
    H = RTSl({e: c for (e, c) in fb.dict().items() if e[0] + e[1] == k and c != 0})
    return (k, H)

def is_nondegenerate(D, ell):
    """H が P^1(F_ell) 上に零点をもたないか。"""
    (k, H) = lowest_form(D, ell)
    if k is None:
        return (None, None, None)
    Tl, Sl = H.parent().gens()
    bad = []
    if H.subs({Tl: 0, Sl: 1}) == 0:
        bad.append('(0:1)')
    for c in GF(ell):
        if H.subs({Tl: 1, Sl: c}) == 0:
            bad.append('(1:%s)' % c)
    return (k, H, bad)

# --------------------------------------------------------------------------
# prod_{(zeta,xi) != (1,1)} D(zeta,xi) の 2 通りの厳密計算
# --------------------------------------------------------------------------

def prod_nontrivial_resultant(D, N, Np):
    """2 段終結式で計算する（大きい N でも使える）。
       D = z^r w^s P。
       prod_{(zeta,xi)!=(1,1)} = [prod_{zeta!=1} prod_{xi} D] * [prod_{xi!=1} D(1,xi)]。
       prod_{xi^{N'}=1} P(z,xi) = Res_w(w^{N'}-1, P)（w^{N'}-1 はモニック）。
       prod_{xi^{N'}=1} xi = (-1)^{N'+1}、prod_{xi!=1} xi = (-1)^{N'+1}。"""
    if N == 1 and Np == 1:
        return ZZ(1)          # 空積（除外される (zeta,xi) が (1,1) だけ）
    (r, s, P) = clear_monomial(D)
    if P == 0:
        return ZZ(0)
    # ---- part1 = prod_{zeta != 1} prod_{xi} D(zeta, xi)
    #      N == 1 のときは空積 1。このとき A（= prod_xi P(z,xi)）は使わない
    #      （z 方向だけが退化して A == 0 になる例があるので、先に A を見てはいけない）。
    if N == 1:
        part1 = ZZ(1)
    else:
        A = Rz((wP**Np - 1).resultant(RzW(P)))   # prod_{xi} P(z,xi)  in Z[z]
        if A == 0:
            return ZZ(0)
        Q = Rz((zp**N - 1) // (zp - 1))
        # prod_{zeta!=1} D(zeta,xi) over all xi
        #   = prod_{zeta!=1} [ zeta^{r Np} * (prod_{xi} xi^s) * A(zeta) ]
        #   = (prod_{zeta!=1} zeta)^{r Np} * ((-1)^{Np+1})^{s (N-1)} * Res(Q, A)
        u1 = ZZ((-1)**(N + 1))**(r * Np)
        u2 = ZZ((-1)**(Np + 1))**(s * (N - 1))
        part1 = u1 * u2 * ZZ(Q.resultant(A))
    # ---- part2 = prod_{xi != 1} D(1, xi)
    if Np == 1:
        part2 = ZZ(1)
    else:
        P1 = Rz(P.subs({zg: ZZ(1), wg: zp}))
        if P1 == 0:
            return ZZ(0)
        Qp = Rz((zp**Np - 1) // (zp - 1))
        part2 = ZZ((-1)**(Np + 1))**s * ZZ(Qp.resultant(P1))
    return part1 * part2

def prod_nontrivial_cyclotomic(D, N, Np):
    """円分体上で直接 prod_{(zeta,xi)!=(1,1)} D(zeta,xi) を計算する（小さい N,N' 用、独立経路）。"""
    M = lcm(N, Np)
    if M == 1:
        return ZZ(1)
    K = CyclotomicField(M); g = K.gen()
    zeta = g**(M // N); xi = g**(M // Np)
    acc = K(1)
    for i in range(N):
        for j in range(Np):
            if i == 0 and j == 0:
                continue
            acc *= D.subs({zL: zeta**i, wL: xi**j})
    return ZZ(acc)

# ==========================================================================
# 例
# ==========================================================================

EX = []
# DuBose-Vallieres Section 7 の 5 例（bouquet, alpha は Z^2 値）
EX.append(('DV1 bouquet (1,0),(0,1)  = ell^n x ell^n トーラス', 1,
           [(0, 0, (1, 0)), (0, 0, (0, 1))]))
EX.append(('DV2 bouquet (1,0)x2,(0,1)x2  (content 2)', 1,
           [(0, 0, (1, 0)), (0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (0, 1))]))
EX.append(('DV3 bouquet (1,5),(0,3),(1,2),(0,1)', 1,
           [(0, 0, (1, 5)), (0, 0, (0, 3)), (0, 0, (1, 2)), (0, 0, (0, 1))]))
EX.append(('DV5 bouquet (1,0),(2,3),(1,1)', 1,
           [(0, 0, (1, 0)), (0, 0, (2, 3)), (0, 0, (1, 1))]))
# 自前の例
EX.append(('2 頂点 平行 3 重辺 voltage (0,0),(1,0),(0,1)', 2,
           [(0, 1, (0, 0)), (0, 1, (1, 0)), (0, 1, (0, 1))]))
EX.append(('2 頂点 + ループ  (0,0),(1,0) と ループ (0,1)', 2,
           [(0, 1, (0, 0)), (0, 1, (1, 0)), (1, 1, (0, 1))]))
EX.append(('bouquet 3 ループ (1,0),(0,1),(1,1)', 1,
           [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (1, 1))]))
EX.append(('bouquet (1,0),(0,1) を 3 重化（content 3）', 1,
           [(0, 0, (1, 0))] * 3 + [(0, 0, (0, 1))] * 3))
EX.append(('bouquet (2,0),(0,2)（塔が非連結になる退化例）', 1,
           [(0, 0, (2, 0)), (0, 0, (0, 2))]))
EX.append(('bouquet (1,0) のみ（w 方向が無い退化例）', 1,
           [(0, 0, (1, 0))]))
EX.append(('3 頂点三角形 voltage (1,0),(0,1),(0,0)', 3,
           [(0, 1, (1, 0)), (1, 2, (0, 1)), (2, 0, (0, 0))]))
EX.append(('bouquet (1,0),(0,1),(1,-1)', 1,
           [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (1, -1))]))

def random_example(idx):
    m = ZZ.random_element(1, 4)
    ne = ZZ.random_element(2, 5)
    edges = []
    for _ in range(ne):
        u = ZZ.random_element(0, m); v = ZZ.random_element(0, m)
        a = ZZ.random_element(-2, 3); b = ZZ.random_element(-2, 3)
        edges.append((u, v, (a, b)))
    return ('random #%d (m=%d, |E|=%d)' % (idx, m, len(edges)), m, edges)

RAND = [random_example(i) for i in range(1, 25)]

print("=" * 78)
print("cycle 14 / T3: Z_ell^2-塔（d=2）の検証")
print("SageMath", version())
print("=" * 78)

# ==========================================================================
# Step 1  補題 A2: 2 重 DFT ブロック対角化
# ==========================================================================
print()
print("### Step 1  補題 A2: charpoly(L_{X_{N,N'}}) = prod_{zeta,xi} charpoly(L(zeta,xi))")
cnt = bad = 0
for (name, m, edges) in EX + RAND[:8]:
    L = volt_laplacian(m, edges)
    for N in range(1, 4):
        for Np in range(1, 4):
            M = lcm(N, Np)
            K = CyclotomicField(M) if M > 1 else QQ
            PR = PolynomialRing(K, 'x'); x = PR.gen()
            g = K.gen() if M > 1 else K(1)
            zeta = g**(M // N) if M > 1 else K(1)
            xi = g**(M // Np) if M > 1 else K(1)
            lhs = PR(int_laplacian(m * N * Np,
                                   derived_edges(m, edges, N, Np)).charpoly('x'))
            rhs = PR(1)
            for i in range(N):
                for j in range(Np):
                    Lij = matrix(K, m, m,
                                 [K(c.subs({zL: zeta**i, wL: xi**j})) for c in L.list()])
                    rhs *= PR((x * identity_matrix(K, m) - Lij).det())
            cnt += 1
            if lhs != rhs:
                bad += 1
                print("  MISMATCH", name, N, Np)
print("  照合 %d 件、不一致 %d 件" % (cnt, bad))

# ==========================================================================
# Step 2  補題 B2: 連結成分数
# ==========================================================================
print()
print("### Step 2  補題 B2: c(X_{N,N'}) = sum_{zeta,xi} dim ker L(zeta,xi)")
cnt = bad = 0
for (name, m, edges) in EX + RAND:
    L = volt_laplacian(m, edges)
    for N in range(1, 5):
        for Np in range(1, 5):
            M = lcm(N, Np)
            K = CyclotomicField(M) if M > 1 else QQ
            g = K.gen() if M > 1 else K(1)
            zeta = g**(M // N) if M > 1 else K(1)
            xi = g**(M // Np) if M > 1 else K(1)
            tot = 0
            for i in range(N):
                for j in range(Np):
                    Lij = matrix(K, m, m,
                                 [K(c.subs({zL: zeta**i, wL: xi**j})) for c in L.list()])
                    tot += m - Lij.rank()
            c = n_components(m * N * Np, derived_edges(m, edges, N, Np))
            cnt += 1
            if tot != c:
                bad += 1
                print("  MISMATCH", name, N, Np, tot, c)
print("  照合 %d 件、不一致 %d 件" % (cnt, bad))

# ==========================================================================
# Step 3  補題 C2: 連結性の格子判定
# ==========================================================================
print()
print("### Step 3  補題 C2: X_{N,N'} 連結 <=> X 連結 かつ B + (N Z + N' Z) = Z^2")
cnt = bad = 0
ndeg = 0
for (name, m, edges) in EX + RAND:
    for N in range(1, 7):
        for Np in range(1, 7):
            actual = (n_components(m * N * Np, derived_edges(m, edges, N, Np)) == 1)
            pred = connected_by_lattice(m, edges, N, Np)
            cnt += 1
            if not actual:
                ndeg += 1
            if actual != pred:
                bad += 1
                print("  MISMATCH", name, N, Np, actual, pred)
print("  照合 %d 件（うち非連結 %d 件）、不一致 %d 件" % (cnt, ndeg, bad))

# ==========================================================================
# Step 4  定理 1 = (★) の 2 変数版
# ==========================================================================
print()
print("### Step 4  定理 1: N N' kappa(X_{N,N'}) = kappa(X) * prod_{(zeta,xi)!=(1,1)} det L(zeta,xi)")
print("    左辺 = Kirchhoff 余因子 / 右辺(a) = 円分体上の直接積 / 右辺(b) = 2 段終結式")
cnt = bad = 0
ndeg = 0
for (name, m, edges) in EX + RAND:
    D = detL(m, edges)
    k0 = kappa_derived(m, edges, 1, 1)
    for N in range(1, 5):
        for Np in range(1, 5):
            if m * N * Np > 40:
                continue
            lhs = N * Np * kappa_derived(m, edges, N, Np)
            rhs_a = k0 * prod_nontrivial_cyclotomic(D, N, Np)
            rhs_b = k0 * prod_nontrivial_resultant(D, N, Np)
            cnt += 1
            if lhs == 0:
                ndeg += 1
            if not (lhs == rhs_a == rhs_b):
                bad += 1
                print("  MISMATCH", name, N, Np, lhs, rhs_a, rhs_b)
print("  照合 %d 件（うち両辺 0 の退化ケース %d 件）、不一致 %d 件" % (cnt, ndeg, bad))

# ==========================================================================
# Step 5  補題 D2: content の不変性
# ==========================================================================
print()
print("### Step 5  補題 D2: v_ell(content_{z,w} det L) = min_{i,j} v_ell(c_{ij}),  f = det L(1+T,1+S)")
cnt = bad = 0
for (name, m, edges) in EX + RAND:
    D = detL(m, edges)
    if D == 0:
        continue
    f = f_series(D)
    for ell in [2, 3, 5, 7, 23]:
        mu1 = mu_content(D, ell)
        mu2 = min(ZZ(c).valuation(ell) for c in f.coefficients())
        # 単項式因子を掛けても不変（別の正規化）
        f2 = RTS(Rzw(clear_monomial(D)[2] * zg**2 * wg**3).subs({zg: 1 + Tg, wg: 1 + Sg}))
        mu3 = min(ZZ(c).valuation(ell) for c in f2.coefficients())
        cnt += 1
        if not (mu1 == mu2 == mu3):
            bad += 1
            print("  MISMATCH", name, ell, mu1, mu2, mu3)
print("  照合 %d 件、不一致 %d 件" % (cnt, bad))

# ==========================================================================
# 塔の計算
# ==========================================================================

_TOWER_CACHE = {}

def tower_ords(m, edges, ell, nmax):
    """ord_ell(kappa_n) の list（n = 0..nmax）。塔が非連結な段は None。"""
    key = (m, tuple(sorted((u, v, a, b) for (u, v, (a, b)) in edges)), ell, nmax)
    if key in _TOWER_CACHE:
        return _TOWER_CACHE[key]
    out = _tower_ords_raw(m, edges, ell, nmax)
    _TOWER_CACHE[key] = out
    return out

def _tower_ords_raw(m, edges, ell, nmax):
    D = detL(m, edges)
    k0 = kappa_derived(m, edges, 1, 1)
    out = []
    for n in range(nmax + 1):
        N = ell**n
        if not connected_by_lattice(m, edges, N, N):
            out.append(None); continue
        pr = prod_nontrivial_resultant(D, N, N)
        if pr == 0:
            out.append(None); continue
        val = ZZ(k0 * pr)
        out.append(ZZ(val).valuation(ell) - 2 * n)
    return out

def fit5(ell, ns, vals):
    """[ell^{2n}, n ell^n, ell^n, n, 1] で fit（ns は 5 個）。"""
    M = matrix(QQ, [[ell**(2 * n), n * ell**n, ell**n, n, 1] for n in ns])
    v = vector(QQ, vals)
    return M.solve_right(v)

# ==========================================================================
# Step 6  DuBose-Vallieres Section 7 の 5 例の再現（外部照合）
# ==========================================================================
print()
print("### Step 6  DuBose-Vallieres (Algebr. Comb. 6 (2023) 1331-1346) Section 7 の再現")
print("    論文の表 ord_ell(kappa_n) と、本スクリプトの (★) 経由の計算を突き合わせる。")
DV_DATA = [
    # (論文の例番号, ell, m, edges, 論文の表 n=1.., 論文の公式（文字列）, 公式の適用範囲)
    ('(1)', 2, 1, [(0, 0, (1, 0)), (0, 0, (0, 1))],
     [5, 19, 61, 167, 417, 987], '2*n*2^n + 4*2^n - 6*n - 1', 1),
    ('(2)', 2, 1, [(0, 0, (1, 0)), (0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (0, 1))],
     [8, 34, 124, 422, 1440, 5082], '2^(2*n) + 2*n*2^n + 4*2^n - 6*n - 2', 1),
    ('(3)', 2, 1, [(0, 0, (1, 5)), (0, 0, (0, 3)), (0, 0, (1, 2)), (0, 0, (0, 1))],
     [5, 19, 65, 179, 403, 887], 'n*2^n + 33/4*2^n - 4*n - 1', 4),
    ('(4)', 3, 1, [(0, 0, (1, 0)), (0, 0, (0, 1))],
     [6, 28, 98, 312], '4*3^n - 2*n - 4', 1),
    ('(5)', 3, 1, [(0, 0, (1, 0)), (0, 0, (2, 3)), (0, 0, (1, 1))],
     [10, 48, 166, 524], '20/3*3^n - 2*n - 8', 1),
]
allok = True
for (tag, ell, m, edges, table, formula, n0) in DV_DATA:
    nmax = len(table)
    t = time.time()
    ours = tower_ords(m, edges, ell, nmax)
    ok_table = all(ours[n] == table[n - 1] for n in range(1, nmax + 1))
    n = var('n')
    fexpr = sage_eval(formula, locals={'n': n})
    ok_form = all(ZZ(fexpr.subs(n=k)) == table[k - 1] for k in range(n0, nmax + 1))
    print("  例 %s ell=%d: 本計算 n=1..%d -> %s" % (tag, ell, nmax, ours[1:]))
    print("      論文の表と一致: %s / 論文の公式(n>=%d)が表を再現: %s / 公式 %s  [%.1fs]"
          % (ok_table, n0, ok_form, formula, time.time() - t))
    allok = allok and ok_table and ok_form
print("  5 例すべて一致: %s" % allok)

# ==========================================================================
# Step 7  ell^{2n} の係数 a と v_ell(content) の比較
# ==========================================================================
print()
print("### Step 7  fit した a（ell^{2n} の係数）と mu = v_ell(content_{z,w} det L) の比較")
print("    fit は最大の 5 段 [n_max-4 .. n_max] で行い、それより小さい n で検算する。")
print("    列: ell | mu=v_ell(content) | a | b(n*ell^n) | c(ell^n) | d(n) | e | 小さい n での検算")
rows = 0; mismatch = 0; valid = 0; invalid = 0
targets = []
for (name, m, edges) in EX:
    for ell in [2, 3]:
        targets.append((name, m, edges, ell))
for (name, m, edges) in RAND[:12]:
    for ell in [2, 3]:
        targets.append((name, m, edges, ell))
targets.append(('DV1 = トーラス', 1, [(0, 0, (1, 0)), (0, 0, (0, 1))], 5))
targets.append(('DV1 = トーラス', 1, [(0, 0, (1, 0)), (0, 0, (0, 1))], 7))
targets.append(('bouquet (1,0),(0,1),(1,1)', 1,
                [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (1, 1))], 5))

# 塔の段数の上限（(★_2) の右辺を 2 段終結式で厳密計算する時間の都合）
NMAX = {2: 6, 3: 4, 5: 3, 7: 2}

for (name, m, edges, ell) in targets:
    D = detL(m, edges)
    if D == 0:
        print("  %-52s ell=%d: det L = 0（全段非連結）→ 対象外" % (name[:52], ell))
        continue
    if not connected_by_lattice(m, edges, ell, ell):
        print("  %-52s ell=%d: X_{ell,ell} 非連結（ell | 基本閉路格子の指数）→ 対象外"
              % (name[:52], ell))
        continue
    nmax = NMAX[ell]
    if nmax < 5:
        print("  %-52s ell=%d: 段数 %d では 5 係数を fit できない → Step 8 で扱う"
              % (name[:52], ell, nmax))
        continue
    ords = tower_ords(m, edges, ell, nmax)
    if any(o is None for o in ords[1:]):
        print("  %-52s ell=%d: 途中の段が退化 → 対象外" % (name[:52], ell))
        continue
    ns = list(range(nmax - 4, nmax + 1))
    co = fit5(ell, ns, [ords[n] for n in ns])
    mu = mu_content(D, ell)
    chk = [(n, ords[n], QQ(co[0] * ell**(2 * n) + co[1] * n * ell**n + co[2] * ell**n
                            + co[3] * n + co[4])) for n in range(1, ns[0])]
    chkok = all(ZZ(a) == b for (n, a, b) in chk) if chk else None
    rows += 1
    if chkok is False:
        # fit 窓 [n_max-4 .. n_max] が漸近域に入っていない（n_0 > n_max-4）。
        # このとき fit の係数は意味をもたないので a と mu の比較対象にしない。
        invalid += 1
        flag = "  <<< fit 無効（out-of-sample 検算が失敗 = 漸近域に未到達）"
    elif co[0] != mu:
        mismatch += 1
        flag = "  <<< a != mu"
    else:
        valid += 1
        flag = ""
    print("  %-52s ell=%d | mu=%d | a=%s b=%s c=%s d=%s e=%s | fit外の n%s: %s%s"
          % (name[:52], ell, mu, co[0], co[1], co[2], co[3], co[4],
             [n for (n, _, _) in chk], chkok, flag))
    if chkok is False and co[0] not in ZZ:
        print("      （参考: a=%s は整数でない。文献 [Monsky Remark 2 / Cuoco-Monsky Def 1.1] は"
              " ell^{2n} の係数が非負整数であると述べているので、これは fit 窓が"
              "漸近域に入っていないことの徴候である。）" % co[0])
print("  対象 %d 件: fit が out-of-sample 検算を通った %d 件（うち a != v_ell(content) は %d 件）、"
      "検算が失敗して fit が無効な %d 件" % (rows, valid + mismatch, mismatch, invalid))
print("  注: fit は 5 点から 5 係数を解いたものであり、それ自体は証明ではない。")

# ==========================================================================
# Step 8  非退化条件と閉形式
# ==========================================================================
print()
print("### Step 8  非退化条件（H が P^1(F_ell) 上に零点をもたない）と閉形式")
print("    非退化なら ord_ell(kappa_n) = mu*ell^{2n} + k(ell+1)/(ell-1)*ell^n - 2n + nu")
print("    （nu は最大の n で 1 回だけ決め、他の全ての n で照合する）")
cnt = ndg = bad = 0
for (name, m, edges, ell) in targets:
    D = detL(m, edges)
    if D == 0 or not connected_by_lattice(m, edges, ell, ell):
        continue
    (k, H, badpts) = is_nondegenerate(D, ell)
    if k is None:
        continue
    nmax = NMAX[ell]
    ords = tower_ords(m, edges, ell, nmax)
    if any(o is None for o in ords[1:]):
        continue
    mu = mu_content(D, ell)
    cnt += 1
    tag = "非退化" if len(badpts) == 0 else ("退化 " + ",".join(badpts))
    if len(badpts) == 0:
        ndg += 1
        pred = lambda n: QQ(mu) * ell**(2 * n) + QQ(k) * (ell + 1) / (ell - 1) * ell**n - 2 * n
        nu = QQ(ords[nmax]) - pred(nmax)
        ok = all(QQ(ords[n]) == pred(n) + nu for n in range(1, nmax + 1))
        if not ok:
            bad += 1
        print("  %-46s ell=%d k=%d mu=%d %-22s -> 閉形式 一致=%s (nu=%s, n=1..%d)"
              % (name[:46], ell, k, mu, tag, ok, nu, nmax))
    else:
        print("  %-46s ell=%d k=%d mu=%d %-22s -> （定理の射程外）"
              % (name[:46], ell, k, mu, tag))
print("  判定 %d 件、うち非退化 %d 件、非退化で閉形式が破れた件数 %d" % (cnt, ndg, bad))

# ==========================================================================
# Step 9  点ごとの付値（中心となる補題の直接確認）
# ==========================================================================
print()
print("### Step 9  非退化なら v_ell(det L(zeta,xi)) = mu + k/phi(ell^max(i,j))")
print("    （ord zeta = ell^i, ord xi = ell^j, i,j >= 1, phi(ell^max) > k のとき）")
print("    円分体 Q(zeta_{ell^n}) の ell の上の唯一の素イデアルで直接計算する。")
cnt = bad = skipped = 0
for (name, m, edges, ell) in targets:
    D = detL(m, edges)
    if D == 0 or not connected_by_lattice(m, edges, ell, ell):
        continue
    (k, H, badpts) = is_nondegenerate(D, ell)
    if k is None or len(badpts) > 0:
        continue
    nmax = 3 if ell == 2 else (2 if ell == 3 else 1)
    for n in range(1, nmax + 1):
        K = CyclotomicField(ell**n); g = K.gen()
        pr = K.ideal(ell).factor()[0][0]
        e = euler_phi(ell**n)      # 完全分岐: e = phi(ell^n), f = 1
        for a in range(ell**n):
            for b in range(ell**n):
                if a == 0 and b == 0:
                    continue
                za = g**a; xb = g**b
                if za == 1 or xb == 1:
                    continue
                i = ZZ(ell**n / gcd(a, ell**n)).valuation(ell)
                j = ZZ(ell**n / gcd(b, ell**n)).valuation(ell)
                mx = max(i, j)
                if euler_phi(ell**mx) <= k:
                    skipped += 1; continue
                val = K(D.subs({zL: za, wL: xb}))
                vv = QQ(val.valuation(pr)) / e
                predv = QQ(mu_content(D, ell)) + QQ(k) / euler_phi(ell**mx)
                cnt += 1
                if vv != predv:
                    bad += 1
                    if bad < 8:
                        print("  MISMATCH", name, ell, n, a, b, vv, predv)
print("  照合 %d 件、不一致 %d 件（phi(ell^max) <= k で対象外としたもの %d 件）"
      % (cnt, bad, skipped))

print()
print("=" * 78)
print("終了")
print("=" * 78)
