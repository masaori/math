# cycle 16 / T1: kappa オフセットの厳密確認（d=2, unramified）。
#
# d=1 版（kappa_offset.sage）と同じ 2 候補を、本プロジェクトが実際に使う d=2 で区別する。
#   (K)  ord_p(kappa_{X_n}) = S_n - d*n + ord_p(kappa_X)                  … Kataoka Prop 4.4（不分岐）
#   (P)  ord_p(kappa_{X_n}) = S_n - d*n + ord_p(kappa_X) - ord_p(#V_X)    … 論文 001 現行の「規約の注意」
# ここで S_n = sum_{chi in Gamma_n^ \ {1}} ord_p(chi(det L_alpha))、Gamma_n = (Z/p^n)^2。
#
# S_n の計算は導来グラフを一切使わない独立経路にしてある:
#   円分体 Q(zeta_N) の中で prod_{(j,k) != (0,0)} detM(zeta^j, zeta^k) を厳密に積み、
#   有理整数へ落としてから p 進付値を取る。浮動小数点も Q_p も使わない。
# kappa は導来グラフの整数ラプラシアンの既約行列式（Matrix-Tree）で厳密整数計算。

R = LaurentPolynomialRing(ZZ, ['z', 'w'])
z, w = R.gens()


def voltage_laplacian(nv, edges):
    """L_alpha(z,w): 電圧 (a,b) in Z^2 付きグラフのラプラシアン（nv x nv）。
    edges = [(u, v, a, b)] は u -> v の辺で電圧 (a,b)。u == v はループ。"""
    M = matrix(R, nv, nv)
    for (u, v, a, b) in edges:
        t = z**a * w**b
        if u == v:
            M[u, u] += 2 - t - t**(-1)
        else:
            M[u, u] += 1
            M[v, v] += 1
            M[u, v] += -t
            M[v, u] += -t**(-1)
    return M


def derived_graph_laplacian(nv, edges, N):
    """導来グラフ X_n（Gamma_n = (Z/N)^2）の整数ラプラシアン。
    頂点 (v, g1, g2) を v*N*N + g1*N + g2 で番号付け。"""
    n = nv * N * N
    L = matrix(ZZ, n, n)
    for (u, v, a, b) in edges:
        for g1 in range(N):
            for g2 in range(N):
                i = u * N * N + g1 * N + g2
                j = v * N * N + ((g1 + a) % N) * N + ((g2 + b) % N)
                L[i, i] += 1
                L[j, j] += 1
                L[i, j] -= 1
                L[j, i] -= 1
    return L


def kappa(L):
    """Matrix-Tree: 全域木数（既約ラプラシアンの行列式）。厳密整数。"""
    n = L.nrows()
    if n == 1:
        return ZZ(1)
    return L.delete_rows([0]).delete_columns([0]).determinant()


def S_n_exact(Malpha, N, p):
    """S_n = sum_{chi != 1} ord_p(chi(det L_alpha))。
    prod_{(j,k) != (0,0)} detM(zeta^j, zeta^k) を円分体で厳密に積んで有理整数へ落とす。"""
    if N == 1:
        return ZZ(0)
    detM = Malpha.determinant()
    K = CyclotomicField(N)
    zt = K.gen()
    prod = K(1)
    for j in range(N):
        for k in range(N):
            if j == 0 and k == 0:
                continue
            val = K(0)
            for (e1, e2), c in detM.dict().items():
                val += K(c) * zt**((e1 * j) % N) * zt**((e2 * k) % N)
            prod *= val
    assert prod != 0, "X_n が非連結（chi != 1 で det が消えた）"
    r = QQ(prod)                 # 有理整数のはず（Galois 不変）
    assert r.denominator() == 1
    return ZZ(r).abs().valuation(p)


CASES = [
    # (名前, nv, edges, p)
    # #V_X が p で割れる例（(K) と (P) を区別できる）
    ("2頂点3重辺 電圧(0,0),(1,0),(0,1), p=2", 2,
     [(0, 1, 0, 0), (0, 1, 1, 0), (0, 1, 0, 1)], 2),
    ("4頂点閉路+弦 電圧付き, p=2", 4,
     [(0, 1, 0, 0), (1, 2, 1, 0), (2, 3, 0, 0), (3, 0, 0, 1), (0, 2, 0, 0)], 2),
    # 対照: #V_X = 1（L x L トーラス＝1頂点2ループ。ここでは (K) と (P) は一致する）
    ("bouquet(1頂点2ループ, 電圧(1,0),(0,1))… L x L トーラス, p=2", 1,
     [(0, 0, 1, 0), (0, 0, 0, 1)], 2),
]

print("=" * 78)
print("cycle 16 / T1: kappa オフセットの厳密確認（d=2, unramified）")
print("=" * 78)

bad_K = 0
bad_P = 0
for (name, nv, edges, p) in CASES:
    Malpha = voltage_laplacian(nv, edges)
    kX = kappa(derived_graph_laplacian(nv, edges, 1))
    if kX == 0:
        print("skip(基底が非連結): %s" % name)
        continue
    print("\n--- %s" % name)
    print("    #V_X = %d, kappa_X = %d, ord_p(kappa_X) = %d, ord_p(#V_X) = %d"
          % (nv, kX, ZZ(kX).valuation(p), ZZ(nv).valuation(p)))
    print("    %3s %14s %8s %10s %10s %8s" % ("n", "ord_p(k_Xn)", "S_n", "(K)予測", "", "(P)予測"))
    for n in range(0, 4):
        N = p**n
        if nv * N * N > 160:
            break
        kn = kappa(derived_graph_laplacian(nv, edges, N))
        if kn == 0:
            print("    n=%d: X_n が非連結（kappa=0）。スキップ" % n)
            continue
        ordk = ZZ(kn).valuation(p)
        S = S_n_exact(Malpha, N, p)
        predK = S - 2 * n + ZZ(kX).valuation(p)
        predP = predK - ZZ(nv).valuation(p)
        if predK != ordk:
            bad_K += 1
        if predP != ordk:
            bad_P += 1
        print("    %3d %14d %8d %10d %s %8d %s"
              % (n, ordk, S, predK, "OK" if predK == ordk else "NG",
                 predP, "OK" if predP == ordk else "NG"))

print("\n" + "=" * 78)
print("不一致件数:  (K) Kataoka Prop 4.4 形 = %d 件   (P) 論文 001 現行形 = %d 件" % (bad_K, bad_P))
print("=" * 78)
