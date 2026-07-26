# cycle 14 / T3 Pure: Z_ell^2-塔（d=2）への拡張の各ステップを機械的に検証する。
#
# 対応する証明本体: outputs/reports/cycle14_T3_Zl2_tower_criterion.md
#
# 検証項目（いずれも「有限個の例での照合」であって証明ではない）:
#
#   Step 1  補題 A2（2 重 DFT ブロック対角化）:
#           charpoly(L_{X_{N,N'}}) = ∏_{ζ^N=1} ∏_{ξ^{N'}=1} charpoly(L(ζ,ξ))
#   Step 2  補題 B2 / C2（連結性）:
#           c(X_{N,N'}) = Σ_{ζ,ξ} dim ker L(ζ,ξ)
#           X_{N,N'} 連結 ⟺ Λ_X + (NZ × N'Z) = Z^2  （Λ_X = 基本閉路 voltage の生成する部分群）
#   Step 3  定理 1'（(★) の 2 変数版）:
#           N·N'·κ(X_{N,N'}) = κ(X)·∏_{(ζ,ξ)≠(1,1)} det L(ζ,ξ)   （非連結な段も含めて）
#   Step 4  主要項の係数:
#           ord_ℓ(κ_n) を a·ℓ^{2n} + b·n·ℓ^n + c·ℓ^n + d·n + e にフィットし、
#           a = μ := v_ℓ(content_{z,w} det L(z,w)) かどうかを見る
#   Step 5  定理 3'（単項式還元の場合の完全証明）の予測:
#           f₁ = ℓ^{-μ}·det L(1+T,1+S) の mod ℓ が T^a S^b × 単元 のとき
#           ord_ℓ(κ_n) = μ ℓ^{2n} + (a+b) n ℓ^n + O(ℓ^n)
#   Step 6  射程外の witness: ℓ∤N の段では content が支配しない
#
# 実行: sage zl2_tower.sage

import itertools
from collections import Counter

set_random_seed(20260726)

RL = LaurentPolynomialRing(ZZ, 'z,w'); zL, wL = RL.gens()
RP = PolynomialRing(ZZ, 'z,w');       zP, wP = RP.gens()
RT = PolynomialRing(ZZ, 'T,S');       TT, SS = RT.gens()

# ==========================================================================
# 基本構成
#   底グラフ X: 頂点 0..m-1、辺は (u, v, (a,b)) の list。
#   u == v はループ、(a,b) ∈ Z^2 が voltage。
# ==========================================================================

def volt_laplacian(m, edges):
    """2 変数 voltage ラプラシアン L(z,w) ∈ Mat_m(Z[z^±,w^±])。"""
    L = matrix(RL, m, m)
    for (u, v, ab) in edges:
        a, b = ab
        mon = zL**a * wL**b
        if u == v:
            L[u, u] += 2 - mon - mon**(-1)
        else:
            L[u, u] += 1
            L[v, v] += 1
            L[u, v] -= mon
            L[v, u] -= mon**(-1)
    return L


def derived_edges(m, edges, N, Np):
    """導来グラフ X_{N,N'} の辺 list。頂点番号は (i,j,u) -> (i*Np + j)*m + u。"""
    out = []
    for (u, v, ab) in edges:
        a, b = ab
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
        Lap[x, x] += 1
        Lap[y, y] += 1
        Lap[x, y] -= 1
        Lap[y, x] -= 1
    return Lap


def kappa_from_laplacian(Lap):
    """Kirchhoff: 1 行 1 列を除いた小行列式（頂点 1 個なら 1）。"""
    n = Lap.nrows()
    if n == 1:
        return ZZ(1)
    return Lap[1:, 1:].determinant()


def kappa_derived(m, edges, N, Np):
    nv = m * N * Np
    return kappa_from_laplacian(int_laplacian(nv, derived_edges(m, edges, N, Np)))


def n_components(nv, uedges):
    par = list(range(nv))
    def find(x):
        while par[x] != x:
            par[x] = par[par[x]]
            x = par[x]
        return x
    for (x, y) in uedges:
        rx, ry = find(x), find(y)
        if rx != ry:
            par[rx] = ry
    return len(set(find(x) for x in range(nv)))


def cycle_voltage_subgroup(m, edges):
    """全域木を 1 つ取り、非木辺の基本閉路 voltage β_e ∈ Z^2 を並べた行列（行が β_e）。
       X が非連結なら None を返す。"""
    adj = {}
    for idx, (u, v, ab) in enumerate(edges):
        adj.setdefault(u, []).append((v, ab, idx, +1))
        adj.setdefault(v, []).append((u, ab, idx, -1))
    h = {0: vector(ZZ, [0, 0])}
    tree = set()
    stack = [0]
    while stack:
        x = stack.pop()
        for (y, ab, idx, sgn) in adj.get(x, []):
            if y not in h and idx not in tree:
                h[y] = h[x] + sgn * vector(ZZ, list(ab))
                tree.add(idx)
                stack.append(y)
    if len(h) < m:
        return None                      # X が非連結
    rows = []
    for idx, (u, v, ab) in enumerate(edges):
        if idx in tree:
            continue
        rows.append(vector(ZZ, list(ab)) + h[u] - h[v])
    if not rows:
        rows = [vector(ZZ, [0, 0])]
    return matrix(ZZ, rows)


def connected_by_criterion(m, edges, N, Np):
    """判定: Λ_X + (NZ × N'Z) = Z^2 か。X が非連結なら False。"""
    B = cycle_voltage_subgroup(m, edges)
    if B is None:
        return False
    rows = [list(r) for r in B.rows()] + [[N, 0], [0, Np]]
    M = matrix(ZZ, rows)
    d = M.elementary_divisors()
    d = [x for x in d if x != 0]
    return len(d) == 2 and all(x == 1 for x in d)


# ==========================================================================
# det L(z,w) 周り
# ==========================================================================

def detL(m, edges):
    """det L(z,w) ∈ Z[z^±,w^±]。"""
    return volt_laplacian(m, edges).determinant()


def laurent_to_poly(D):
    """Laurent 多項式 D を z^r w^s * F(z,w)（F ∈ Z[z,w], z,w で割り切れない）に分解し F を返す。"""
    if D == 0:
        return RP(0)
    ed = D.exponents()
    rmin = min(e[0] for e in ed)
    smin = min(e[1] for e in ed)
    F = RP(0)
    for e, c in zip(ed, D.coefficients()):
        F += ZZ(c) * zP**(e[0] - rmin) * wP**(e[1] - smin)
    return F


def content_of(D):
    """content_{z,w}(D) ∈ Z_{>0}（D ≠ 0）。"""
    return gcd([ZZ(c) for c in D.coefficients()])


def shifted_poly(m, edges):
    """p(T,S) := F(1+T, 1+S) ∈ Z[T,S]（F は上の numerator polynomial）。"""
    F = laurent_to_poly(detL(m, edges))
    out = RT(0)
    for e, c in zip(F.exponents(), F.coefficients()):
        out += ZZ(c) * (1 + TT)**ZZ(e[0]) * (1 + SS)**ZZ(e[1])
    return out


def monomial_reduction_data(m, edges, ell):
    """f₁ mod ℓ が T^a S^b × 単元 か判定する。
       返り値 (is_monomial, a, b, mu)。det L = 0 なら None。"""
    D = detL(m, edges)
    if D == 0:
        return None
    mu = ZZ(content_of(D)).valuation(ell)
    p = shifted_poly(m, edges)
    Fl = GF(ell)
    RTl = PolynomialRing(Fl, 'T,S')
    pbar = RTl(p / ell**mu)
    exps = pbar.exponents()
    assert len(exps) > 0, "f_1 mod ell must be nonzero"
    a = min(e[0] for e in exps)
    b = min(e[1] for e in exps)
    ok = all(e[0] >= a and e[1] >= b for e in exps) and pbar.monomial_coefficient(
        RTl.gen(0)**a * RTl.gen(1)**b) != 0
    return (ok, ZZ(a), ZZ(b), mu)


# ==========================================================================
# ∏_{(ζ,ξ)≠(1,1)} det L(ζ,ξ) の厳密計算（終結式のみ、根号・数値なし）
#
#   D = z^r w^s F,  ζ,ξ は 1 の冪根なので z^r w^s の寄与は絶対値 1（v_ℓ = 0）。
#   ∏_{(ζ,ξ)≠(1,1)} F(ζ,ξ)
#     = [∏_{ζ^N=1, ζ≠1} G(ζ)] · [∏_{ξ^{N'}=1, ξ≠1} F(1,ξ)],
#   G(z) := Res_w(w^{N'}-1, F(z,w)) = ∏_{ξ^{N'}=1} F(z,ξ)
#   （w^{N'}-1 はモニックなので Res はそのまま値の積）。
# ==========================================================================

def prod_over_nontrivial(m, edges, N, Np):
    """∏_{(ζ,ξ)≠(1,1)} det L(ζ,ξ) の絶対値（0 なら 0）を返す。"""
    if N == 1 and Np == 1:
        return ZZ(1)                      # 空積
    D = detL(m, edges)
    if D == 0:
        return ZZ(0)
    F = laurent_to_poly(D)
    Rz = PolynomialRing(ZZ, 'z')
    zz = Rz.gen()
    Rw = PolynomialRing(ZZ, 'w')
    ww = Rw.gen()
    # part1 = ∏_{ζ≠1} ∏_{ξ} F(ζ,ξ)
    if N > 1:
        G = RP(wP**Np - 1).resultant(F, wP)
        G = Rz(G.polynomial(zP))          # G は w を含まない → z の 1 変数多項式へ
        if G == 0:
            return ZZ(0)
        AN = Rz((zz**N - 1) // (zz - 1))
        part1 = AN.resultant(G)
    else:
        part1 = ZZ(1)
    # part2 = ∏_{ξ≠1} F(1,ξ)
    if Np > 1:
        F1 = Rw(F.subs({zP: RP(1)}).polynomial(wP))
        if F1 == 0:
            return ZZ(0)
        ANp = Rw((ww**Np - 1) // (ww - 1))
        part2 = ANp.resultant(F1)
    else:
        part2 = ZZ(1)
    return abs(ZZ(part1) * ZZ(part2))


# ==========================================================================
# 例のカタログ
# ==========================================================================

EXAMPLES = []

def add(name, m, edges):
    EXAMPLES.append((name, m, edges))

# --- 本プロジェクトの L×L トーラス（1 頂点、voltage (1,0),(0,1) の 2 ループ）
add("torus:bouquet(1,0),(0,1)", 1, [(0, 0, (1, 0)), (0, 0, (0, 1))])
# --- 単項式還元が成立する族（ℓ=2 用、ℓ=3 用）
add("mono l=2:(1,0)+2x(0,1)", 1, [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (0, 1))])
add("mono l=3:(1,0)+3x(0,1)", 1, [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (0, 1)), (0, 0, (0, 1))])
# --- bouquet いろいろ
add("bouquet(1,0),(0,1),(1,1)", 1, [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (1, 1))])
add("bouquet(1,0),(0,1),(1,-1)", 1, [(0, 0, (1, 0)), (0, 0, (0, 1)), (0, 0, (1, -1))])
add("bouquet(2,0),(0,1),(1,1)", 1, [(0, 0, (2, 0)), (0, 0, (0, 1)), (0, 0, (1, 1))])
# --- cycle12 の例 1 を 2 方向化（2 頂点、平行 3 重辺 + 各頂点にループ）
add("cyc12ex1-2d", 2, [(0, 1, (0, 0)), (0, 1, (1, 0)), (0, 1, (2, 0)),
                       (0, 0, (0, 1)), (1, 1, (0, 1))])
add("cyc12ex1-2d'", 2, [(0, 1, (0, 0)), (0, 1, (1, 0)), (0, 1, (1, 1)),
                        (0, 0, (0, 1)), (1, 1, (1, 0))])
add("mu>0 mono l=2", 2, [(0, 1, (0, 0)), (0, 1, (2, 0)), (0, 1, (1, 1)), (0, 1, (1, 1)),
                        (0, 0, (1, 0)), (1, 1, (1, 0))])
add("2v-parallel4", 2, [(0, 1, (0, 0)), (0, 1, (1, 0)), (0, 1, (0, 1)), (0, 1, (1, 1))])
# --- 退化例
add("deg: rank1 voltage", 1, [(0, 0, (1, 0)), (0, 0, (2, 0))])          # Λ_X の階数 1
add("deg: disconnected X", 2, [(0, 0, (1, 0)), (1, 1, (0, 1))])         # X 非連結
add("deg: detL=0 (tree)", 2, [(0, 1, (1, 0))])                          # det L ≡ 0
add("deg: l=2 tower broken", 1, [(0, 0, (2, 0)), (0, 0, (0, 2)), (0, 0, (1, 1))])
# --- 3 頂点
add("3v-cycle", 3, [(0, 1, (0, 0)), (1, 2, (1, 0)), (2, 0, (0, 1)),
                    (0, 1, (1, 1)), (1, 2, (0, 0))])


def random_example(rng_max_m=3):
    m = ZZ.random_element(1, rng_max_m + 1)
    ne = ZZ.random_element(2, 6)
    edges = []
    for _ in range(ne):
        u = ZZ.random_element(0, m)
        v = ZZ.random_element(0, m)
        a = ZZ.random_element(-2, 3)
        b = ZZ.random_element(-2, 3)
        if u == v and (a, b) == (0, 0):
            a = 1
        edges.append((u, v, (a, b)))
    return (m, edges)


RANDOM = [random_example() for _ in range(30)]
ALL = [(nm, m, e) for (nm, m, e) in EXAMPLES] + \
      [("rand%02d" % i, m, e) for i, (m, e) in enumerate(RANDOM)]


# ==========================================================================
# Step 1: 補題 A2（2 重 DFT ブロック対角化）
# ==========================================================================

def step1():
    print("=" * 78)
    print("Step 1  補題 A2: charpoly(L_{X_{N,N'}}) = ∏_{ζ,ξ} charpoly(L(ζ,ξ))")
    total = 0
    bad = 0
    for (nm, m, edges) in ALL:
        for (N, Np) in [(1, 1), (2, 1), (1, 2), (2, 2), (2, 3), (3, 3), (4, 2)]:
            if m * N * Np > 40:
                continue
            M = lcm(N, Np)
            K = CyclotomicField(M) if M > 1 else QQ
            g = K.gen() if M > 1 else K(1)
            Kx = PolynomialRing(K, 'x')
            x = Kx.gen()
            Lap = int_laplacian(m * N * Np, derived_edges(m, edges, N, Np))
            lhs = Kx(Lap.charpoly())
            L = volt_laplacian(m, edges)
            rhs = Kx(1)
            for i in range(N):
                for j in range(Np):
                    ze = g**(M // N * i) if M > 1 else K(1)
                    xi = g**(M // Np * j) if M > 1 else K(1)
                    Le = matrix(K, m, m, [K(c.subs(z=ze, w=xi)) for c in L.list()])
                    rhs *= (x * identity_matrix(K, m) - Le).determinant()
            total += 1
            if lhs != rhs:
                bad += 1
                print("  MISMATCH", nm, N, Np)
    print("  検査 %d 件、不一致 %d 件" % (total, bad))
    return bad


# ==========================================================================
# Step 2: 補題 B2 / C2（連結性）
# ==========================================================================

def step2():
    print("=" * 78)
    print("Step 2  補題 B2: c(X_{N,N'}) = Σ_{ζ,ξ} dim ker L(ζ,ξ) / 補題 C2: 部分群判定")
    tot = 0
    badB = 0
    badC = 0
    ncon = 0
    for (nm, m, edges) in ALL:
        for (N, Np) in [(1, 1), (2, 2), (2, 3), (3, 2), (3, 3), (4, 4), (2, 4), (5, 5), (6, 4)]:
            if m * N * Np > 120:
                continue
            nv = m * N * Np
            ue = derived_edges(m, edges, N, Np)
            c_true = n_components(nv, ue)
            M = lcm(N, Np)
            K = CyclotomicField(M) if M > 1 else QQ
            g = K.gen() if M > 1 else K(1)
            L = volt_laplacian(m, edges)
            s = 0
            for i in range(N):
                for j in range(Np):
                    ze = g**(M // N * i) if M > 1 else K(1)
                    xi = g**(M // Np * j) if M > 1 else K(1)
                    Le = matrix(K, m, m, [K(c.subs(z=ze, w=xi)) for c in L.list()])
                    s += m - Le.rank()
            tot += 1
            if s != c_true:
                badB += 1
                print("  MISMATCH-B", nm, N, Np, c_true, s)
            if connected_by_criterion(m, edges, N, Np) != (c_true == 1):
                badC += 1
                print("  MISMATCH-C", nm, N, Np)
            if c_true > 1:
                ncon += 1
    print("  検査 %d 件（うち非連結 %d 件）、補題 B2 不一致 %d 件、補題 C2 不一致 %d 件"
          % (tot, ncon, badB, badC))
    return badB + badC


# ==========================================================================
# Step 3: 定理 1'（(★) の 2 変数版）
# ==========================================================================

def step3():
    print("=" * 78)
    print("Step 3  定理 1': N·N'·κ(X_{N,N'}) = κ(X)·∏_{(ζ,ξ)≠(1,1)} det L(ζ,ξ)")
    print("        （左辺は導来グラフの Kirchhoff 余因子、右辺は終結式。独立計算）")
    tot = 0
    bad = 0
    ndegen = 0
    for (nm, m, edges) in ALL:
        kX = kappa_from_laplacian(int_laplacian(m, [(u, v) for (u, v, _) in edges]))
        for (N, Np) in [(1, 1), (2, 1), (1, 2), (2, 2), (2, 3), (3, 3), (3, 4), (4, 4), (5, 3), (2, 6)]:
            if m * N * Np > 220:
                continue
            lhs = N * Np * kappa_derived(m, edges, N, Np)
            rhs = kX * prod_over_nontrivial(m, edges, N, Np)
            tot += 1
            if lhs == 0:
                ndegen += 1
            if abs(lhs) != abs(rhs):
                bad += 1
                print("  MISMATCH", nm, N, Np, lhs, rhs)
    print("  検査 %d 件（うち両辺 0 の退化 %d 件）、不一致 %d 件" % (tot, ndegen, bad))
    return bad


# ==========================================================================
# Step 4/5: 塔の漸近と主要項の係数
# ==========================================================================

def ord_kappa_tower(m, edges, ell, n, kX):
    """ord_ℓ(κ_n) を定理 1'（終結式）経由で計算。κ_n = 0 なら None。"""
    N = ell**n
    P = prod_over_nontrivial(m, edges, N, N)
    if P == 0:
        return None
    return ZZ(kX).valuation(ell) - 2 * n + ZZ(P).valuation(ell)


def fit_greenberg_with_start(ell, data):
    """(係数ベクトル, 乗り始める n) を返す。過剰決定（6 点以上）でなければ None。"""
    for st in range(0, max(1, len(data) - 5)):
        sub = data[st:]
        if len(sub) < 6:
            break
        A = matrix(QQ, [[ell**(2 * n), n * ell**n, ell**n, n, 1] for (n, _) in sub])
        v = vector(QQ, [o for (_, o) in sub])
        try:
            x = A.solve_right(v)
        except ValueError:
            continue
        if A * x == v:
            return (x, sub[0][0])
    return None


def fit_greenberg(ell, data):
    """data の末尾側の suffix（点が 6 個以上＝**過剰決定**）が
       a·ℓ^{2n}+b·n·ℓ^n+c·ℓ^n+d·n+e に厳密に乗るときだけ係数ベクトルを返す。
       5 点ちょうどの解は常に存在してしまい情報がないので採らない。"""
    for s in range(0, max(1, len(data) - 5)):
        sub = data[s:]
        if len(sub) < 6:
            break
        A = matrix(QQ, [[ell**(2 * n), n * ell**n, ell**n, n, 1] for (n, _) in sub])
        v = vector(QQ, [o for (_, o) in sub])
        try:
            x = A.solve_right(v)
        except ValueError:
            continue
        if A * x == v:
            return x
    return None


def G_seq(E, ell, target):
    """G_n := (E_n - target·n·ℓ^n)/ℓ^n （定理 3' が主張する O(1) 部分）。"""
    return [QQ(e - target * n * ell**n) / QQ(ell**n) for (n, e) in E if n >= 1]


def bounded_G(E, ell, target):
    """G_n の増分が増大していないか（有界性の**代理**判定。有限項から有界性は決まらない）。"""
    G = G_seq(E, ell, target)
    if len(G) < 3:
        return None
    d = [abs(G[i + 1] - G[i]) for i in range(len(G) - 1)]
    return d[-1] <= max(d[:-1])


def tower_data(m, edges, ell, nmax, kX):
    data = []
    for n in range(0, nmax + 1):
        o = ord_kappa_tower(m, edges, ell, n, kX)
        if o is None:
            return None
        data.append((n, o))
    return data


def step45():
    print("=" * 78)
    print("Step 4  塔の漸近。以下の 3 つを見る（フィットではなく、証明した量そのもの）:")
    print("        E_n := ord_ℓ(κ_n) - v_ℓ(κ(X)) + 2n - (ℓ^{2n}-1)·μ  = Σ_{(ζ,ξ)≠(1,1)} v_ℓ(f₁)")
    print("        (i)  E_n ≥ 0                      … 証明した下界（定理 2'）")
    print("        (ii) E_n/ℓ^{2n} → 0（末尾 3 点で減少）… 主要項の係数 = μ の数値的支持")
    print("        (iii) 過剰決定フィット（点 6 個以上が厳密に乗るか）")
    print("Step 5  単項式還元 (f₁ mod ℓ = T^a S^b × 単元) の例では")
    print("        G_n := (E_n - (a+b)·n·ℓ^n)/ℓ^n が有界（増分が縮小）かを照合 = 定理 3'")
    print()
    hdr = ("%-24s %2s %-27s %4s %-22s %-8s %s" %
           ("graph", "l", "ord_l(kappa_n) n=0..nmax", "mu", "E_n/l^{2n} n=1..nmax",
            "mono(a,b)", "fit(a,b) or -"))
    print(hdr)
    print("-" * len(hdr))
    n_lower_ok = 0
    n_lower_bad = 0
    n_ratio_ok = 0
    n_ratio_bad = 0
    n_mono_ok = 0
    n_mono_bad = 0
    n_fit = 0
    n_fit_a_ok = 0
    rows = []
    for (nm, m, edges) in ALL:
        D = detL(m, edges)
        if D == 0:
            continue
        kX = kappa_from_laplacian(int_laplacian(m, [(u, v) for (u, v, _) in edges]))
        if kX == 0:
            continue
        for ell in [2, 3, 5]:
            if not connected_by_criterion(m, edges, ell, ell):
                continue
            nmax = {2: 7, 3: 4, 5: 3}[ell]
            data = tower_data(m, edges, ell, nmax, kX)
            if data is None:
                continue
            mu = ZZ(content_of(D)).valuation(ell)
            vkX = ZZ(kX).valuation(ell)
            E = [(n, o - vkX + 2 * n - (ell**(2 * n) - 1) * mu) for (n, o) in data]
            if all(e >= 0 for (_, e) in E):
                n_lower_ok += 1
            else:
                n_lower_bad += 1
                print("  LOWER-BOUND VIOLATION", nm, ell, E)
            ratios = [QQ(e) / QQ(ell**(2 * n)) for (n, e) in E if n >= 1]
            # a = μ なら E_n = o(ℓ^{2n})。末尾 3 点で減少していることを見る。
            if len(ratios) >= 3 and ratios[-1] < ratios[-2] < ratios[-3]:
                n_ratio_ok += 1
            else:
                n_ratio_bad += 1
                print("  RATIO-NOT-DECREASING", nm, ell, ratios)
            mono = monomial_reduction_data(m, edges, ell)
            monostr = "-"
            if mono is not None and mono[0]:
                monostr = "(%d,%d)" % (mono[1], mono[2])
                gs = G_seq(E, ell, mono[1] + mono[2])
                print("  [mono] %s ell=%d (a,b)=(%d,%d) mu=%d  G_n=%s"
                      % (nm, ell, mono[1], mono[2], mu,
                         ["%.3f" % float(x) for x in gs]))
                if bounded_G(E, ell, mono[1] + mono[2]):
                    n_mono_ok += 1
                else:
                    n_mono_bad += 1
                    print("  MONO-G-INCREMENT-GROWING", nm, ell, gs)
            fit = fit_greenberg(ell, data)
            fitstr = "-"
            if fit is not None:
                n_fit += 1
                fitstr = "(%s,%s)" % (fit[0], fit[1])
                if fit[0] == mu:
                    n_fit_a_ok += 1
                else:
                    print("  FIT-A-MISMATCH", nm, ell, fit[0], mu)
            rows.append((nm, ell, data, mu, ratios, monostr, fitstr))
    for (nm, ell, data, mu, ratios, monostr, fitstr) in rows:
        s = ",".join(str(o) for (_, o) in data)
        if len(s) > 27:
            s = s[:24] + "..."
        r = ",".join("%.3f" % float(x) for x in ratios)
        if len(r) > 22:
            r = r[:19] + "..."
        print("%-24s %2d %-27s %4s %-22s %-8s %s"
              % (nm[:24], ell, s, mu, r, monostr, fitstr))
    print()
    print("  (i)  下界 E_n ≥ 0: 成立 %d 塔 / 違反 %d 塔" % (n_lower_ok, n_lower_bad))
    print("  (ii) E_n/ℓ^{2n} が末尾 3 点で減少: %d 塔 / 減少せず %d 塔" % (n_ratio_ok, n_ratio_bad))
    print("  (iii) 6 点以上が厳密に乗った塔: %d 塔、うち a = μ が %d 塔" % (n_fit, n_fit_a_ok))
    print("  Step 5 単項式還元の塔で G_n の増分が縮小: %d / しない %d"
          % (n_mono_ok, n_mono_bad))
    return n_lower_bad + n_mono_bad + (n_fit - n_fit_a_ok)


def step5b():
    """μ>0 かつ単項式還元をもつ 2 頂点の例を探索し、定理 3' の予測を照合する。"""
    print("=" * 78)
    print("Step 5b μ>0 かつ単項式還元をもつ例の探索（2 頂点、平行辺 + ループ）")
    found = []
    tested = 0
    # 2 頂点 u=0, v=1。平行辺の voltage 多重集合 A ⊂ {(0,0),(1,0),(2,0),(0,1),(1,1)}、
    # 各頂点にループ voltage を付ける。
    par_cands = [(0, 0), (1, 0), (2, 0), (0, 1), (1, 1)]
    loop_cands = [(1, 0), (0, 1), (1, 1)]
    for k in [3, 4]:
        for A in itertools.combinations_with_replacement(par_cands, k):
            for lu in itertools.combinations_with_replacement(loop_cands, 1):
                for lv in itertools.combinations_with_replacement(loop_cands, 1):
                    edges = [(0, 1, a) for a in A] + [(0, 0, lu[0]), (1, 1, lv[0])]
                    tested += 1
                    D = detL(2, edges)
                    if D == 0:
                        continue
                    c = content_of(D)
                    if c == 1:
                        continue
                    # 辺重複度 gcd が 1（＝自明な ℓ 重多重グラフでない）ものだけ
                    mult = Counter([(u, v, ab) for (u, v, ab) in edges])
                    if gcd(list(mult.values())) != 1:
                        continue
                    for ell in ZZ(c).prime_divisors():
                        if not connected_by_criterion(2, edges, ell, ell):
                            continue
                        mono = monomial_reduction_data(2, edges, ell)
                        if mono is None or not mono[0] or mono[3] == 0:
                            continue
                        found.append((edges, ell, mono))
    print("  検査 %d 件、μ>0 かつ単項式還元の例 %d 件" % (tested, len(found)))
    nok = 0
    nbad = 0
    for (edges, ell, mono) in found[:6]:
        kX = kappa_from_laplacian(int_laplacian(2, [(u, v) for (u, v, _) in edges]))
        nmax = 6 if ell == 2 else 3
        data = tower_data(2, edges, ell, nmax, kX)
        if data is None:
            continue
        mu = mono[3]
        vkX = ZZ(kX).valuation(ell)
        E = [(n, o - vkX + 2 * n - (ell**(2 * n) - 1) * mu) for (n, o) in data]
        target = mono[1] + mono[2]
        ok = all(e >= 0 for (_, e) in E) and bounded_G(E, ell, target)
        nok += 1 if ok else 0
        nbad += 0 if ok else 1
        print("    edges=%s\n      ell=%d mu=%d (a,b)=(%d,%d) ord=%s\n      G_n=%s  %s"
              % (edges, ell, mu, mono[1], mono[2],
                 [o for (_, o) in data],
                 ["%.3f" % float(x) for x in G_seq(E, ell, target)],
                 "OK" if ok else "NG"))
    print("  照合 OK %d / NG %d" % (nok, nbad))
    return nbad


def step45_direct():
    """(★) を使わずに導来グラフを直接構成して κ_n を求め、終結式経由の値と照合。"""
    print("=" * 78)
    print("Step 4c ord_ℓ(κ_n) の独立計算（導来グラフ直接 vs 終結式）")
    tot = 0
    bad = 0
    for (nm, m, edges) in ALL:
        D = detL(m, edges)
        if D == 0:
            continue
        kX = kappa_from_laplacian(int_laplacian(m, [(u, v) for (u, v, _) in edges]))
        if kX == 0:
            continue
        for ell in [2, 3]:
            for n in range(0, 5):
                N = ell**n
                if m * N * N > 260:
                    continue
                k = kappa_derived(m, edges, N, N)
                o2 = ord_kappa_tower(m, edges, ell, n, kX)
                tot += 1
                if k == 0:
                    if o2 is not None:
                        bad += 1
                        print("  MISMATCH(0)", nm, ell, n)
                else:
                    if o2 is None or ZZ(k).valuation(ell) != o2:
                        bad += 1
                        print("  MISMATCH", nm, ell, n, ZZ(k).valuation(ell), o2)
    print("  検査 %d 件、不一致 %d 件" % (tot, bad))
    return bad


# ==========================================================================
# Step 6: ℓ∤N の段では content が支配しない（射程外の witness）
# ==========================================================================

def step6():
    print("=" * 78)
    print("Step 6  射程外: μ=0 なのに ℓ∤(N,N') の段で v_ℓ(κ(X_{N,N'}))>0 になる witness")
    found = []
    tested = 0
    for (nm, m, edges) in ALL:
        D = detL(m, edges)
        if D == 0:
            continue
        for ell in [2, 3, 5]:
            mu = ZZ(content_of(D)).valuation(ell)
            if mu != 0:
                continue
            for (N, Np) in [(3, 3), (5, 5), (3, 5), (4, 4), (2, 2), (7, 7)]:
                if N % ell == 0 or Np % ell == 0:
                    continue
                if m * N * Np > 220:
                    continue
                tested += 1
                k = kappa_derived(m, edges, N, Np)
                if k != 0 and ZZ(k).valuation(ell) > 0:
                    found.append((nm, ell, N, Np, ZZ(k).valuation(ell)))
    print("  検査 %d 件、witness %d 件（先頭 8 件）:" % (tested, len(found)))
    for r in found[:8]:
        print("    graph=%s  ell=%d  (N,N')=(%d,%d)  content の v_ell=0 だが v_ell(kappa)=%d"
              % (r[0], r[1], r[2], r[3], r[4]))
    return 0


def step7():
    """明示例について、過剰決定フィットが厳密に乗るときの係数 (a,b,c,d,e) を全部出す。"""
    print("=" * 78)
    print("Step 7  明示例の Greenberg 係数（6 点以上が厳密に乗った塔のみ）")
    print("        ord_ℓ(κ_n) = a·ℓ^{2n} + b·n·ℓ^n + c·ℓ^n + d·n + e")
    for (nm, m, edges) in EXAMPLES:
        D = detL(m, edges)
        if D == 0:
            continue
        kX = kappa_from_laplacian(int_laplacian(m, [(u, v) for (u, v, _) in edges]))
        if kX == 0:
            continue
        for ell in [2, 3]:
            if not connected_by_criterion(m, edges, ell, ell):
                continue
            nmax = {2: 7, 3: 4}[ell]
            data = tower_data(m, edges, ell, nmax, kX)
            if data is None:
                continue
            fw = fit_greenberg_with_start(ell, data)
            if fw is None:
                continue
            fit, nstart = fw
            mu = ZZ(content_of(D)).valuation(ell)
            print("    %-26s ell=%d nmax=%d  mu=%d  (a,b,c,d,e)=(%s)  n>=%d で厳密  a==mu: %s"
                  % (nm, ell, nmax, mu, ",".join(str(x) for x in fit), nstart, fit[0] == mu))
    return 0


# ==========================================================================
if __name__ == '__main__':
    print("SageMath による cycle 14 / T3（Z_ell^2-塔）検証")
    print("例: 明示 %d 件 + 乱択 %d 件 = %d 件" % (len(EXAMPLES), len(RANDOM), len(ALL)))
    print()
    nbad = 0
    nbad += step1()
    nbad += step2()
    nbad += step3()
    nbad += step45()
    nbad += step5b()
    nbad += step45_direct()
    nbad += step6()
    nbad += step7()
    print("=" * 78)
    print("総不一致: %d" % nbad)
