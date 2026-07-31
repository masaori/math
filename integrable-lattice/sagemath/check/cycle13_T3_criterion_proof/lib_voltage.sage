# cycle 13 / T3 Pure: 共通定義（voltage 多重グラフ・導来グラフ・voltage ラプラシアン）
#
# 記号は cycle12_T3_nonzero_mu_p/README.md §1 と同一にする。
#   底グラフ X: 頂点 {0,...,m-1}, 辺は三つ組 (u, v, a) の**リスト**（多重辺は重複で表す）。
#     u == v のときループ。a ∈ ℤ が voltage。向きは (u,i) — (v, i+a) の向きに固定。
#   導来グラフ X_N: 頂点 V×ℤ/N、辺 (u,v,a) は N 本 {(u,i),(v,i+a)} に持ち上がる。
#
# ここで定義するものは全て ℤ / ℤ[z,z^{-1}] / 有限体上の計算であり、ℝ・ℂ を使わない。
#
# 証明本体（outputs/reports/cycle13_T3_mu_content_criterion_proof.md）との記号対応:
#   voltage_index(m, edges)   … 本体 補題 C の g_X（基本閉路 voltage の gcd）。
#   weierstrass_mu_lambda     … 本体 定理 W の (μ, λ_W)。塔の λ は λ_W − 1。
#   prod_detL_nontrivial      … 本体 注 4.1 の終結式による ∏_{ζ≠1} D(ζ)。
#
# 本ライブラリは verify_star.sage / verify_criterion.sage から load される。
# 既存の proof_steps.sage は自足しており、本ライブラリを使わない（独立実装のまま残す）。

RLAU = LaurentPolynomialRing(ZZ, 'z')
zLau = RLAU.gen()
RPOL = PolynomialRing(ZZ, 'z')
zPol = RPOL.gen()
RT   = PolynomialRing(ZZ, 'T')
TT   = RT.gen()


def volt_laplacian(m, edges):
    """voltage ラプラシアン L(z) ∈ M_m(ℤ[z,z^{-1}])。"""
    L = matrix(RLAU, m, m)
    for (u, v, a) in edges:
        if u == v:
            L[u, u] += 2 - zLau**a - zLau**(-a)
        else:
            L[u, u] += 1
            L[v, v] += 1
            L[u, v] -= zLau**a
            L[v, u] -= zLau**(-a)
    return L


def detL(m, edges):
    """D(z) = det L(z) ∈ ℤ[z,z^{-1}]。"""
    return det(volt_laplacian(m, edges))


def laurent_to_poly(D):
    """D(z) = z^{-M} P(z)（P ∈ ℤ[z], P(0) ≠ 0）の (M, P) を返す。D = 0 なら (0, 0)。"""
    if D == 0:
        return (0, RPOL(0))
    expos = D.exponents()
    M = -min(expos)
    P = RPOL({e + M: ZZ(c) for e, c in zip(expos, D.coefficients())})
    return (M, P)


def content_z(D):
    """content_z(D) = D の Laurent 係数の gcd（D = 0 なら 0）。"""
    if D == 0:
        return ZZ(0)
    return gcd([ZZ(c) for c in D.coefficients()])


def prod_detL_nontrivial(D, N):
    """∏_{ζ^N=1, ζ≠1} D(ζ) を **厳密な整数として** 終結式で計算する。

    D(z) = z^{-M} P(z) と書くと
        ∏_{ζ≠1} D(ζ) = (∏_{ζ≠1} ζ)^{-M} · ∏_{ζ≠1} P(ζ).
    ∏_{ζ^N=1} ζ = (-1)^{N+1} なので ∏_{ζ≠1} ζ = (-1)^{N+1}。
    q_N(z) = (z^N-1)/(z-1) は monic なので Res(q_N, P) = ∏_{q_N(β)=0} P(β) = ∏_{ζ≠1} P(ζ)。
    """
    if N == 1:
        return ZZ(1)
    M, P = laurent_to_poly(D)
    if D == 0:
        return ZZ(0)
    q = RPOL((zPol**N - 1) // (zPol - 1))
    res = ZZ(q.resultant(P))
    sgn = ZZ(-1)**((N + 1) * M)
    return sgn * res


def kappa_derived(m, edges, N):
    """導来グラフ X_N の全域木数を Kirchhoff 行列式で厳密計算（定義からの直接計算）。
       非連結なら 0。(★) も (☆) も使わない。"""
    n = m * N
    Lap = matrix(ZZ, n, n)
    for (u, v, a) in edges:
        for i in range(N):
            x = i * m + u
            y = ((i + a) % N) * m + v
            if x == y:
                continue                      # 持ち上がってもループのまま = ラプラシアンに寄与しない
            Lap[x, x] += 1
            Lap[y, y] += 1
            Lap[x, y] -= 1
            Lap[y, x] -= 1
    if n == 1:
        return ZZ(1)
    return ZZ(Lap.delete_rows([0]).delete_columns([0]).det())


def num_components(m, edges, N):
    """X_N の連結成分数（union-find。グラフライブラリに依存しない）。"""
    n = m * N
    par = list(range(n))

    def find(x):
        while par[x] != x:
            par[x] = par[par[x]]
            x = par[x]
        return x

    for (u, v, a) in edges:
        for i in range(N):
            x, y = find(i * m + u), find(((i + a) % N) * m + v)
            if x != y:
                par[x] = y
    return len(set(find(x) for x in range(n)))


def voltage_index(m, edges):
    """サイクル空間の voltage が生成する ℤ の部分群 Γ = dℤ の生成元 d ≥ 0 を返す。
       （X が連結であることを仮定。全域木を BFS で取り、非木辺のサイクル voltage の gcd。）"""
    adj = [[] for _ in range(m)]
    for idx, (u, v, a) in enumerate(edges):
        adj[u].append((v, a, idx))
        adj[v].append((u, -a, idx))
    phi = [None] * m
    phi[0] = 0
    tree = set()
    stack = [0]
    while stack:
        u = stack.pop()
        for (v, a, idx) in adj[u]:
            if phi[v] is None:
                phi[v] = phi[u] + a
                tree.add(idx)
                stack.append(v)
    assert all(p is not None for p in phi), "X が非連結"
    d = ZZ(0)
    for idx, (u, v, a) in enumerate(edges):
        if idx in tree:
            continue
        d = gcd(d, ZZ(phi[u] + a - phi[v]))
    return d


def weierstrass_mu_lambda(D, ell):
    """f(T) = D(1+T) ∈ ℤ_ℓ[[T]] の Weierstrass 不変量 (μ, λ) を返す。

    D = z^{-M} P(z) で (1+T)^{-M} は Λ = ℤ_ℓ[[T]] の単元なので
    μ(f) = μ(P(1+T)), λ(f) = λ(P(1+T))。P(1+T) は ℤ[T] の有限次多項式なので厳密に計算できる。
    μ = min_k v_ℓ(a_k), λ = min{k : v_ℓ(a_k) = μ}。
    """
    M, P = laurent_to_poly(D)
    if D == 0:
        return (None, None)
    g = RT(P(1 + TT))
    coeffs = g.list()
    vals = [ZZ(c).valuation(ell) if c != 0 else Infinity for c in coeffs]
    mu = min(vals)
    lam = min(k for k, v in enumerate(vals) if v == mu)
    return (ZZ(mu), ZZ(lam))
