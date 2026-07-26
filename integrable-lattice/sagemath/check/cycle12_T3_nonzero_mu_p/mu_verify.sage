# cycle 12 / T3 Pure: μ_ℓ > 0 の具体例の独立検証。
#
# mu_search.sage は判定基準 (☆) μ_ℓ = v_ℓ(content_z(det L(z))) だけで候補を出した。
# ここでは (☆) を一切使わず、abelian ℓ-tower の各段 X_{ℓ^n} を実際に多重グラフとして構成し、
# Kirchhoff（matrix-tree）行列式で全域木数 κ_n ∈ ℤ を厳密に計算して
#     v_ℓ(κ_n) = μ ℓ^n + λ n + ν
# にフィットさせる。フィット（および閉形式との一致）は証拠であって証明ではない。

R = LaurentPolynomialRing(ZZ, 'z')
z = R.gen()

def volt_laplacian(m, edges):
    L = matrix(R, m, m)
    for (u, v, a) in edges:
        if u == v:
            L[u, u] += 2 - z**a - z**(-a)
        else:
            L[u, u] += 1; L[v, v] += 1
            L[u, v] -= z**a; L[v, u] -= z**(-a)
    return L

def content_of(f):
    return gcd([ZZ(c) for c in f.coefficients()])

def kappa_derived(m, edges, N):
    """導来グラフ X_N（頂点 V×ℤ/N）の全域木数を Kirchhoff 行列式で厳密計算。
       (☆) も (★) も使わない、定義からの直接計算。非連結なら 0 を返す。"""
    n = m * N
    Lap = matrix(ZZ, n, n)
    for (u, v, a) in edges:
        for i in range(N):
            x = i * m + u
            y = ((i + a) % N) * m + v
            if x == y:
                continue          # voltage 0 のループはラプラシアンに寄与しない
            Lap[x, x] += 1; Lap[y, y] += 1
            Lap[x, y] -= 1; Lap[y, x] -= 1
    return Lap.delete_rows([0]).delete_columns([0]).det()

def report(name, m, edges, primes_and_levels):
    D = det(volt_laplacian(m, edges))
    cont = content_of(D)
    print("\n" + "-" * 78)
    print(f"[{name}]")
    print(f"  底グラフ: 頂点 {m} 個, 辺(voltage 付き) = {edges}")
    print(f"  voltage ラプラシアン det L(z) = {D}")
    print(f"  content = {factor(cont)}   → 判定基準(☆)の予測 μ_ℓ = v_ℓ(content)")
    print(f"  κ(X_1) = {kappa_derived(m, edges, 1)}  (底グラフ自身の全域木数)")
    for (ell, nmax) in primes_and_levels:
        print(f"\n  ── ℓ = {ell} の塔 X_1 ⊂ X_ℓ ⊂ … ⊂ X_(ℓ^{nmax}) ──")
        rows = []
        for n in range(nmax + 1):
            N = ell**n
            k = kappa_derived(m, edges, N)
            assert k > 0, f"X_{N} が非連結 (κ=0)"
            rows.append((n, N, k, ZZ(k).valuation(ell)))
        print(f"    {'n':>2} {'N=ℓ^n':>7} {'v_ℓ(κ_n)':>10}   κ_n")
        for (n, N, k, v) in rows:
            ks = str(k)
            if len(ks) > 42:
                ks = ks[:20] + "…" + ks[-15:] + f" ({len(ks)} 桁)"
            print(f"    {n:>2} {N:>7} {v:>10}   {ks}")
        # 最後の 3 点から (μ, λ, ν) を解き、全 n で照合
        if len(rows) >= 3:
            A = matrix(QQ, 3, 3, [[rows[-3][1], rows[-3][0], 1],
                                  [rows[-2][1], rows[-2][0], 1],
                                  [rows[-1][1], rows[-1][0], 1]])
            b = vector(QQ, [rows[-3][3], rows[-2][3], rows[-1][3]])
            mu, lam, nu = A.solve_right(b)
            ok = all(mu * N + lam * n + nu == v for (n, N, k, v) in rows)
            print(f"    フィット: v_ℓ(κ_n) = {mu}·ℓ^n + {lam}·n + {nu}")
            print(f"    全 n=0..{nmax} で一致: {ok}   （予測 μ={ZZ(cont).valuation(ell)}, 一致={mu == ZZ(cont).valuation(ell)}）")
        # 閉形式 κ_n = κ(X_1)·N·c^{N-1} との照合（det L = c·(2-z-1/z) 型のとき）
        c0 = None
        if D == cont * (2 - z - z**(-1)) or D == -cont * (2 - z - z**(-1)):
            c0 = cont if D == cont * (2 - z - z**(-1)) else -cont
        if c0 is not None:
            k1 = rows[0][2]
            allok = all(k == k1 * N * abs(c0)**(N - 1) for (n, N, k, v) in rows)
            print(f"    閉形式 κ_n = κ(X_1)·N·|c|^(N-1)  (c={c0}) と全段一致: {allok}")

print("=" * 78)
print("μ_ℓ > 0 の具体例: abelian ℓ-tower の全域木数 κ_n を直接 matrix-tree で計算し検証")
print("=" * 78)

# 例 1: 2 頂点 + voltage 0,1,2 の平行 3 重辺 + 各頂点に voltage 1 のループ 1 本
#   det L(z) = 12(2 - z - z^{-1}) → μ_2 = 2, μ_3 = 1
E1 = [(0, 1, 0), (0, 1, 1), (0, 1, 2), (0, 0, 1), (1, 1, 1)]
report("例1: A={0,1,2} 平行辺 + 各頂点にループ voltage 1", 2, E1,
       [(2, 6), (3, 4), (5, 2)])

# 例 2: 2 頂点 + voltage 0,1,1,2 の平行 4 重辺 + 各頂点に voltage 1 のループ 1 本
#   det L(z) = 16(2 - z - z^{-1}) → μ_2 = 4
E2 = [(0, 1, 0), (0, 1, 1), (0, 1, 1), (0, 1, 2), (0, 0, 1), (1, 1, 1)]
report("例2: A={0,1,1,2} 平行辺 + 各頂点にループ voltage 1", 2, E2,
       [(2, 6), (3, 3)])

# 例 3: content = 23（奇素数 ℓ=23 で μ=1）。辺重複度 gcd = 1。
E3 = [(0, 1, 0), (0, 1, 0), (0, 1, 1), (0, 1, 2), (0, 0, 1), (1, 1, 1), (1, 1, 1)]
report("例3: A={0,0,1,2} + loop@0={1} + loop@1={1,1}（content=23）", 2, E3,
       [(23, 1), (2, 4)])

# 例 4: 3 頂点の例（content = 2^4·3 = 48, 辺重複度 gcd = 1）
E4 = [(0, 1, 1), (0, 1, 1), (0, 2, 0), (0, 2, 1), (1, 2, 1), (1, 2, 1), (0, 0, 1), (2, 2, 1)]
report("例4: 3 頂点 (content=2^4·3=48)", 3, E4, [(2, 5), (3, 3)])

# 例 5: mu_large.sage の広域探索で見つかった ℓ=3 の非自明最大例（μ_3=2）。
#   det L に z^{±2} が出るため det L = c(2-z-1/z) 型ではなく、閉形式が使えない
#   ＝フィットだけで μ,λ,ν を決める例。
E6 = [(0, 1, 0), (0, 1, 0), (0, 1, 0), (0, 1, 1)] + [(0, 0, 1)] * 3 + [(1, 1, 1)] * 3
report("例5: A={0,0,0,1} + 各頂点にループ voltage 1 を 3 本（content=3^2）", 2, E6,
       [(3, 3), (2, 4)])

# 例 6: 最小級の例。2 頂点 + voltage {0,1} の平行 2 重辺 + 頂点 1 に voltage 1 のループ 2 本。
#   det L = -5(2 - z - 1/z) → μ_5 = 1。
E7 = [(0, 1, 0), (0, 1, 1), (1, 1, 1), (1, 1, 1)]
report("例6: A={0,1} + loop@v={1,1}（content=5, 最小級）", 2, E7, [(5, 2), (2, 4)])

# ------------------------------------------------------------------ μ の大きさ
print("\n" + "=" * 78)
print("μ_2 はいくらでも大きくできるか: 族 A={0,1,…,k-1}（平行 k 重辺）+ 各頂点にループ {1,…,(k-1)/2}")
print("=" * 78)
print(f"  {'k':>3} {'det L(z)':>34} {'content':>16} {'辺重複度gcd':>10} {'μ_2':>5} {'μ_3':>5}")
for k in [3, 5, 7, 9, 11, 13]:
    A = list(range(k))
    loops = list(range(1, (k - 1) // 2 + 1))
    edges = [(0, 1, a) for a in A] + [(0, 0, b) for b in loops] + [(1, 1, b) for b in loops]
    D = det(volt_laplacian(2, edges))
    cont = content_of(D)
    from collections import Counter
    cnt = Counter(tuple(sorted((u, v))) + (a,) for (u, v, a) in edges)
    mg = gcd(list(cnt.values()))
    Dstr = str(D)
    if len(Dstr) > 34:
        Dstr = Dstr[:31] + "..."
    print(f"  {k:>3} {Dstr:>34} {str(factor(cont)):>16} {mg:>10} {ZZ(cont).valuation(2):>5} {ZZ(cont).valuation(3):>5}")

print("\n  上記族の μ_2 が実際の κ_n と合うかを k=5 で直接検証:")
k = 5
A = list(range(k)); loops = [1, 2]
E5 = [(0, 1, a) for a in A] + [(0, 0, b) for b in loops] + [(1, 1, b) for b in loops]
report(f"族 k={k}", 2, E5, [(2, 5)])

print("\n" + "=" * 78)
print("注意（正直に）: 上の一致は数値的証拠であって証明ではない。")
print("  ・κ_n は厳密整数（Kirchhoff 行列式）だが、検証したのは有限個の n のみ。")
print("  ・μ ℓ^n + λ n + ν 型の漸近そのものはグラフ岩澤理論（既知）の定理に依拠している。")
print("=" * 78)
